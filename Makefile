.PHONY: cover lint format generate tidy

cover:
	go test -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out

lint:
	golint ./...

format:
	go fmt ./...

generate:
	go generate ./...

tidy:
	go mod tidy
