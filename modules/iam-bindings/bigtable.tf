# Bigtable関連のIAMバインディング
# Bigtableインスタンスのバインディング
resource "google_bigtable_instance_iam_binding" "bigtable_instance_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)$", binding.name))
  }
  
  project  = regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)$", each.value.name)[0]
  instance = regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)$", each.value.name)[1]
  role     = each.value.role
  members  = each.value.members
}

# Bigtableテーブルのバインディング
resource "google_bigtable_table_iam_binding" "bigtable_table_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/tables/([^/]+)$", binding.name))
  }
  
  project  = regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/tables/([^/]+)$", each.value.name)[0]
  instance = regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/tables/([^/]+)$", each.value.name)[1]
  table    = regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/tables/([^/]+)$", each.value.name)[2]
  role     = each.value.role
  members  = each.value.members
}

# Bigtable AppProfileのバインディング
resource "google_bigtable_instance_iam_binding" "bigtable_app_profile_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/appProfiles/([^/]+)$", binding.name))
  }
  
  project  = regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/appProfiles/([^/]+)$", each.value.name)[0]
  instance = regex("^//bigtable\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)/appProfiles/([^/]+)$", each.value.name)[1]
  role     = each.value.role
  members  = each.value.members
} 