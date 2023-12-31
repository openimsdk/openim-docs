.PHONY: cover lint format generate tidy

cover:
	go test -cover ./...

lint:
	golint ./...

format:
	go fmt ./...

generate:
	go generate ./...

tidy:
	go mod tidy
