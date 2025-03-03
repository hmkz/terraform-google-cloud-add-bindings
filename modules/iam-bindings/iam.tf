# IAM関連のIAMバインディング
# IAM ServiceAccountのIAMバインディング
resource "google_service_account_iam_binding" "service_account_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//iam\\.googleapis\\.com/projects/([^/]+)/serviceAccounts/([^/]+)$", binding.name))
  }
  
  service_account_id = "projects/${regex("^//iam\\.googleapis\\.com/projects/([^/]+)/serviceAccounts/([^/]+)$", each.value.name)[0]}/serviceAccounts/${regex("^//iam\\.googleapis\\.com/projects/([^/]+)/serviceAccounts/([^/]+)$", each.value.name)[1]}"
  role               = each.value.role
  members            = each.value.members
}

# IAM CustomRoleのIAMバインディング（プロジェクトレベル）
resource "google_project_iam_binding" "custom_role_project_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//iam\\.googleapis\\.com/projects/([^/]+)/roles/([^/]+)$", binding.name))
  }
  
  project = regex("^//iam\\.googleapis\\.com/projects/([^/]+)/roles/([^/]+)$", each.value.name)[0]
  role    = "projects/${regex("^//iam\\.googleapis\\.com/projects/([^/]+)/roles/([^/]+)$", each.value.name)[0]}/roles/${regex("^//iam\\.googleapis\\.com/projects/([^/]+)/roles/([^/]+)$", each.value.name)[1]}"
  members = each.value.members
}

# IAM CustomRoleのIAMバインディング（組織レベル）
resource "google_organization_iam_binding" "custom_role_org_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//iam\\.googleapis\\.com/organizations/([^/]+)/roles/([^/]+)$", binding.name))
  }
  
  org_id  = regex("^//iam\\.googleapis\\.com/organizations/([^/]+)/roles/([^/]+)$", each.value.name)[0]
  role    = "organizations/${regex("^//iam\\.googleapis\\.com/organizations/([^/]+)/roles/([^/]+)$", each.value.name)[0]}/roles/${regex("^//iam\\.googleapis\\.com/organizations/([^/]+)/roles/([^/]+)$", each.value.name)[1]}"
  members = each.value.members
} 