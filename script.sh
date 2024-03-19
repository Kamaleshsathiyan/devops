#!/bin/bash
data() {
read -p"Enter the application to be installed: " app
status=$(systemctl is-active $app)
if [ $status == "inactive" ]
then
sudo "your service is not installed"
sudo dnf install $app -y
sudo systemctl enable --now $app
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload
sudo setenforce 0
sudo getenforce
echo "service installed successfully"
sudo sed -i s/local/"all granted"/g /etc/httpd/conf.d/phpMyAdmin.conf
sudo systemctl restart httpd.service
sudo mysql -u root -p -e 'alter user "root"@"localhost" identified by "redhat";flush privileges;'
echo "done"

fi
}
data "httpd"
data "mysql-server"
data "phpmyadmin"
