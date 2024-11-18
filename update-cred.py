import requests
from requests.auth import HTTPBasicAuth

# Jenkins 服务器信息
JENKINS_URL = "http://your-jenkins-server"
JENKINS_USER = "your-username"
JENKINS_API_TOKEN = "your-api-token"

# 要更新的凭证信息
CREDENTIAL_ID = "your-credential-id"  # 替换为目标凭证的 ID
NEW_PASSWORD = "new-password"  # 替换为你想更新的密码

# 构建 XML 数据
xml_payload = f"""
<credentials>
  <scope>GLOBAL</scope>
  <id>{CREDENTIAL_ID}</id>
  <secret>{NEW_PASSWORD}</secret>
  <description>Updated credential password</description>
</credentials>
"""

# Jenkins API URL
update_url = f"{JENKINS_URL}/credentials/store/system/domain/_/updateCredentials"

# 发送 POST 请求更新凭证
response = requests.post(
    update_url,
    data=xml_payload,
    headers={"Content-Type": "application/xml"},
    auth=HTTPBasicAuth(JENKINS_USER, JENKINS_API_TOKEN)
)

# 检查请求结果
if response.status_code == 200:
    print("Credential password updated successfully!")
else:
    print(f"Failed to update credential. Status code: {response.status_code}")
    print(f"Response: {response.text}")
