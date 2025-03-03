# Storage関連のIAMバインディング
# ストレージバケットのIAMバインディング
resource "google_storage_bucket_iam_binding" "bucket_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//storage\\.googleapis\\.com/projects/_/buckets/([^/]+)$", binding.name))
  }
  
  bucket  = regex("^//storage\\.googleapis\\.com/projects/_/buckets/([^/]+)$", each.value.name)[0]
  role    = each.value.role
  members = each.value.members
} 