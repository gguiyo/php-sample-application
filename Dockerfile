FROM php:7.4-apache

# Instalar las extensiones de PHP necesarias
RUN docker-php-ext-install pdo_mysql

# Instalar wget y unzip (necesarios para la instalación de Composer)
RUN apt-get update && apt-get install -y wget unzip


# Copiar los archivos de la aplicación al contenedor
COPY . /var/www/html

# Ejecutar el comando make desde la raíz del proyecto
WORKDIR /var/www/html
RUN make

# Configurar Apache según las instrucciones del README.md
RUN echo '<VirtualHost *:80>\n\
    ServerName localhost\n\
    DocumentRoot /var/www/html/web\n\
    <Directory /var/www/html/web>\n\
    Require all granted\n\
    AllowOverride all\n\
    </Directory>\n\
    php_admin_value include_path "/var/www/html/"\n\
    </VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Habilitar mod_rewrite para Apache
RUN a2enmod rewrite

# Exponer el puerto 80 para el servicio Apache
EXPOSE 80

# Comando para arrancar Apache en el contenedor
CMD ["apache2-foreground"]
