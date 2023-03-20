# Prestashop Ecommerce

This is a project to deploy a Prestashop CRM with Docker.

## Requirements

- [Install Docker](https://docs.docker.com/get-docker/)
- [Install Docker Compose](https://docs.docker.com/compose/install/)
- [Install Make](https://www.gnu.org/software/make/)

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

Then use the following commands according to your needs.

#### Build

```bash
make build
```

#### Stop

```bash
make stop
```

#### Restart

```bash
make restart
```

#### View logs

```bash
make logs
```
