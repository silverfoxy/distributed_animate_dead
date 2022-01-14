#!/bin/bash

cd php/client
composer install --ignore-platform-reqs
cd animate_dead
composer install --ignore-platform-reqs
cd vendor/silverfoxy/malmax
composer install --ignore-platform-reqs
cd php-emul
composer install --ignore-platform-reqs
