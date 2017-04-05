# Supported tags and respective `Dockerfile` links

This docker compose is for RedProfesional v 1.12 and beyond

# What is Elgg ?

Elgg is an award-winning social networking engine, delivering the building blocks that enable businesses, schools, universities 
and associations to create their own fully-featured social networks and applications.

For more information and related for Elgg, please visit www.elgg.org.
![logo](https://elgg.org/images/elgg_small.png)

# What is RedProfesional ?

RedProfesional is the system made from elgg framework, with its own themes and plugins to work flawless in our environment.

# How to use this image

Before you start you need to have installed:
- composer: https://getcomposer.org/download/
- docker: http://docs.docker.com/linux/step_one/ or https://docs.docker.com/installation/ubuntulinux/
- docker-compose: https://docs.docker.com/compose/install/

1.. Copy the code of Red Profesional to workspace/elgg:

--or you can develop elgg from scratch... just be sure to get the content to workspace/elgg

```console
$ 
```

```console
& mkdir elgg && cd elgg
$ composer.phar global require "fxp/composer-asset-plugin:~1.1.1"
$ composer create-project elgg/starter-project:dev-master .
$ composer.phar install
```

See http://learn.elgg.org/en/stable/intro/install.html#upload-elgg

2.. Edit file docker-compose.yml for your needs, pay attention to the environment varaibles:

```yml
web:
  image: keviocastro/elgg-docker:2.0
  ports:
    - "8000:80" #If you change the port, you must also change the environment variable ELGG_WWW_ROOT
  links:
    - mysql
  volumes:
    - .:/var/www/html/
  environment:
    MYSQL_USER: root
    MYSQL_PASS: root-pass
    ELGG_USERNAME: admin
    ELGG_PASSWORD: admin-pass
    ELGG_WWW_ROOT: http://localhost:8000
mysql:
  image: mysql:5.6  
  environment:
    MYSQL_DATABASE: elgg
    MYSQL_ROOT_PASSWORD: root-pass
```
3.. create a media/elgg directory and check permissions for /media in your docker

```console
$ docker-compose up -d
```

3.. Install the Elgg:
```console
$ docker exec elggdocker_web_1 /elgg-docker/elgg-install.sh
```

Visit your Elgg site: <http://localhost:8000/>

## Environment Variables

When you start the elgg-docker image, you can adjust the configuration of the elgg instance by passing one or 
more environment variables.
The default values are in Dockerfile file: [`Dockerfile`](https://github.com/keviocastro/elgg-docker/blob/2.0/Dockerfile)

> You can modify the parameters by passing one or more environment variables in file docker-compose.yml

> Example: 
```yml
web:
  image: keviocastro/elgg-docker:2.0
  environment:
    MYSQL_USER: elgg
    MYSQL_PASS: elgg-pass
    ELGG_DISPLAY_NAME: my-name
    ELGG_DB_PREFIX: my-elgg
    TIMEZONE: America/Sao_Paulo
```

* `TIMEZONE` The timezone of the server and php 
* `MYSQL_USER` The DB username to create
* `MYSQL_PASS` The DB password to set on the created user
* `ELGG_DB_HOST` The DB host Elgg will use
* `ELGG_DB_USER` The DB user Elgg will use
* `ELGG_DB_PASS` The DB password Elgg will use
* `ELGG_DB_PREFIX` Elgg's DB prefix 
* `ELGG_DB_NAME` The name of the DB Elgg will use
* `ELGG_SITE_NAME` Elgg's site name
* `ELGG_SITE_EMAIL` Elgg site email address 
* `ELGG_WWW_ROOT` Elgg's www_root (Don't change this unless you modify run.sh and the installation)
* `ELGG_DATA_ROOT` The data_root for Elgg (/media)
* `ELGG_DISPLAY_NAME` The display name for the admin user
* `ELGG_EMAIL` The email address for the admin user (must be a well-formed, though not necessarily value, address)
* `ELGG_USERNAME` The username of the admin user
* `ELGG_PASSWORD` The password for the admin user
* `ELGG_PATH` The location Elgg is installed (Don't change this unless you modify run.sh and the installation)
* `ELGG_SITE_ACCESS` The default site access
