# create staging build
FROM golang:alpine AS builder

WORKDIR /usr/app

COPY ./go/main.go .

# compile main.go
RUN go build -o /bin main.go

# create new stage - empty image (32:19 docker intro video)
FROM scratch

WORKDIR /usr/app

COPY --from=builder ./bin .

CMD [ "./main" ]
