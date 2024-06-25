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
	go fmt ./...

generate:
	@echo "Generating necessary files"
	go generate ./...

tidy:
	@echo "Running go mod tidy"
	go mod tidy
