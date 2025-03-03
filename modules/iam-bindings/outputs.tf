output "project_iam_bindings" {
  description = "適用されたプロジェクトIAMバインディングのリスト"
  value       = google_project_iam_binding.project_iam_bindings
}

output "folder_iam_bindings" {
  description = "適用されたフォルダIAMバインディングのリスト"
  value       = google_folder_iam_binding.folder_iam_bindings
}

output "organization_iam_bindings" {
  description = "適用された組織IAMバインディングのリスト"
  value       = google_organization_iam_binding.organization_iam_bindings
}

output "bucket_iam_bindings" {
  description = "適用されたバケットIAMバインディングのリスト"
  value       = google_storage_bucket_iam_binding.bucket_iam_bindings
}

output "dataset_iam_bindings" {
  description = "適用されたBigQueryデータセットIAMバインディングのリスト"
  value       = google_bigquery_dataset_iam_binding.dataset_iam_bindings
}

output "table_iam_bindings" {
  description = "適用されたBigQueryテーブルIAMバインディングのリスト"
  value       = google_bigquery_table_iam_binding.table_iam_bindings
}

output "model_iam_bindings" {
  description = "適用されたBigQueryモデルIAMバインディングのリスト"
  value       = google_bigquery_table_iam_binding.model_iam_bindings
}

output "routine_iam_bindings" {
  description = "適用されたBigQueryルーチンIAMバインディングのリスト"
  value       = {}
}

output "bigtable_instance_iam_bindings" {
  description = "適用されたBigtableインスタンスIAMバインディングのリスト"
  value       = google_bigtable_instance_iam_binding.bigtable_instance_iam_bindings
}

output "bigtable_table_iam_bindings" {
  description = "適用されたBigtableテーブルIAMバインディングのリスト"
  value       = google_bigtable_table_iam_binding.bigtable_table_iam_bindings
}

output "bigtable_app_profile_iam_bindings" {
  description = "適用されたBigtableアプリプロファイルIAMバインディングのリスト"
  value       = google_bigtable_instance_iam_binding.bigtable_app_profile_iam_bindings
}

output "function_iam_bindings" {
  description = "適用されたCloud FunctionsのIAMバインディングのリスト"
  value       = google_cloudfunctions_function_iam_binding.function_iam_bindings
}

output "pubsub_topic_iam_bindings" {
  description = "適用されたPub/SubトピックIAMバインディングのリスト"
  value       = google_pubsub_topic_iam_binding.topic_iam_bindings
}

output "pubsub_subscription_iam_bindings" {
  description = "適用されたPub/SubサブスクリプションIAMバインディングのリスト"
  value       = google_pubsub_subscription_iam_binding.subscription_iam_bindings
}

output "pubsub_schema_iam_bindings" {
  description = "適用されたPub/SubスキーマIAMバインディングのリスト"
  value       = google_pubsub_schema_iam_binding.schema_iam_bindings
}

output "artifact_registry_repository_iam_bindings" {
  description = "適用されたArtifact Registry リポジトリIAMバインディングのリスト"
  value       = google_artifact_registry_repository_iam_binding.repository_iam_bindings
}

output "gke_cluster_iam_bindings" {
  description = "適用されたGKEクラスターIAMバインディングのリスト"
  value       = {}
}

output "service_account_iam_bindings" {
  description = "適用されたサービスアカウントIAMバインディングのリスト"
  value       = google_service_account_iam_binding.service_account_iam_bindings
}

output "custom_role_project_iam_bindings" {
  description = "適用されたIAMカスタムロール（プロジェクトレベル）IAMバインディングのリスト"
  value       = google_project_iam_binding.custom_role_project_iam_bindings
}

output "custom_role_org_iam_bindings" {
  description = "適用されたIAMカスタムロール（組織レベル）IAMバインディングのリスト"
  value       = google_organization_iam_binding.custom_role_org_iam_bindings
}

output "org_policy_project_iam_bindings" {
  description = "適用された組織ポリシー（プロジェクトレベル）IAMバインディングのリスト"
  value       = google_project_iam_binding.org_policy_project_iam_bindings
}

output "org_policy_org_iam_bindings" {
  description = "適用された組織ポリシー（組織レベル）IAMバインディングのリスト"
  value       = google_organization_iam_binding.org_policy_org_iam_bindings
}

output "org_policy_folder_iam_bindings" {
  description = "適用された組織ポリシー（フォルダレベル）IAMバインディングのリスト"
  value       = google_folder_iam_binding.org_policy_folder_iam_bindings
}

output "org_policy_constraint_iam_bindings" {
  description = "適用された組織ポリシーカスタム制約IAMバインディングのリスト"
  value       = google_organization_iam_binding.org_policy_constraint_iam_bindings
}

output "unsupported_resource_bindings" {
  description = "サポートされていないリソースタイプに対するIAMバインディングのリスト"
  value       = local.unsupported_bindings
}

output "processed_bindings_count" {
  description = "処理されたIAMバインディングの総数"
  value       = length(local.iam_bindings)
}

output "supported_bindings_count" {
  description = "サポートされているIAMバインディングの数"
  value       = (
    length(google_project_iam_binding.project_iam_bindings) +
    length(google_folder_iam_binding.folder_iam_bindings) +
    length(google_organization_iam_binding.organization_iam_bindings) +
    length(google_storage_bucket_iam_binding.bucket_iam_bindings) +
    length(google_bigquery_dataset_iam_binding.dataset_iam_bindings) +
    length(google_bigquery_table_iam_binding.table_iam_bindings) +
    length(google_bigquery_table_iam_binding.model_iam_bindings) +
    length(google_bigtable_instance_iam_binding.bigtable_instance_iam_bindings) +
    length(google_bigtable_table_iam_binding.bigtable_table_iam_bindings) +
    length(google_bigtable_instance_iam_binding.bigtable_app_profile_iam_bindings) +
    length(google_cloudfunctions_function_iam_binding.function_iam_bindings) +
    length(google_pubsub_topic_iam_binding.topic_iam_bindings) +
    length(google_pubsub_subscription_iam_binding.subscription_iam_bindings) +
    length(google_pubsub_schema_iam_binding.schema_iam_bindings) +
    length(google_artifact_registry_repository_iam_binding.repository_iam_bindings) +
    length(google_service_account_iam_binding.service_account_iam_bindings) +
    length(google_project_iam_binding.custom_role_project_iam_bindings) +
    length(google_organization_iam_binding.custom_role_org_iam_bindings) +
    length(google_project_iam_binding.org_policy_project_iam_bindings) +
    length(google_organization_iam_binding.org_policy_org_iam_bindings) +
    length(google_folder_iam_binding.org_policy_folder_iam_bindings) +
    length(google_organization_iam_binding.org_policy_constraint_iam_bindings)
  )
}

output "unsupported_bindings_count" {
  description = "サポートされていないIAMバインディングの数"
  value       = length(local.unsupported_bindings)
}

output "processed_csv_files" {
  description = "処理されたCSVファイルのリスト"
  value       = local.all_csv_paths
}

output "bindings_by_csv_file" {
  description = "CSVファイルごとの処理されたバインディング数"
  value = {
    for path, rows in local.csv_rows_by_file :
    path => length(rows)
  }
} 