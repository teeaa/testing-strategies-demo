FROM golang:1.19.5-alpine3.17 as build

ENV GOPATH /go

WORKDIR $GOPATH/src/app

COPY . .

RUN go mod download

RUN go mod tidy

RUN go build ./cmd/server -ldflags "-s -w" -o server

RUN chmod +x server

FROM alpine:3.17

COPY --from=build go/src/app/server /

EXPOSE 8000

ENTRYPOINT [ "./server" ]