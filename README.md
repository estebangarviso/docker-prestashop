# Prestashop Ecommerce

This is a project to deploy a Prestashop CRM with Docker.

## Requirements

- [Install Docker](https://docs.docker.com/get-docker/)
- [Install Docker Compose](https://docs.docker.com/compose/install/)

## Services

- [Oracle MySQL v8.0.32](https://www.mysql.com/)
- [FastCGI Process Manager PHP v8.1](https://www.php.net/manual/en/install.fpm.php)
- [Traefik Proxy v2.9](https://traefik.io/)

## Data Structure

This is the structure of the cloned project:

```bash
├── .github
│   └── workflows
├── containers
│   └── mysql
│   └── nginx # deprecated. Use traefik instead
│   └── php
│   └── traefik
├── .dockerignore
├── .env.example
├── .gitignore
├── docker-compose.yml
├── LICENSE.md
├── Makefile
└── README.md
```

## How to use

First rename `.env.example` to `.env` and edit the variables on local environment or pull repo and add secrets to your environment on Github.

```bash
cp .env.example .env
```

Then use the following commands according to your needs. All commands are in the `Makefile` file.

Examples:

```bash
#### Build and start
COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce up --build -d --remove-orphans
#### Will remove all containers
COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce down
#### Restart all containers
COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce restart
#### View logs
COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce logs -f
#### View docker containers
COMPOSE_PROFILES=db,proxy docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}"
#### Inspect docker container
COMPOSE_PROFILES=db,proxy docker inspect ps-ecommerce_app_1
#### Execute command on container
COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce exec app bash
#### Delete image
docker rmi ps-ecommerce_app
#### Delete all images
docker rmi $(docker images -a -q)
#### Delete container
docker rm ps-ecommerce_app_1
#### Delete all containers
docker rm $(docker ps -a -q)
#### Delete volume
docker volume rm ps-ecommerce_app
#### Delete all volumes
docker volume rm $(docker volume ls -q)
#### Delete network
docker network rm ps-ecommerce_front-tier
#### Delete all networks
docker network rm $(docker network ls -q)
#### Delete all
docker system prune -a
```
