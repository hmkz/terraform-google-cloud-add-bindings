variable "csv_file_path" {
  description = "単一のCSVファイルのパス（廃止予定、csv_file_pathsを使用してください）"
  type        = string
  default     = ""
}

variable "csv_file_paths" {
  description = "処理するCSVファイルのパスのリスト"
  type        = list(string)
  default     = []
}

variable "csv_directory" {
  description = "CSVファイルが含まれるディレクトリのパス（csv_file_pattern と組み合わせて使用）"
  type        = string
  default     = ""
}

variable "csv_file_pattern" {
  description = "CSVファイルの検索パターン（例: *.csv）"
  type        = string
  default     = "*.csv"
}

variable "csv_delimiter" {
  description = "CSVファイルの区切り文字（CSVの場合はカンマ、TSVの場合はタブ）"
  type        = string
  default     = ","
}

variable "default_project_id" {
  description = "デフォルトのプロジェクトID（CSVにプロジェクト情報がない場合に使用）"
  type        = string
  default     = ""
}

variable "service_account_impersonation" {
  description = "Terraform実行時にサービスアカウントを模倣するかどうか"
  type        = bool
  default     = false
}

variable "impersonation_service_account" {
  description = "模倣するサービスアカウント（service_account_impersonationがtrueの場合に使用）"
  type        = string
  default     = ""
} 