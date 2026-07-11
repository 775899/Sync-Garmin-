# GitHub Secrets 配置清单

在仓库的 **Settings → Secrets and variables → Actions** 中添加以下 Secrets。

## 必填项

| Secret 名称 | 说明 | 示例 |
|---|---|---|
| `GARMIN_USERNAME` | 佳明中国区账号（邮箱） | `user@example.com` |
| `GARMIN_PASSWORD` | 佳明中国区密码 | `your_password` |
| `GARMIN_GLOBAL_USERNAME` | 佳明国际区账号（邮箱） | `user@example.com` |
| `GARMIN_GLOBAL_PASSWORD` | 佳明国际区密码 | `your_password` |

## 迁移任务专用

| Secret 名称 | 说明 | 示例 |
|---|---|---|
| `GARMIN_MIGRATE_NUM` | 每次迁移的活动数量 | `100` |
| `GARMIN_MIGRATE_START` | 从第几条活动开始迁移 | `0` |

## 国际区 Session 登录（sync_cn 用）

| Secret 名称 | 说明 |
|---|---|
| `GARMIN_GLOBAL_OAUTH1` | 佳明国际区 OAuth1 Token |
| `GARMIN_GLOBAL_OAUTH2` | 佳明国际区 OAuth2 Token |

> 通过 `yarn export_garmin_sessions` 导出后填入。首次运行时可不填，脚本会自动登录获取。

## 可选项

| Secret 名称 | 说明 |
|---|---|
| `BARK_KEY` | Bark 推送通知的 Key，用于失败时推送通知到 iPhone |
| `RQ_COOKIE` | RQ runningquotient.cn 的 Cookie |
| `RQ_CSRF_TOKEN` | RQ 的 CSRF Token |
| `RQ_USERID` | RQ 的用户 ID |
| `GOOGLE_SHEET_ID` | Google Sheet ID，用于记录跑力数据 |
| `GOOGLE_API_CLIENT_EMAIL` | Google Service Account 邮箱 |
| `GOOGLE_API_PRIVATE_KEY` | Google Service Account 私钥 |

## 配置步骤

1. 进入仓库 **Settings** 页面
2. 左侧菜单选择 **Secrets and variables → Actions**
3. 点击 **New repository secret**
4. 逐一添加上表中的 Secret

## 注意事项

- Secrets 名称区分大小写，必须与上表完全一致
- `GOOGLE_API_PRIVATE_KEY` 包含换行符，直接粘贴即可
- 所有 Secrets 加密存储，不会在日志中明文显示
- Fork 的仓库需要手动重新配置所有 Secrets
