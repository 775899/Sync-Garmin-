# Garmin 运动数据同步工具

佳明运动数据在中国区与国际区之间同步、迁移的工具，通过 GitHub Actions 自动运行。

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/<your-username>/dailysync-rev.git
cd dailysync-rev
```

### 2. 配置 GitHub Secrets

进入仓库 **Settings → Secrets and variables → Actions**，添加所需的 Secrets。

详细清单见 [SECRETS.md](./SECRETS.md)。

### 3. 启用工作流

所有工作流默认可以通过 **Actions** 页面手动触发（`workflow_dispatch`）。

定时同步需要在 Actions 页面确认启用 Schedule 触发。

## 工作流说明

| 工作流 | 触发方式 | 说明 |
|---|---|---|
| Sync Garmin CN to Garmin Global | 每 30 分钟自动 + 手动 | 同步中国区新活动到国际区 |
| Sync Garmin Global to Garmin CN | 每 6 小时自动 + 手动 | 同步国际区新活动到中国区 |
| Migrate Garmin CN to Garmin Global | 仅手动 | 批量迁移中国区历史数据到国际区 |
| Migrate Garmin Global to Garmin CN | 仅手动 | 批量迁移国际区历史数据到中国区 |
| CI | PR / Push to main | TypeScript 类型检查 + 构建验证 |

> **重要**：不要同时开启两个同步工作流，按需选择一个方向即可。

## 相比原版的改进

### 安全性
- 移除了 `sync_cn_to_global` 的 `push` 触发器，消除自动提交导致的无限循环
- `.env` 不再提交到仓库，改用 `.env.example` 模板
- `.gitignore` 增加了 `.env` 和数据库文件排除规则

### 稳定性
- 所有工作流添加 `concurrency` 并发控制，防止任务重叠冲突
- 定时同步增加 0-120 秒随机延迟，缓解佳明 429 限流
- 同步频率从每 15 分钟调整为每 30 分钟
- `git-auto-commit` 仅在 `success()` 时执行，避免提交错误状态
- commit 消息添加 `[skip ci]` 标记，双重保险防止循环触发
- 所有工作流添加 `timeout-minutes` 超时保护

### 可维护性
- Action 版本升级：`checkout@v4`、`setup-node@v4`
- Node.js 从 18 升级到 20（18 已 EOL）
- 使用 `yarn install --frozen-lockfile` 确保依赖一致性
- 添加 Dependabot 自动检测依赖更新
- 添加 CI 工作流进行类型检查
- 添加 Bark 失败推送通知

### Docker
- 基础镜像升级到 `node:20-alpine`
- 添加 `restart: unless-stopped` 策略

## 本地运行

```bash
# 安装依赖
yarn install

# 复制环境变量模板
cp .env.example .env
# 编辑 .env 填入账号密码

# 同步中国区到国际区
yarn sync_cn

# 同步国际区到中国区
yarn sync_global

# 迁移历史数据
yarn migrate_garmin_cn_to_global
yarn migrate_garmin_global_to_cn
```

## Docker 运行

```bash
# 编辑 .env 填入配置
docker-compose up -d

# 查看日志
docker logs -f daily-sync

# 停止
docker-compose down
```

## 目录结构

```
.
├── .github/
│   ├── workflows/
│   │   ├── sync_garmin_cn_to_garmin_global.yml    # 定时同步 CN → Global
│   │   ├── sync_garmin_global_to_garmin_cn.yml    # 定时同步 Global → CN
│   │   ├── migrate_garmin_cn_to_garmin_global.yml # 手动迁移 CN → Global
│   │   ├── migrate_garmin_global_to_garmin_cn.yml # 手动迁移 Global → CN
│   │   └── ci.yml                                 # PR 类型检查
│   └── dependabot.yml                             # 依赖自动更新
├── db/                                            # SQLite 数据库（session 持久化）
├── src/                                           # TypeScript 源码
├── .env.example                                   # 环境变量模板
├── .gitignore
├── Dockerfile
├── docker-compose.yml
├── package.json
├── SECRETS.md                                     # GitHub Secrets 配置清单
└── README.md
```

## 免责声明

本工具仅限用于学习和研究使用，不得用于商业或者非法用途。
