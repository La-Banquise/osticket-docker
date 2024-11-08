# osticket-docker

PATH = "./"

${PATH}/ost-config.php:/var/www/html/osTicket/include/ost-config.php


docker build -t my-php-app .

docker run -itd --name my-running-app -p 80:80 my-php-app
