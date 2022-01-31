FROM php:7.3-apache
ADD ./apache2.conf /etc/apache2/apache2.conf
ADD ./intercept.php /var/www/intercept.php
RUN echo "auto_prepend_file=/var/www/intercept.php" >> /usr/local/etc/php/php.ini
RUN a2enmod rewrite
# Disable stdout logging
RUN rm "/var/log/apache2/access.log"
