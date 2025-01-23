FROM --platform=linux/arm64/v8 golang:1.17 AS builder
COPY . /var/app
WORKDIR /var/app
RUN CGO_ENABLED=0 go build -o app .

FROM --platform=linux/arm64/v8 alpine:3.14
LABEL org.opencontainers.image.source https://github.com/aalekh-jar/manual-approval-arm
RUN apk update && apk add ca-certificates
COPY --from=builder /var/app/app /var/app/app
CMD ["/var/app/app"]
