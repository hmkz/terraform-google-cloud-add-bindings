# Google Cloud IAMバインディング Terraformモジュール

このTerraformプロジェクトは、CSVファイルから読み込んだ情報に基づいて、Google CloudのIAMユーザーやサービスアカウントにロールをバインドする仕組みを提供します。

## 機能

- CSVまたはTSVファイルからユーザー/サービスアカウント、アセット、ロールの情報を読み込む
- **複数のCSVファイルを同時に処理可能**（ファイルリストの指定またはディレクトリ指定）
- **多様なGoogle Cloudリソースタイプに対応**（プロジェクト、フォルダ、組織、ストレージ、BigQuery、Bigtable、GKE、Cloud Functions、Pub/Sub、Artifact Registry、IAM、組織ポリシーなど）
- 同じリソースとロールに対する複数のメンバーをマージして効率的に適用
- サポートされていないリソースタイプに対する警告メカニズム

## 要件

- Terraform 1.0.0以上
- Google Cloudプロバイダー 4.0.0以上
- Google Cloud Betaプロバイダー 4.0.0以上
- CSVまたはTSVファイル（指定の形式に従ったもの）

## 使い方

### CSVファイルの準備

以下の形式でCSVまたはTSVファイルを作成します：

```csv
user,ancestor_path,name,asset_type,role
user1@example.com,my-project-123,//cloudresourcemanager.googleapis.com/projects/my-project-123,cloudresourcemanager.googleapis.com/Project,roles/viewer
user1@example.com,my-project-123,//storage.googleapis.com/projects/_/buckets/my-bucket,storage.googleapis.com/Bucket,roles/storage.objectViewer
user2@example.com,my-project-123,//bigquery.googleapis.com/projects/my-project-123/datasets/my_dataset,bigquery.googleapis.com/Dataset,roles/bigquery.dataViewer
```

各カラムの説明：
- `user`: ユーザーメールアドレスまたはサービスアカウント
- `ancestor_path`: プロジェクトまたは組織名
- `name`: アセット名（Google Cloud Asset Inventoryの形式に準拠）
- `asset_type`: アセットタイプ
- `role`: 割り当てるIAMロール

### メインモジュールの利用

モジュールでは、以下の3つの方法でCSVファイルを指定できます：

#### 方法1: 単一のCSVファイルを指定（後方互換性のため）

```hcl
module "iam_bindings" {
  source = "./modules/iam-bindings"
  
  # 単一のCSVファイルのパスを指定
  csv_file_path = "path/to/your/input.csv"
  
  # CSVの区切り文字（デフォルトはカンマ、TSVの場合は"\t"を指定）
  csv_delimiter = ","
}
```

#### 方法2: 複数のCSVファイルを明示的に指定

```hcl
module "iam_bindings" {
  source = "./modules/iam-bindings"
  
  # 複数のCSVファイルを明示的に指定
  csv_file_paths = [
    "path/to/file1.csv",
    "path/to/file2.csv",
    "path/to/file3.csv"
  ]
  
  # CSVの区切り文字
  csv_delimiter = ","
}
```

#### 方法3: ディレクトリ内のすべてのCSVファイルを処理

```hcl
module "iam_bindings" {
  source = "./modules/iam-bindings"
  
  # ディレクトリ内のすべてのCSVファイルを処理
  csv_directory = "path/to/csv_directory"
  
  # ファイルパターン（デフォルトは "*.csv"）
  csv_file_pattern = "*.csv"
  
  # CSVの区切り文字
  csv_delimiter = ","
}
```

#### その他のオプション

```hcl
module "iam_bindings" {
  source = "./modules/iam-bindings"
  
  # CSVファイルの指定（上記3つの方法のいずれか）
  
  # オプション: デフォルトのプロジェクトID
  default_project_id = "your-default-project-id"
  
  # オプション: サービスアカウントの模倣
  service_account_impersonation = true
  impersonation_service_account = "your-service-account@your-project-id.iam.gserviceaccount.com"
}
```

## サポートされているリソースタイプ

現在、以下のリソースタイプのIAMバインディングがサポートされています：

### Resource Manager
1. Google Cloudプロジェクト (`cloudresourcemanager.googleapis.com/Project`)
2. フォルダ (`cloudresourcemanager.googleapis.com/Folder`)
3. 組織 (`cloudresourcemanager.googleapis.com/Organization`)

### Storage
4. Google Cloud Storageバケット (`storage.googleapis.com/Bucket`)

### BigQuery
5. BigQueryデータセット (`bigquery.googleapis.com/Dataset`)
6. BigQueryテーブル (`bigquery.googleapis.com/Table`)
7. BigQueryモデル (`bigquery.googleapis.com/Model`)
8. BigQueryルーチン (`bigquery.googleapis.com/Routine`)

### Bigtable
9. Bigtableインスタンス (`bigtable.googleapis.com/Instance`)
10. Bigtableテーブル (`bigtable.googleapis.com/Table`)
11. Bigtableアプリケーションプロファイル (`bigtable.googleapis.com/AppProfile`)

### Cloud Functions
12. Cloud Functions (1st gen) (`cloudfunctions.googleapis.com/Function`)

### Pub/Sub
13. Pub/Subトピック (`pubsub.googleapis.com/Topic`)
14. Pub/Subサブスクリプション (`pubsub.googleapis.com/Subscription`)
15. Pub/Subスキーマ (`pubsub.googleapis.com/Schema`)

### Artifact Registry
16. Artifact Registryリポジトリ (`artifactregistry.googleapis.com/Repository`)

### Google Kubernetes Engine (GKE)
17. GKEクラスター (`container.googleapis.com/Cluster`)

