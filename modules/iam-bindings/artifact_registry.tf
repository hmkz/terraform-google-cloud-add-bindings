# Artifact Registry関連のIAMバインディング
# Artifact Registry RepositoryのIAMバインディング
resource "google_artifact_registry_repository_iam_binding" "repository_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//artifactregistry\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/repositories/([^/]+)$", binding.name))
  }
  
  project    = regex("^//artifactregistry\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/repositories/([^/]+)$", each.value.name)[0]
  location   = regex("^//artifactregistry\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/repositories/([^/]+)$", each.value.name)[1]
  repository = regex("^//artifactregistry\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/repositories/([^/]+)$", each.value.name)[2]
  role       = each.value.role
  members    = each.value.members
} 