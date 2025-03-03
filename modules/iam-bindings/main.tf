# Google Cloud IAMバインディングモジュール
# このファイルでは、CSVファイルからIAMバインディングを生成するための
# 基本的な処理のみを定義しています。各リソースタイプのIAMバインディングは
# そのタイプに特化したファイルに移動されています。

# CSVファイルが処理され、IAMバインディングが生成されるフローは次の通りです：
# 1. CSVファイル（単一、複数指定、またはディレクトリから一括処理）を読み込み
# 2. 各行をパースしてIAMバインディングを生成
# 3. 同じリソースとロールに対する複数のメンバーをマージ
# 4. リソースタイプごとにバインディングを適用

# このモジュールはcsv_parser.tfで定義されたローカル変数を使用します
# そこで処理されたバインディングはリソースタイプごとに別ファイルで適用されます

# モジュールの動作確認用
output "module_initialized" {
  value = "Google Cloud IAM Bindings module initialized successfully"
} 