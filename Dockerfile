# Use an official Golang runtime as the base image
FROM golang:1.23-alpine AS builder

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install necessary dependencies
RUN apk add --no-cache git

# Build the goblog binary
RUN go build -o bin/goblog cmd/main.go

# Switch to a non-root user for security reasons
USER 1000

# Use an alpine image as the runtime environment
FROM alpine:3.14

# Set the working directory to /app
WORKDIR /app

# Copy the goblog binary from the builder stage to the runtime stage
COPY --from=builder /app/bin/goblog /app/bin/

# Expose the port that the goblog application will run on
EXPOSE 8080

# Start the goblog application when the container starts
CMD ["/app/bin/goblog"]
