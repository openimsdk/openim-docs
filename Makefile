tidy:
	@echo "Cleaning up the project..."
	rm -rf tmp/*
	rm -rf bin/*

init:
	@echo "Initializing the project..."
	mkdir -p bin
	mkdir -p tmp

install:
	@echo "Installing dependencies..."
	npm install
