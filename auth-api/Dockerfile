# Stage 1: Compile  
FROM golang:1.23-alpine AS builder  
WORKDIR /app  
COPY go.mod go.sum ./  
RUN go mod download  
COPY . .  
RUN CGO_ENABLED=0 GOOS=linux go build -o auth-api ./cmd/auth-api  

# Stage 2: Minimal runtime  
FROM alpine:3.18  
RUN apk add --no-cache ca-certificates  
WORKDIR /  
COPY --from=builder /app/auth-api /auth-api  
EXPOSE 8000  
ENTRYPOINT ["/auth-api"]
