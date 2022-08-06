# devops-exercise

<!-- Following test will give us a view of your skillset on AWS well-architected framework. No need to implement it completely so please watch your time and implement as much as possible in the duration of 8 to 10 hours.

1. Build a secure and small dockerized hello world Laravel app which can be successfully connected to a MySQL server.
2. Automate the process of building the app and pushing to a container registry using GitLab.
3. Bring up an autoscale EC2 cluster as a worker node group of an EKS cluster (For this IaC is enough, no need to apply on real infra)
4. Automate the deployment of built app on K8s cluster (locally you can use `minikube` or `kind` for K8s)
5. Add documentation of the whole procedure and how you made it well architected.

Please use technologies you have expertise on (GitLab, Ansible, Bash, Terraform, Helm, etc.) and send us all repositories. -->

TODO:

- [x] Setup EKS Cluster Terraform, structure module, install Helm, EKS add-ons
- [x] Clone source code https://github.com/nahidulhasan/laravel-docker-k8s and running local test.
- [x] Install MySQL K8S, prepare script migrate DB for Laravel, automate pipeline migrate if necessary at the end stage.
- [x] Setup Helm repository in S3 using Terraform module, base helm chart application
- [x] Using Helm app to deploy Dockerfile locally.
- [x] Using https://github.com/GoogleContainerTools/kaniko to Build Docker in Gitlab CI and publish to ECR.
- [x] Deploy and manage GitLab Runner in cluster EKS, to make pipeline runnable.
- [x] Using autoscaler to scale the cluster's worker nodes by number of pods or metrics.
- [x] Document, draw architecture, how it work.

<!--
https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/set-up-a-helm-v3-chart-repository-in-amazon-s3.html

helm s3 init s3://ty-helm/stable/myapp

helm repo add stable-myapp s3://ty-helm/stable/myapp/

helm repo add gitlab https://charts.gitlab.io

aws eks --region ap-southeast-1 update-kubeconfig --name ty-dev-eksdemo

helm upgrade --namespace default gitlab-runner -f gitlab-runner-values.yaml gitlab/gitlab-runner


brew tap shivammathur/php

brew link php@7.3
sudo mv composer.phar /usr/local/bin/composer

php artisan key:generate

php artisan migrate

APP_NAME=Laravel
APP_ENV=local
APP_KEY=base64:M7q1/oyamLRk/K6kJLdC7OwAXxFWATSN9TS9o7wJ9Lw=
APP_DEBUG=true
APP_LOG_LEVEL=debug
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=webappdb
DB_USERNAME=root
DB_PASSWORD=dbpassword11

BROADCAST_DRIVER=log
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_DRIVER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=


FROM composer:2.0 as build
COPY . /app/
RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction --ignore-platform-reqs

# Set the base image for subsequent instructions
FROM php:7.4-fpm

# Update packages
RUN apt-get update

# Install PHP and composer dependencies
RUN apt-get install -qq git curl libmcrypt-dev libjpeg-dev libpng-dev libfreetype6-dev libbz2-dev libicu-dev zip

# Clear out the local repository of retrieved package files
RUN apt-get clean

# Install needed extensions
# Here you can install any other extension that you need during the test and deployment process
RUN pecl install mcrypt-1.0.4
RUN docker-php-ext-enable mcrypt
RUN docker-php-ext-install pdo_mysql intl

RUN apt-get install -y nginx  supervisor && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /app /var/www/html
COPY .env.example /var/www/html/.env

WORKDIR /var/www/html


RUN rm /etc/nginx/sites-enabled/default

COPY /docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf

RUN php artisan config:cache && \
    php artisan route:cache && \
    chmod 777 -R /var/www/html/storage/ && \
    chown -R www-data:www-data /var/www/

RUN chmod +x ./entrypoint

ENTRYPOINT ["./entrypoint"]

EXPOSE 80

helm package ./app
helm s3 push --force ./app-0.0.1.tgz stable-myapp

helm upgrade devops-laravel devops/app --install --force --namespace devops-laravel -f deployment/dev.yaml --set image.repository=${DOCKER_IMAGE},image.tag=${DOCKER_TAG} -->
