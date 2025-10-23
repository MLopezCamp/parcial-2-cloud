# Imagen base oficial de PHP con Apache
FROM php:8.2-apache

# Actualiza paquetes e instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libonig-dev \
    libzip-dev \
    zip \
    && docker-php-ext-install intl mbstring zip opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia el contenido del proyecto al contenedor
COPY . /var/www/html/

# Cambia el DocumentRoot de Apache a la carpeta "web"
RUN sed -i 's|/var/www/html|/var/www/html/web|g' /etc/apache2/sites-available/000-default.conf

# Habilita el módulo rewrite de Apache
RUN a2enmod rewrite

# Configura Apache para permitir .htaccess y URL amigables
RUN echo "<Directory /var/www/html/web>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>" > /etc/apache2/conf-available/app.conf \
    && a2enconf app

# Establece el directorio de trabajo
WORKDIR /var/www/html/web

# Expone el puerto 80 (HTTP)
EXPOSE 80

# Comando por defecto
CMD ["apache2-foreground"]
