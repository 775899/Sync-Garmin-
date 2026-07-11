#!/bin/bash
# 从 dailysync-rev 下载所有源代码到当前目录
# 用法: 在 Sync-Garmin- 目录下执行 bash download_source.sh

set -e

BASE="https://raw.githubusercontent.com/775899/dailysync-rev/main"

echo "📦 下载 package.json ..."
curl -sfL -o package.json "$BASE/package.json"

echo "📦 下载 tsconfig.json ..."
curl -sfL -o tsconfig.json "$BASE/tsconfig.json"

echo "📦 下载 src/ 目录 ..."
mkdir -p src/sample src/utils

# src 根目录文件
for f in constant.ts export_garmin_sessions.ts index.ts rq.ts \
         sync_garmin_cn_to_global.ts sync_garmin_global_to_cn.ts \
         migrate_garmin_cn_to_global.ts migrate_garmin_global_to_cn.ts; do
    echo "  → src/$f"
    curl -sfL -o "src/$f" "$BASE/src/$f"
done

# src/sample
echo "  → src/sample/rq_res.json"
curl -sfL -o "src/sample/rq_res.json" "$BASE/src/sample/rq_res.json"

# src/utils
for f in garmin_cn.ts garmin_common.ts garmin_global.ts garmin_session_env.ts \
         google_sheets.ts number_tricks.ts runningquotient.ts sqlite.ts \
         strava.ts type.ts; do
    echo "  → src/utils/$f"
    curl -sfL -o "src/utils/$f" "$BASE/src/utils/$f"
done

echo "📦 下载 db/.gitkeep ..."
mkdir -p db
curl -sfL -o "db/.gitkeep" "$BASE/db/.gitkeep"

echo ""
echo "✅ 全部源文件下载完成!"
echo ""
echo "接下来执行:"
echo "  yarn install          # 重新生成正确的 yarn.lock"
echo "  git add -A"
echo "  git commit -m \"add source code and dependencies\""
echo "  git push"
