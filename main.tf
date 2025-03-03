provider "google" {
  # プロバイダの設定
  # project = "your-project-id"
  # region  = "us-central1"
  # zone    = "us-central1-a"
}

provider "google-beta" {
  # プロバイダの設定
  # project = "your-project-id"
  # region  = "us-central1"
  # zone    = "us-central1-a"
}

module "iam_bindings" {
  source = "./modules/iam-bindings"
  
  # 方法1: 単一のCSVファイルを指定（後方互換性のため）
  #csv_file_path = "test.csv"
  
  # 方法2: 複数のCSVファイルを明示的に指定
  # csv_file_paths = [
  #   "path/to/file1.csv",
  #   "path/to/file2.csv",
  #   "path/to/file3.csv"
  # ]
  
  # 方法3: ディレクトリ内のすべてのCSVファイルを処理
  csv_directory = "./binding_data/"
  csv_file_pattern = "*.csv"  # デフォルトは "*.csv"
  
  # CSVの区切り文字（デフォルトはカンマ）
  csv_delimiter = ","
  
  # デフォルトのプロジェクトID（オプション）
  # default_project_id = "your-default-project-id"
  
  # サービスアカウントの模倣（オプション）
  # service_account_impersonation = true
  # impersonation_service_account = "your-service-account@your-project-id.iam.gserviceaccount.com"
}

# 出力の表示
output "project_iam_bindings" {
  description = "適用されたプロジェクトIAMバインディング"
  value       = module.iam_bindings.project_iam_bindings
}

output "bucket_iam_bindings" {
  description = "適用されたバケットIAMバインディング"
  value       = module.iam_bindings.bucket_iam_bindings
}

output "dataset_iam_bindings" {
  description = "適用されたBigQueryデータセットIAMバインディング"
  value       = module.iam_bindings.dataset_iam_bindings
}

output "unsupported_resource_bindings" {
  description = "サポートされていないリソースタイプに対するIAMバインディング"
  value       = module.iam_bindings.unsupported_resource_bindings
}

output "processed_bindings_count" {
  description = "処理されたIAMバインディングの総数"
  value       = module.iam_bindings.processed_bindings_count
}

output "supported_bindings_count" {
  description = "サポートされているIAMバインディングの数"
  value       = module.iam_bindings.supported_bindings_count
}

output "unsupported_bindings_count" {
  description = "サポートされていないIAMバインディングの数"
  value       = module.iam_bindings.unsupported_bindings_count
} 