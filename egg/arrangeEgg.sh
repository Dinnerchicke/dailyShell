cd /var/lib/jenkins/workspace/smartfreeway-back; # 项目目录
pid=$(ps -ef | grep "egg" | grep -v grep | awk '{print $2}' |tail -n 3 | head -n 1); # 获取egg进程的pid
kill ${pid} # 杀掉对应进程
sudo git pull origin master # 拉取master分支
sudo cnpm i # 安装依赖

# 因为nohup不支持Jenkins，所以只能通过在服务器上运行shell脚本的方式
cd /home/ubuntu
sh arrange.sh
exit 0

# arrange.sh内容
cd /var/lib/jenkins/workspace/smartfreeway-back;
nohup npm run dev &
