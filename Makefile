.PHONY: fmt lint test build clean
.PHONY: docker/build docker/clean

bin/librarian-cli: cmd/librarian-cli/main.go
	go build -o bin/librarian-cli cmd/librarian-cli/main.go

bin/librarian-server: cmd/librarian-server/main.go
	go build -o bin/librarian-server cmd/librarian-server/main.go

fmt:
	go fmt ./...
lint:
	go vet ./...

test:
	go test ./...

build: bin/librarian-cli bin/librarian-server

clean:
	rm -rf bin

.docker_build: cmd/librarian-cli/main.go cmd/librarian-server/main.go go.mod
	docker build -t librarian-cli:latest -f cmd/librarian-cli/Dockerfile .
	docker build -t librarian-server:latest -f cmd/librarian-server/Dockerfile .
	touch .docker_build

docker/build: .docker_build

docker/clean:
	rm -f .docker_build
