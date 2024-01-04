cover:
	go test -cover ./...

lint:
	golint ./...

format:
	go fmt ./...

generate:
	go generate ./...

tidy:
	init:
\techo 'Initializing the project'

install:
\techo 'Installing the project'
