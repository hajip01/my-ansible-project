#!/bin/bash
echo "=== Ansible多主机管理测试脚本 ==="
echo

echo "1. 测试所有主机连通性..."
ansible all -i hosts -m ping
echo

echo "2. 查看所有主机列表..."
ansible all -i hosts --list-hosts
echo

echo "3. 测试分组执行命令..."
echo "Web服务器组："
ansible dev_web -i hosts -m shell -a "echo '我是: $HOSTNAME, 时间: $(date)'"
echo

echo "DB服务器组："
ansible dev_db -i hosts -m shell -a "echo '我是: $HOSTNAME, 磁盘: $(df -h / | tail -1)'"
echo

echo "4. 测试批量文件操作..."
echo "在所有服务器创建测试文件..."
ansible all -i hosts -m file -a "path=/tmp/ansible_test.txt state=touch mode=0644"
echo

echo "5. 查看测试文件..."
ansible all -i hosts -m shell -a "ls -la /tmp/ansible_test.txt && cat /etc/hostname > /tmp/ansible_test.txt && cat /tmp/ansible_test.txt"
echo

echo "6. 清理测试文件..."
ansible all -i hosts -m file -a "path=/tmp/ansible_test.txt state=absent"
echo

echo "✅ 测试完成！"
