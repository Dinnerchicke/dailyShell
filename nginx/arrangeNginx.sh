# 这个脚本用于手动部署nginx,需要手动传文件到服务器的/home/ubuntu目录
  
# config变量
projectPath='/home/ubuntu'
path='/etc/nginx/conf.d/2333.conf'
versionPath="/home/ubuntu/server/version.txt"
last=`sed -n '$p' $versionPath`
version=$(($last+1))
pathVersion=vueTemplatev$version
nginxPath="               root /var/www/html/${pathVersion};"

echo $version
echo $versionPath

# 获取上一个版本并+1赋值，
sudo sed -i '$a \\'"${version}"'' ${versionPath}
# 修改dist文件夹名
sudo mv dist $pathVersion
# 将文件夹移动到/var/www/html
sudo mv $pathVersion /var/www/html
# 进入nginx
cd /etc/nginx/conf.d
# 在nginx配置文件第六行修改对应数字版本，有需求可以更改
sudo sed -i "5c \\ $nginxPath" $path
# 重启nginx
sudo nginx -s reload