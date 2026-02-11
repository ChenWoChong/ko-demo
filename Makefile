.PHONY: help dev prod dev-build prod-build dev-run prod-run dev-debug prod-debug

help: ## 显示帮助信息
	@echo "可用命令:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

dev: ## 构建并部署到 dev 环境
	skaffold run

del: ## 删除 dev 环境
	skaffold delete

dev-build: ## 仅构建 dev 环境
	skaffold build

dev-run: ## 仅部署 dev 环境（不构建）
	skaffold deploy

dev-debug: ## Debug 模式运行 dev 环境
	skaffold dev

prod: ## 构建并部署到 prod 环境
	skaffold run -p prod --default-repo=swr.cn-north-4.myhuaweicloud.com/issedb

prod-del: ## 删除 prod 环境
	skaffold delete --profile prod

prod-build: ## 仅构建 prod 环境
	skaffold build --profile prod --default-repo=swr.cn-north-4.myhuaweicloud.com/issedb

prod-run: ## 仅部署 prod 环境（不构建）
	skaffold deploy --profile prod --default-repo=swr.cn-north-4.myhuaweicloud.com/issedb

prod-debug: ## Debug 模式运行 prod 环境
	skaffold dev --profile prod --default-repo=swr.cn-north-4.myhuaweicloud.com/issedb
