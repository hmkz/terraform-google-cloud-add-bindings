# BigQuery関連のIAMバインディング
# BigQueryデータセットのIAMバインディング
resource "google_bigquery_dataset_iam_binding" "dataset_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)$", binding.name))
  }
  
  project    = regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)$", each.value.name)[0]
  dataset_id = regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)$", each.value.name)[1]
  role       = each.value.role
  members    = each.value.members
}

# BigQueryテーブルのIAMバインディング
resource "google_bigquery_table_iam_binding" "table_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/tables/([^/]+)$", binding.name))
  }
  
  project    = regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/tables/([^/]+)$", each.value.name)[0]
  dataset_id = regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/tables/([^/]+)$", each.value.name)[1]
  table_id   = regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/tables/([^/]+)$", each.value.name)[2]
  role       = each.value.role
  members    = each.value.members
}

# BigQuery ModelのIAMバインディング
resource "google_bigquery_table_iam_binding" "model_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/models/([^/]+)$", binding.name))
  }
  
  project    = regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/models/([^/]+)$", each.value.name)[0]
  dataset_id = regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/models/([^/]+)$", each.value.name)[1]
  table_id   = regex("^//bigquery\\.googleapis\\.com/projects/([^/]+)/datasets/([^/]+)/models/([^/]+)$", each.value.name)[2]
  role       = each.value.role
  members    = each.value.members
} 