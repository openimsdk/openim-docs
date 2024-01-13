.PHONY: cover lint format generate tidy

cover:
	go test ./... -cover

lint:
	golint ./...

format:
	go fmt ./...

generate:
	# Command to generate necessary files

tidy:
	go mod tidy
