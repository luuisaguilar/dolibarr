# Usa una imagen de PHP con Apache preinstalado
FROM php:8.1-apache

# Instalar extensiones necesarias para Dolibarr y asegurar que Apache está instalado
RUN apt-get update && apt-get install -y \
    apache2 libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mysqli zip

# Copiar los archivos de Dolibarr al directorio correcto de Apache
COPY . /var/www/html/

# Ajustar permisos para Apache
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/

# Exponer el puerto correcto para Railway
EXPOSE 8080

# Comando para iniciar Apache
CMD ["apache2-foreground"]
