.PHONY: cover lint format generate tidy

cover:
	@echo "Running code coverage script"
	go test ./... -coverprofile=coverage.out
	go tool cover -html=coverage.out -o coverage.html

lint:
	@echo "Running linter"
	golangci-lint run

format:
	@echo "Running formatter"
	# Add the command to run the formatter here

generate:
	@echo "Generating necessary files"
	# Add the command to generate necessary files here

tidy:
	@echo "Running go mod tidy"
	go mod tidy
