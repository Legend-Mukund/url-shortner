# Use an official Go image.
# https://hub.docker.com/_/golang
FROM golang:1.22.6

# Set the working directory to /app.
WORKDIR /app

# Copy the current directory contents into the container at /app.
COPY . /app

# Run go get to download the dependencies.
RUN go get -d -v .

# Build the Go binary using go build.
RUN go build -o bin/goblog cmd/main.go

# Expose port 8080 to the world.
EXPOSE 8080

# Set the entrypoint to be the goblog binary.
ENTRYPOINT ["/app/bin/goblog"]
