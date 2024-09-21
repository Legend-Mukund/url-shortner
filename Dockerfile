# Use the official Go image with Alpine Linux
FROM golang:1.23-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Install any additional packages needed
RUN apk add --no-cache git

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o bin/goblog cmd/main.go

# Start a new stage from scratch with an even smaller image
FROM alpine:3.18

# Install certificates (if your app needs to make HTTPS requests)
RUN apk add --no-cache ca-certificates

# Copy the pre-built binary file from the previous stage
COPY --from=builder /app/bin/goblog /usr/local/bin/goblog

# Expose the port the app runs on
EXPOSE 8080

# Command to run the executable
CMD ["goblog"]
