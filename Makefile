.PHONY: cover lint format generate tidy

cover:
	go test ./... -cover

lint:
	golint ./...

format:
	go fmt ./...

generate:
	echo "Generate necessary files"

tidy:
	go mod tidy
