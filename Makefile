.PHONY: cover lint format generate tidy

cover:
	@echo "Running code coverage script"
	# Add the command to run the code coverage script here

lint:
	@echo "Running linter"
	# Add the command to run the linter here

format:
	@echo "Running formatter"
	# Add the command to run the formatter here

generate:
	@echo "Generating necessary files"
	# Add the command to generate necessary files here

tidy:
	@echo "Running go mod tidy"
	go mod tidy
