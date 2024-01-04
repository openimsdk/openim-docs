cover:
	go test -cover ./...

lint:
	golint ./...

format:
	go fmt ./...

generate:
	go generate ./...

tidy:
	cd /path/to/directory/containing/go.mod && go mod tidy
