# Usa una imagen de PHP con Apache preinstalado
FROM php:8.1-apache

# Instalar extensiones necesarias para Dolibarr
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mysqli zip

# Copiar los archivos de Dolibarr al servidor
COPY --chown=www-data:www-data . /var/www/html/

# Ajustar permisos para evitar problemas de acceso
RUN chmod -R 755 /var/www/html/

# Exponer el puerto correcto
EXPOSE 8080

# Iniciar Apache en primer plano (corrección del error)
CMD ["apache2ctl", "-D", "FOREGROUND"]
