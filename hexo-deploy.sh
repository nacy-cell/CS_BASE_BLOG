#!/bin/bash
PUBLIC_PATH="public"  
SERVER_IP="43.143.143.213"                               
SERVER_USER="root"                                       
SERVER_DIR="/var/www/html"                               

# 1. 清理旧文件
echo "=== 1. 清理 Hexo 旧文件 ==="
hexo clean --quiet >/dev/null 2>&1
# 2. 生成静态文件
echo -e "\n=== 2. 生成静态文件 ==="
hexo generate --quiet >/dev/null 2>&1
if [ ! -d "$PUBLIC_PATH" ]; then
  echo -e "\nError: 静态文件生成失败，未找到 public 目录！"
  exit 1
fi
# 3. 同步文件
echo -e "\n=== 3. 同步文件到服务器 ==="
rsync -avz --delete -e "ssh -p 22" "$PUBLIC_PATH"/* "$SERVER_USER@$SERVER_IP:$SERVER_DIR/" --quiet 2>&1

if [ $? -eq 0 ]; then
  echo -e "\n=== 部署成功！可访问 http://$SERVER_IP 查看 ==="
else
  echo -e "\n=== 部署失败！请检查服务器连接或路径 ==="
  exit 1
fi