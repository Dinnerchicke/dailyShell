# config变量
projectPath=\'/var/lib/jenkins/workspace/smartfreeway-web' # 项目目录
path=\'/etc/nginx/conf.d/8866.conf\' # nginx配置目录
versionPath="/home/ubuntu/server/version8866.txt" # 版本记录文件
last=`sed -n \'$p\' $versionPath` # 最新版本
version=$(($last+1)) # 根据版本记录文件生成最新版本
pathVersion=freewayv$version # 最新版本文件名
nginxPath="               root /var/www/html/${pathVersion};" # 在对应nginx的conf文件里插入的最新版本文件


# 先进入对应文件夹
cd $projectPath
# 装依赖
sudo cnpm i
# 打包
sudo cnpm run build
# 获取上一个版本并+1赋值，
sudo sed -i \'$a \\\'"${version}"\'\' ${versionPath}
# 修改dist文件夹名
sudo mv dist $pathVersion
# 将文件夹移动到/var/www/html
sudo mv $pathVersion /var/www/html
# 进入nginx
cd /etc/nginx/conf.d
# 在nginx配置文件第六行修改对应数字版本，有需求可以更改
sudo sed -i "6c \\ $nginxPath" $path
# 重启nginx
sudo nginx -s reload

# tips:
# 版本记录文件内容如下:即每隔一行会有一个数字，前面的#略去
# 1
# 2
# 3
# ...