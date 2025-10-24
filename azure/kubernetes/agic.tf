data "azurerm_subscription" "current" {}

resource "azurerm_user_assigned_identity" "agic" {
  name                = "${var.name_prefix}-agic-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_federated_identity_credential" "agic" {
  name                = "${var.name_prefix}-agic-federated-credential"
  resource_group_name = var.resource_group_name
  parent_id           = azurerm_user_assigned_identity.agic.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.oidc_issuer_url
  subject             = "system:serviceaccount:${kubernetes_namespace.agic.metadata[0].name}:agic-sa-ingress-azure"
}

resource "azurerm_role_assignment" "agic_appgw_contributor" {
  scope                = var.appgw_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.agic.principal_id
}

resource "azurerm_role_assignment" "agic_rg_reader" {
  scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.agic.principal_id
}

resource "azurerm_role_assignment" "agic_subnet_contributor" {
  scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/pw-vnet/subnets/pw-appgw-subnet"
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.agic.principal_id
}

resource "kubernetes_namespace" "agic" {
  metadata {
    name = "agic"
  }
}

resource "helm_release" "agic" {
  name       = "agic"
  repository = "oci://mcr.microsoft.com/azure-application-gateway/charts"
  chart      = "ingress-azure"
  namespace  = kubernetes_namespace.agic.metadata[0].name
  version    = "1.8.1"

  atomic  = true
  timeout = 600

  values = [yamlencode({
    appgw = {
      applicationGatewayID = var.appgw_id
      usePrivateIP         = false
    }

    armAuth = {
      type             = "workloadIdentity"
      identityClientID = azurerm_user_assigned_identity.agic.client_id
    }

    rbac = {
      enabled = true
    }

    aksClusterConfiguration = {
      apiServerAddress = var.aks_cluster_name
    }

    kubernetes = {
      watchNamespace = ""
    }
  })]

  depends_on = [
    azurerm_federated_identity_credential.agic,
    azurerm_role_assignment.agic_appgw_contributor,
    azurerm_role_assignment.agic_rg_reader,
    azurerm_role_assignment.agic_subnet_contributor
  ]
}

