# Practica-17
Martí Pujol
# Enllaç



## Instalación

Pasos

```bash
mkdir vagrant
cd ./vagrant
vagrant init
```

## Vagrantfile
```bash
Vagrant.configure("2") do |config|
#Elegimos versión Ubuntu
    config.vm.box = "ubuntu/xenial64"
    config.vm.provider "virtualbox" do |vb|
#Habilitamos la interfaz gráfica
        vb.gui = true
#Nombre de la máquina
        vb.name = "UbuntuServer"
#La memoria RAM que quremos
        vb.memory = "2048"
    end 
#Nombre de la máquina
    config.vm.hostname = "lamp"
#Hacemos la red privada y que nos asigne una IP aleatoria
    config.vm.network "private_network", type: "dhcp"
#Ruta donde se intalará el MySQL, PHP y Apache    
    config.vm.provision "shell", path: "provision-for-apache-mysql.sh"
end

```

## provision.sh
```bash
#!/bin/bash
#Instalación de apache y php:
apt-get update
apt-get install -y apache2
apt-get install -y php libapache2-mod-php php-mysql
sudo /etc/init.d/apache2 restart
cd /var/www/html
wget https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1-mysql.php
mv adminer-4.3.1-mysql.php adminer.php
#Instalación de mysql-server:
apt-get update
apt-get -y install debconf-utils
DB_ROOT_PASSWD=root
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DB_ROOT_PASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DB_ROOT_PASSWD"
apt-get install -y mysql-server
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
/etc/init.d/mysql restart
mysql -uroot mysql -p $DB_ROOT_PASSWD <<< "GRANT ALL PRIVILEGES ON *.* TO root@"%" IDENTIFIED BY "$DB_ROOT_PASSWD"; FLUSH PRIVILEGES;"
mysql -u root mysql -p $DB_ROOT_PASSWD <<< "CREATE DATABASE projecte17;"


```

## Ejecutar vagrant

Ejecutamos el comando vagrant up para inicializar la máquina virtual. 
