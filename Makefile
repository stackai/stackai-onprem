.PHONY: help
help:
	@echo "Makefile commands:"
	@echo "  initialize_mongodb: Launch the script that is responsible for installing the templates in the MongoDB database"
	@echo "  install-environment-variables: Launch the script that is responsible for setting up the environment variables"
	@echo "  setup-docker-in-ubuntu: Launch the script that is responsible for setting up Docker in Ubuntu"
	@echo "  start-supabase: Start the Supabase services"
	@echo "  stop-supabase: Stop the Supabase services"
	@echo "  help: Show this help message"

.PHONY: initialize_mongodb
initialize_mongodb:
	@echo "Installing MongoDB templates..."
	@cd scripts/mongodb && \
		chmod +x initialize_mongodb.sh && \
		./initialize_mongodb.sh
	@echo "MongoDB templates installed successfully"

.PHONY: install-environment-variables
install-environment-variables:
	@echo "Installing environment variables..."
	@cd scripts/environment_variables && \
		chmod +x initialize_variables.sh && \
		./initialize_variables.sh
	@echo "Environment variables installed successfully"


.PHONY: start-supabase
start-supabase:
	@echo "Starting Supabase..."
	docker compose up studio kong auth rest realtime storage imgproxy meta functions analytics db vector supavisor

.PHONY: stop-supabase
stop-supabase:
	@echo "Stopping Supabase..."
	docker compose stop studio kong auth rest realtime storage imgproxy meta functions analytics db vector supavisor
	@echo "Supabase stopped successfully"


.PHONY: setup-docker-in-ubuntu
setup-docker-in-ubuntu:
	@echo "Setting up Docker in Ubuntu..."
	@cd scripts/docker && \
		chmod +x ubuntu_server_pre_setup.sh && \
		./ubuntu_server_pre_setup.sh
	@echo "Docker setup in Ubuntu completed successfully"


.PHONY: run-postgres-migrations
run-postgres-migrations:
	@echo "Running Postgres migrations..."
	docker compose exec stackend bash -c "cd infra/migrations/postgres && alembic upgrade head"
	@echo "Postgres migrations completed successfully"
