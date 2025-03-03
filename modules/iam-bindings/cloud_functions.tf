# Cloud Functions関連のIAMバインディング
# Cloud FunctionのIAMバインディング (1st gen)
resource "google_cloudfunctions_function_iam_binding" "function_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", binding.name))
  }
  
  project        = regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", each.value.name)[0]
  region         = regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", each.value.name)[1]
  cloud_function = regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", each.value.name)[2]
  role           = each.value.role
  members        = each.value.members
} 