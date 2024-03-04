.PHONY: cover lint format generate tidy

cover:
	go test -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html

lint:
	golangci-lint run ./...

format:
	gofmt -s -w .

generate:
	go generate ./...

tidy:
	go mod tidy
