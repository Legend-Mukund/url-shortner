FROM golang:1.22.6
WORKDIR /app
COPY . /app
RUN go get .
RUN go build -o bin/goblog cmd/main.go
EXPOSE 8080
ENTRYPOINT ["/app/bin/goblog"]
