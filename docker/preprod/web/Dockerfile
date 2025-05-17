FROM php:7.0-apache

# Installer les extensions PHP nécessaires
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    && docker-php-ext-install \
    pdo_mysql \
    mysqli \
    zip \
    intl \
    mbstring

# Activer le module rewrite d'Apache
RUN a2enmod rewrite

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Définir le répertoire de travail
WORKDIR /var/www/html

# Cloner le dépôt Git (branche main pour la pré-production)
RUN rm -rf /var/www/html/* && \
    git clone -b main https://gitlab.com/QuentinAlvernhe/videgrenier.git .

# Installer les dépendances
RUN if [ -f composer.json ]; then composer install --no-dev; fi

# Configurer Apache
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/docker-php.conf \
    && a2enconf docker-php

# Exposer le port 80
EXPOSE 80