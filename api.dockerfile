#FROM golang:1.10
#
#RUN mkdir -p /go/src/github.com/yusufsyaifudin/go-kafka-example
#ADD . /go/src/github.com/yusufsyaifudin/go-kafka-example/
#WORKDIR /go/src/github.com/yusufsyaifudin/go-kafka-example
#RUN go get -u github.com/golang/dep/cmd/dep
#RUN dep ensure -v
#RUN go build -o api -i cmd/api/main.go
#CMD ["/go/src/github.com/yusufsyaifudin/go-kafka-example/api"]

# syntax=docker/dockerfile:1

## Build
FROM golang:1.20.2-alpine3.17 AS build

WORKDIR /app

# Install dependencies
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy source code
COPY ./cmd/api ./
#COPY ./internal ./internal
#COPY ./pkg ./pkg

# Build the binary
RUN go build -o /api

## Deploy
FROM scratch

# Copy our static executable
COPY --from=build /api /api
#COPY backend.env /

EXPOSE 9091

# USER nonroot:nonroot

# Run the binary
ENTRYPOINT ["/api"]
