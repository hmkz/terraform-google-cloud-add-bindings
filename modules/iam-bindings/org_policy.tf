# 組織ポリシー関連のIAMバインディング
# 組織ポリシーのIAMバインディング（プロジェクトレベル）
resource "google_project_iam_binding" "org_policy_project_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//orgpolicy\\.googleapis\\.com/projects/([^/]+)/policies/([^/]+)$", binding.name))
  }
  
  project = regex("^//orgpolicy\\.googleapis\\.com/projects/([^/]+)/policies/([^/]+)$", each.value.name)[0]
  role    = each.value.role
  members = each.value.members
}

# 組織ポリシーのIAMバインディング（組織レベル）
resource "google_organization_iam_binding" "org_policy_org_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//orgpolicy\\.googleapis\\.com/organizations/([^/]+)/policies/([^/]+)$", binding.name))
  }
  
  org_id  = regex("^//orgpolicy\\.googleapis\\.com/organizations/([^/]+)/policies/([^/]+)$", each.value.name)[0]
  role    = each.value.role
  members = each.value.members
}

# 組織ポリシーのIAMバインディング（フォルダレベル）
resource "google_folder_iam_binding" "org_policy_folder_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//orgpolicy\\.googleapis\\.com/folders/([^/]+)/policies/([^/]+)$", binding.name))
  }
  
  folder  = "folders/${regex("^//orgpolicy\\.googleapis\\.com/folders/([^/]+)/policies/([^/]+)$", each.value.name)[0]}"
  role    = each.value.role
  members = each.value.members
}

# 組織ポリシーカスタム制約のIAMバインディング
resource "google_organization_iam_binding" "org_policy_constraint_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//orgpolicy\\.googleapis\\.com/organizations/([^/]+)/customConstraints/([^/]+)$", binding.name))
  }
  
  org_id  = regex("^//orgpolicy\\.googleapis\\.com/organizations/([^/]+)/customConstraints/([^/]+)$", each.value.name)[0]
  role    = each.value.role
  members = each.value.members
} 