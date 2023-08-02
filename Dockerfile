# create staging build
FROM golang:1.17.2-alpine3.14 AS builder

WORKDIR /usr/app

COPY ./go/main.go .

# compile main.go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -o /bin/main -a -gcflags=all="-l -B -wb=false" -ldflags="-w -s" main.go

# create new stage - empty image (32:19 docker intro video)
FROM scratch

WORKDIR /usr/app

COPY --from=builder ./bin .

CMD [ "./main" ]
