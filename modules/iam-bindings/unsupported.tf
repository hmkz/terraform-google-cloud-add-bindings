# サポートされていないリソースタイプの処理
locals {
  unsupported_bindings = {
    for key, binding in local.resource_bindings :
    key => binding
    if !can(regex("^//cloudresourcemanager\\.googleapis\\.com/projects/([^/]+)$", binding.name)) &&
       !can(regex("^//cloudresourcemanager\\.googleapis\\.com/folders/([^/]+)$", binding.name)) &&
       !can(regex("^//cloudresourcemanager\\.googleapis\\.com/organizations/([^/]+)$", binding.name)) &&
       !can(regex("^//storage\\.googleapis\\.com/projects/_/buckets/([^/]+)$", binding.name)) &&
       !can(regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)$", binding.name)) &&
       !can(regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/tables/([^/]+)$", binding.name)) &&
       !can(regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/models/([^/]+)$", binding.name)) &&
       !can(regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)$", binding.name)) &&
       !can(regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/tables/([^/]+)$", binding.name)) &&
       !can(regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/appProfiles/([^/]+)$", binding.name)) &&
       !can(regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", binding.name)) &&
       !can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/topics/([^/]+)$", binding.name)) &&
       !can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/subscriptions/([^/]+)$", binding.name)) &&
       !can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/schemas/([^/]+)$", binding.name)) &&
       !can(regex("^//artifactregistry\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/repositories/([^/]+)$", binding.name)) &&
       !can(regex("^//container\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/clusters/([^/]+)$", binding.name)) &&
       !can(regex("^//iam\\.googleapis\\.com/projects/([^/]+)/serviceAccounts/([^/]+)$", binding.name)) &&
       !can(regex("^//iam\\.googleapis\\.com/projects/([^/]+)/roles/([^/]+)$", binding.name)) &&
       !can(regex("^//iam\\.googleapis\\.com/organizations/([^/]+)/roles/([^/]+)$", binding.name)) &&
       !can(regex("^//orgpolicy\\.googleapis\\.com/projects/([^/]+)/policies/([^/]+)$", binding.name)) &&
       !can(regex("^//orgpolicy\\.googleapis\\.com/organizations/([^/]+)/policies/([^/]+)$", binding.name)) &&
       !can(regex("^//orgpolicy\\.googleapis\\.com/folders/([^/]+)/policies/([^/]+)$", binding.name)) &&
       !can(regex("^//orgpolicy\\.googleapis\\.com/organizations/([^/]+)/customConstraints/([^/]+)$", binding.name))
  }
}

# 未サポートリソースの警告を出力するためのNull Resource
resource "null_resource" "unsupported_resource_warning" {
  for_each = local.unsupported_bindings
  
  triggers = {
    resource_name = each.value.name
    role          = each.value.role
    members       = join(",", each.value.members)
  }
  
  provisioner "local-exec" {
    command = "echo 'WARNING: Unsupported resource type for IAM binding: ${each.value.name} with role ${each.value.role} and members ${join(",", each.value.members)}'"
  }
} 