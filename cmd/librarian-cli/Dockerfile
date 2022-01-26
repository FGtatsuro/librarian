FROM golang:alpine AS builder

RUN mkdir -p /workdir /cmd/librarian-cli
WORKDIR /workdir

COPY go.mod ./
COPY cmd/librarian-cli /cmd/librarian-cli

RUN CGO_ENABLED=0 go build -o /librarian-cli /cmd/librarian-cli/main.go


FROM scratch AS runner

COPY --from=builder /librarian-cli /librarian-cli
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/librarian-cli"]
