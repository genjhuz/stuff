
# Title of script set
TITLE="Composer Install Script"

echo update the packages index and install some of dependencies
apt update
apt upgrade
apt install curl php-cli php-mbstring git unzip php7.1-curl

echo download the composer installer file
echo
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

echo check the data integrity of the script by comparing the script SHA-384 hash on the Composer Signatures page
HASH="$(wget -q -O - https://composer.github.io/installer.sig)"

echo check that the installation script is not corrupted
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
# You will get following output if the hashes match:
# Installer verified

echo installing Composer
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
# It will show you output as below:
# All settings correct for using Composer
# Downloading...
# Composer (version 1.9.0) successfully installed to: /usr/local/bin/composer
# Use it: php /usr/local/bin/composer

# verify the installation
Composer

# Now the Composer is installed globally on your Debian 10 system and we will show how to use in your php project.

mkdir my-project
cd my-project

composer require nesbot/carbon
ls -l
nano test.php
# <?php
# require __DIR__ . '/vendor/autoload.php';
# use Carbon\Carbon;
# printf("Now: %s", Carbon::now());

php test.php
composer update