### IAM
18. サービスアカウント (`iam.googleapis.com/ServiceAccount`)
19. カスタムロール（プロジェクトレベル） (`iam.googleapis.com/Role`)
20. カスタムロール（組織レベル） (`iam.googleapis.com/Role`)

### 組織ポリシー
21. 組織ポリシー（プロジェクトレベル） (`orgpolicy.googleapis.com/Policy`)
22. 組織ポリシー（組織レベル） (`orgpolicy.googleapis.com/Policy`)
23. 組織ポリシー（フォルダレベル） (`orgpolicy.googleapis.com/Policy`)
24. カスタム制約 (`orgpolicy.googleapis.com/Constraint`)

その他のリソースタイプは未サポートとして処理され、警告が出力されます。必要に応じて、`main.tf`ファイルに新しいリソースタイプのサポートを追加できます。

## アセット名とアセットタイプについて

Google Cloud Asset Inventoryのアセット名とアセットタイプの詳細については、以下のドキュメントを参照してください：

- [アセット名について](https://cloud.google.com/asset-inventory/docs/asset-names?hl=ja)
- [サポートされているアセットタイプ](https://cloud.google.com/asset-inventory/docs/supported-asset-types?hl=ja)

## 出力

このモジュールは以下の出力を提供します：

### 主要な出力
- `processed_csv_files`: 処理されたCSVファイルのリスト
- `bindings_by_csv_file`: CSVファイルごとの処理されたバインディング数
- `processed_bindings_count`: 処理されたIAMバインディングの総数
- `supported_bindings_count`: サポートされているIAMバインディングの数
- `unsupported_bindings_count`: サポートされていないIAMバインディングの数
- `unsupported_resource_bindings`: サポートされていないリソースタイプに対するIAMバインディング

### Resource Manager
- `project_iam_bindings`: プロジェクトIAMバインディング
- `folder_iam_bindings`: フォルダIAMバインディング
- `organization_iam_bindings`: 組織IAMバインディング

### Storage
- `bucket_iam_bindings`: Storageバケットバインディング

### BigQuery
- `dataset_iam_bindings`: BigQueryデータセットバインディング
- `table_iam_bindings`: BigQueryテーブルバインディング
- `model_iam_bindings`: BigQueryモデルバインディング
- `routine_iam_bindings`: BigQueryルーチンバインディング

### Bigtable
- `bigtable_instance_iam_bindings`: Bigtableインスタンスバインディング
- `bigtable_table_iam_bindings`: Bigtableテーブルバインディング
- `bigtable_app_profile_iam_bindings`: Bigtableアプリプロファイルバインディング

### Cloud Functions
- `function_iam_bindings`: Cloud Functionsバインディング

### Pub/Sub
- `pubsub_topic_iam_bindings`: Pub/Subトピックバインディング
- `pubsub_subscription_iam_bindings`: Pub/Subサブスクリプションバインディング
- `pubsub_schema_iam_bindings`: Pub/Subスキーマバインディング

### Artifact Registry
- `artifact_registry_repository_iam_bindings`: Artifact Registryリポジトリバインディング

### Google Kubernetes Engine
- `gke_cluster_iam_bindings`: GKEクラスターバインディング

### IAM
- `service_account_iam_bindings`: サービスアカウントバインディング
- `custom_role_project_iam_bindings`: カスタムロール（プロジェクトレベル）バインディング
- `custom_role_org_iam_bindings`: カスタムロール（組織レベル）バインディング

### 組織ポリシー
- `org_policy_project_iam_bindings`: 組織ポリシー（プロジェクトレベル）バインディング
- `org_policy_org_iam_bindings`: 組織ポリシー（組織レベル）バインディング
- `org_policy_folder_iam_bindings`: 組織ポリシー（フォルダレベル）バインディング
- `org_policy_constraint_iam_bindings`: 組織ポリシーカスタム制約バインディング

## カスタマイズ

新しいリソースタイプのサポートを追加するには、`modules/iam-bindings/main.tf`ファイルを編集して、そのリソースタイプに対応するIAMバインディングリソースを追加します。

```hcl
# 例: Cloud SQLインスタンスのサポートを追加
resource "google_sql_database_instance_iam_binding" "sql_instance_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//sqladmin\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)$", binding.name))
  }
  
  project  = regex("^//sqladmin\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)$", each.value.name)[0]
  instance = regex("^//sqladmin\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)$", each.value.name)[1]
  role     = each.value.role
  members  = each.value.members
}
```

同時に、未サポートリソースのフィルタリングにも新しいパターンを追加する必要があります：

```hcl
locals {
  unsupported_bindings = {
    for key, binding in local.resource_bindings :
    key => binding
    if !can(regex("^//cloudresourcemanager\\.googleapis\\.com/projects/([^/]+)$", binding.name)) &&
       // ... 既存のパターン ... //
       !can(regex("^//sqladmin\\.googleapis\\.com/projects/([^/]+)/instances/([^/]+)$", binding.name))
  }
}
```

## 注意事項

- このモジュールは、指定されたCSVファイルの内容に基づいてIAMバインディングを作成します。既存のIAMバインディングが上書きされる可能性があるため、注意が必要です。
- サポートされていないリソースタイプに対するバインディングはスキップされ、警告が出力されます。
- IAMロールを適用するための適切な権限が必要です。
- 複数のCSVファイルを処理する場合、それぞれのCSVファイルのヘッダー行が同じフォーマットであることを確認してください。
- 組織やフォルダレベルのリソースに対するIAMバインディングを適用する場合は、適切な権限を持つサービスアカウントを使用してください。