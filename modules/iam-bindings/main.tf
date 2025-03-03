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

# Bigtable InstanceのIAMバインディング
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

# Bigtable TableのIAMバインディング
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

# Bigtable AppProfileのIAMバインディング（注: このリソースに直接対応するTerraformリソースが存在しない場合があります）
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

# Cloud FunctionのIAMバインディング (1st gen)
resource "google_cloudfunctions_function_iam_binding" "function_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", binding.name)) &&
       !contains(split("/", binding.name), "v2")  # v2を含まないパスのみ対象
  }
  
  project        = regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", each.value.name)[0]
  region         = regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", each.value.name)[1]
  cloud_function = regex("^//cloudfunctions\\.googleapis\\.com/projects/([^/]+)/locations/([^/]+)/functions/([^/]+)$", each.value.name)[2]
  role           = each.value.role
  members        = each.value.members
}

# Pub/Sub TopicのIAMバインディング
resource "google_pubsub_topic_iam_binding" "topic_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/topics/([^/]+)$", binding.name))
  }
  
  project = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/topics/([^/]+)$", each.value.name)[0]
  topic   = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/topics/([^/]+)$", each.value.name)[1]
  role    = each.value.role
  members = each.value.members
}

# Pub/Sub SubscriptionのIAMバインディング
resource "google_pubsub_subscription_iam_binding" "subscription_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/subscriptions/([^/]+)$", binding.name))
  }
  
  project      = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/subscriptions/([^/]+)$", each.value.name)[0]
  subscription = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/subscriptions/([^/]+)$", each.value.name)[1]
  role         = each.value.role
  members      = each.value.members
}

# Pub/Sub SchemaのIAMバインディング
resource "google_pubsub_schema_iam_binding" "schema_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/schemas/([^/]+)$", binding.name))
  }
  
  project = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/schemas/([^/]+)$", each.value.name)[0]
  schema  = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/schemas/([^/]+)$", each.value.name)[1]
  role    = each.value.role
  members = each.value.members
}

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

# 組織ポリシーのカスタム制約のIAMバインディング
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

# サポートされていないバインディングのチェック
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