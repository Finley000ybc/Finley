为了通过 Shell 脚本调用 Jenkins REST API 更新 Jenkins 中的凭证（Credential）密码，首先需要了解以下几点：

1. **Jenkins REST API** 允许你通过 HTTP 请求与 Jenkins 交互，包括创建、更新和删除凭证。
2. 更新凭证密码通常需要提供凭证的 ID、更新后的密码，以及 Jenkins 的认证信息（例如 API Token 或用户名密码）。

### 假设
- Jenkins URL: `http://your-jenkins-server`
- Jenkins 用户名: `your-username`
- Jenkins API Token: `your-api-token`
- Credential ID: `your-credential-id`
- 新的密码: `new-password`

### 步骤

#### 1. 获取 Jenkins API Token
确保你有 Jenkins 用户的 API Token。在 Jenkins 的网页界面中，可以通过点击用户头像，然后进入 "Configure" 页面来找到 API Token。

#### 2. 使用 `curl` 进行 API 调用
Jenkins 提供了一个 REST API 来更新凭证。为了更新密码，可以使用 Jenkins 服务器的 API 请求。

以下是一个示例 Shell 脚本，演示如何通过 Jenkins REST API 更新指定凭证的密码：

```bash
#!/bin/bash

# Jenkins 服务器信息
JENKINS_URL="http://your-jenkins-server"
JENKINS_USER="your-username"
JENKINS_API_TOKEN="your-api-token"

# 要更新的凭证信息
CREDENTIAL_ID="your-credential-id"  # 替换为目标凭证的 ID
NEW_PASSWORD="new-password"  # 替换为你想更新的密码

# 准备数据
XML_PAYLOAD=$(cat <<EOF
<credentials>
  <scope>GLOBAL</scope>
  <id>$CREDENTIAL_ID</id>
  <secret>$NEW_PASSWORD</secret>
  <description>Updated credential password</description>
</credentials>
EOF
)

# 使用 curl 进行 Jenkins API 调用，更新凭证
curl -X POST "$JENKINS_URL/credentials/store/system/domain/_/updateCredentials" \
    --user "$JENKINS_USER:$JENKINS_API_TOKEN" \
    -H "Content-Type: application/xml" \
    -d "$XML_PAYLOAD"

echo "Credential password updated successfully!"
```

### 解释：
1. **Jenkins URL 和认证**：你需要替换脚本中的 `JENKINS_URL`、`JENKINS_USER` 和 `JENKINS_API_TOKEN`，以便连接到你的 Jenkins 服务器。
2. **Credential ID**：你需要替换 `CREDENTIAL_ID` 为要更新的凭证的 ID。
3. **更新密码**：将 `NEW_PASSWORD` 替换为你希望设置的新密码。
4. **请求体（XML 格式）**：Jenkins 的凭证 API 接口接受 XML 格式的数据。上面的 `XML_PAYLOAD` 使用了 XML 格式来指定凭证的信息，包括 `id`、`secret`（密码）和 `description`（描述）。

### 注意：
- 如果你使用的是更复杂的凭证类型（如用户名和密码组合），你可能需要稍微调整 `XML_PAYLOAD` 结构，以适应 Jenkins API 对应的凭证类型。
- 该请求将发送到 Jenkins 的 `/updateCredentials` 端点，更新指定凭证的密码。

#### 3. 使用 curl 调用 API
运行脚本时，`curl` 会向 Jenkins 服务器发送 HTTP POST 请求，并携带凭证的更新数据。

### 可选：调试和验证
如果你想验证请求是否成功，可以添加 `-v` 选项来启用 `curl` 的详细输出，以帮助排查问题：

```bash
curl -v -X POST "$JENKINS_URL/credentials/store/system/domain/_/updateCredentials" \
    --user "$JENKINS_USER:$JENKINS_API_TOKEN" \
    -H "Content-Type: application/xml" \
    -d "$XML_PAYLOAD"
```

### 总结
这个脚本演示了如何使用 `curl` 通过 Jenkins REST API 自动更新 Jenkins 中的凭证密码。你只需根据需要替换相关的参数（如 `JENKINS_URL`、`JENKINS_USER`、`CREDENTIAL_ID` 和 `NEW_PASSWORD`），并运行脚本即可。
