# Use the official Golang image as the base image.
FROM golang:1.18-alpine AS build

# Set the working directory in the container.
WORKDIR /app

# Copy the current directory contents into the container at /app.
COPY . /app

# Download and install dependencies.
RUN go mod download

# Build the binary.
RUN go build -o bin/goblog cmd/main.go

# Use a smaller image to deploy the application.
FROM alpine:latest

# Set the working directory in the container.
WORKDIR /app

# Copy the binary from the build stage.
COPY --from=build /app/gobot .

EXPOSE 8080

# Run the binary.
CMD ["/app/bin/goblog"]
