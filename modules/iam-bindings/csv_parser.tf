locals {
  # 入力ファイルパスの処理
  legacy_csv_file = var.csv_file_path != "" ? [var.csv_file_path] : []
  explicit_csv_files = var.csv_file_paths
  
  # ディレクトリとパターンから一致するファイルを検索
  directory_csv_files = var.csv_directory != "" ? fileset(var.csv_directory, var.csv_file_pattern) : []
  directory_csv_paths = [for file in local.directory_csv_files : "${var.csv_directory}/${file}"]
  
  # すべてのCSVファイルパスを統合
  all_csv_paths = distinct(concat(local.legacy_csv_file, local.explicit_csv_files, local.directory_csv_paths))
  
  # CSVファイルごとにコンテンツを読み込み
  csv_contents = {
    for path in local.all_csv_paths : path => file(path)
  }
  
  # 各CSVファイルを解析
  parsed_csv_files = {
    for path, content in local.csv_contents : path => {
      lines           = split("\n", content)
      header_line     = split("\n", content)[0]
      body_lines      = [for line in slice(split("\n", content), 1, length(split("\n", content))) : line if trimspace(line) != ""]
      header_fields   = split(var.csv_delimiter, split("\n", content)[0])
    }
  }
  
  # 各CSVファイルの各行をMapに変換
  csv_rows_by_file = {
    for path, parsed in local.parsed_csv_files : path => [
      for line in parsed.body_lines : {
        for idx, field in split(var.csv_delimiter, line) :
        parsed.header_fields[idx] => trimspace(field)
        if idx < length(parsed.header_fields)
      }
    ]
  }
  
  # すべてのCSVファイルの行を統合
  all_csv_rows = flatten([
    for path, rows in local.csv_rows_by_file : rows
  ])
  
  # IAMバインディングの生成
  iam_bindings = [
    for row in local.all_csv_rows : {
      user         = row["user"]
      member_type  = can(regex("^.+@.+\\..+$", row["user"])) ? "user" : "serviceAccount"
      member       = can(regex("^.+@.+\\..+$", row["user"])) ? "user:${row["user"]}" : "serviceAccount:${row["user"]}"
      ancestor     = row["ancestor_path"]
      name         = row["name"]
      asset_type   = row["asset_type"]
      role         = row["role"]
    }
  ]
  
  # アセットタイプごとにグループ化
  bindings_by_asset_and_role = {
    for binding in local.iam_bindings :
    "${binding.name}|${binding.role}" => {
      name   = binding.name
      role   = binding.role
      members = [binding.member]
    }...
  }
  
  # 同じアセットとロールを持つバインディングをマージ
  merged_bindings = {
    for key, bindings in local.bindings_by_asset_and_role :
    key => {
      name    = bindings[0].name
      role    = bindings[0].role
      members = distinct(flatten([for binding in bindings : binding.members]))
    }
  }
  
  # アセットタイプに基づいたリソースパスの抽出
  resource_bindings = {
    for key, binding in local.merged_bindings :
    key => {
      resource_type = split("/", binding.name)[3] # //service.googleapis.com/path/to/resourceから「path/to/resource」を抽出
      name          = binding.name
      role          = binding.role
      members       = binding.members
    }
  }
} 