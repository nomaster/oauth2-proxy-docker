FROM golang as builder
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go get github.com/bitly/oauth2_proxy

FROM alpine as certs
RUN apk add --update ca-certificates

FROM scratch
CMD ["/go/bin/oauth2_proxy"]
EXPOSE 80
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/bin/oauth2_proxy /go/bin/
