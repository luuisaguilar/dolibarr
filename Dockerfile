# Usa una imagen de PHP con Apache preinstalado
FROM php:8.1-apache

# Instalar extensiones necesarias para Dolibarr
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mysqli zip

# Copiar los archivos de Dolibarr sin sobrescribir archivos críticos de Apache
COPY --chown=www-data:www-data . /var/www/html/

# Ajustar permisos para Apache
RUN chmod -R 755 /var/www/html/

# Exponer el puerto correcto para Railway
EXPOSE 8080

# Verificar que Apache está instalado antes de ejecutarlo
CMD ["sh", "-c", "which apache2-foreground && apache2-foreground"]
