# API 测试文件说明

本目录包含项目的 HTTP 接口测试文件，使用 `.http` 格式存储。

## 使用方法

### VSCode
1. 安装 [REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) 插件
2. 打开任一 `.http` 文件
3. 点击请求上方的 `Send Request` 链接，或使用快捷键：
   - macOS: `Cmd + Alt + R`
   - Windows/Linux: `Ctrl + Alt + R`

### JetBrains IDEs (IntelliJ IDEA, GoLand 等)
1. 原生支持，无需安装插件
2. 打开 `.http` 文件
3. 点击请求旁边的绿色运行按钮
4. 或使用快捷键：`Cmd + Enter` (macOS) / `Ctrl + Enter` (Windows/Linux)

## 启动服务

### 本地直接运行
```bash
go run main.go
```
服务默认运行在 `http://localhost:8080`

### 使用 skaffold 本地开发
```bash
skaffold dev
```

### 使用 ko 直接构建运行
```bash
ko run -p ./k8s/base/
```

### 部署到 Kubernetes
```bash
# 使用 kubectl 直接部署
kubectl apply -k k8s/base/

# 或使用 skaffold 部署
skaffold run

# 查看服务状态
kubectl get svc,po

# 通过 NodePort 访问 (NodePort: 30080)
curl http://localhost:30080/
```

## 环境配置

项目支持多环境配置，通过 [`http-client.env.json`](http-client.env.json) 管理：

| 环境 | baseUrl | 说明 |
|------|---------|------|
| `development` | http://localhost:8080 | 本地直接运行 |
| `k8s` | http://localhost:30080 | Kubernetes NodePort |
| `staging` | http://staging.example.com | 预发布环境 |
| `production` | http://prod.example.com | 生产环境 |

**JetBrains IDEs**: 顶部工具栏切换环境
**VSCode**: 修改 `hello.http` 文件顶部的 `@baseUrl` 变量

| 文件 | 说明 |
|------|------|
| [`hello.http`](hello.http) | 主接口测试文件，包含根路径的各种请求测试 |

## 请求格式说明

- `###` 用于分隔多个请求
- `@` 符号可以引用变量文件
- `#` 开头的行为注释
- 点击 `Send Request` 即可发送请求并查看响应

## 注意事项

- 确保服务已启动（8080 端口或 NodePort 30080）
- 当前服务返回纯文本响应
- `POD_NAME` 环境变量在 Kubernetes 环境中会自动设置
- Kubernetes 部署后，可通过以下方式访问：
  - **NodePort**: `http://localhost:30080` (适用于 Docker Desktop / Minikube)
  - **Port Forward**: `kubectl port-forward svc/ko-demo 8080:8080`
  - **ClusterIP**: 仅集群内部访问

## K8s Service 说明

| 服务类型 | 端口 | 访问方式 |
|----------|------|----------|
| ClusterIP | 8080 | 集群内部访问 |
| NodePort | 30080 | `http://localhost:30080` |
