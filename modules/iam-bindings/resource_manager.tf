# Resource Manager関連のIAMバインディング
# プロジェクトレベルのIAMバインディング
resource "google_project_iam_binding" "project_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if binding.resource_type == "projects" && can(regex("^//cloudresourcemanager\\.googleapis\\.com/projects/([^/]+)$", binding.name))
  }
  
  project = regex("^//cloudresourcemanager\\.googleapis\\.com/projects/([^/]+)$", each.value.name)[0]
  role    = each.value.role
  members = each.value.members
}

# フォルダレベルのIAMバインディング
resource "google_folder_iam_binding" "folder_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//cloudresourcemanager\\.googleapis\\.com/folders/([^/]+)$", binding.name))
  }
  
  folder  = "folders/${regex("^//cloudresourcemanager\\.googleapis\\.com/folders/([^/]+)$", each.value.name)[0]}"
  role    = each.value.role
  members = each.value.members
}

# 組織レベルのIAMバインディング
resource "google_organization_iam_binding" "organization_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//cloudresourcemanager\\.googleapis\\.com/organizations/([^/]+)$", binding.name))
  }
  
  org_id  = regex("^//cloudresourcemanager\\.googleapis\\.com/organizations/([^/]+)$", each.value.name)[0]
  role    = each.value.role
  members = each.value.members
} 