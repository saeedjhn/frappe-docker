# =========================================================
# Frappe Docker Environment
# =========================================================

COMPOSE=docker compose -f docker-compose.yml
PROJECT=frappe

# --------------------------
# Core Lifecycle
# --------------------------

## Start all services
up:
	$(COMPOSE) up --build

## Start all services in detached mode
up-d:
	$(COMPOSE) up --build -d

## Stop all services
down:
	$(COMPOSE) down

## Stop + remove volumes (full reset)
down-v:
	$(COMPOSE) down -v

## Restart environment
restart: down up

# --------------------------
# Build
# --------------------------

## Build images only
build:
	$(COMPOSE) build

# --------------------------
# Logs / Debug
# --------------------------

## Follow logs
logs:
	$(COMPOSE) logs -f

## Logs for frappe only
logs-app:
	$(COMPOSE) logs -f frappe

## Status of containers
ps:
	$(COMPOSE) ps

# --------------------------
# Shell access
# --------------------------

## Enter frappe container
frappe-shell:
	docker exec -it frappe-bench bash

## Enter mariadb
db-shell:
	docker exec -it frappe-mariadb bash

## Redis shell (cache)
redis-cache:
	docker exec -it frappe-redis-cache sh

# --------------------------
# Infrastructure only
# --------------------------

## Start only DB + Redis services
infra-up:
	$(COMPOSE) up -d mariadb redis-cache redis-queue redis-socketio

## Stop only infrastructure
infra-down:
	$(COMPOSE) stop mariadb redis-cache redis-queue redis-socketio

# --------------------------
# Cleanup
# --------------------------

## Remove containers + volumes
clean:
	$(COMPOSE) down -v

## Hard cleanup (Docker system prune)
prune: clean
	docker system prune -f

# --------------------------
# Health check helpers
# --------------------------

## Check running containers
status:
	$(COMPOSE) ps

## Check logs of all infra
logs-infra:
	$(COMPOSE) logs -f mariadb redis-cache redis-queue redis-socketio