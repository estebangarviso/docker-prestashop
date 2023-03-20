build:
	COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce up --build -d --remove-orphans
stop:
	COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce down
restart:
	COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce restart
logs:
	COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce logs -f
ps:
	COMPOSE_PROFILES=db,proxy docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}"
inspect:
	COMPOSE_PROFILES=db,proxy docker inspect $(service)
exec:
	COMPOSE_PROFILES=db,proxy docker-compose --project-name ps-ecommerce exec $(service) $(cmd)
del-image:
	docker rmi $(image)
del-images:
	docker rmi $(docker images -a -q)
del-container:
	docker rm $(container)
del-containers:
	docker rm $(docker ps -a -q)
del-volume:
	docker volume rm $(volume)
del-volumes:
	docker volume rm $(docker volume ls -q)
del-network:
	docker network rm $(network)
del-networks:
	docker network rm $(docker network ls -q)
del-all:
	docker system prune -a
