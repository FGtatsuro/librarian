FROM golang:alpine AS builder

RUN mkdir -p /workdir /cmd/librarian-server
WORKDIR /workdir

COPY go.mod ./
COPY cmd/librarian-server /cmd/librarian-cli

RUN CGO_ENABLED=0 go build -o /librarian-server /cmd/librarian-cli/main.go


FROM scratch AS runner

COPY --from=builder /librarian-server /librarian-server
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/librarian-server"]
