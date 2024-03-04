.PHONY: cover lint format generate tidy

cover:
	go test -cover ./...

lint:
	golangci-lint run ./...

format:
	go fmt ./...

generate:
	go generate ./...

tidy:
	go mod tidy
