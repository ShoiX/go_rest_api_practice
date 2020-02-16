FROM golang:alpine

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Move to working directory /build
WORKDIR /app

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy the code into the container
COPY . .

# skip building of binary
# air handles building of binary for dev

# Export necessary port
EXPOSE 8080
# RUN echo $GOPATH
# RUN echo $GOROOT
# run echo $PATH
# WORKDIR $GOPATH/bin
RUN go get -u github.com/cosmtrek/air

# Command to run when starting the container
cmd air -c air.conf