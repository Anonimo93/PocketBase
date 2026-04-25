FROM alpine:latest

# Update to the latest stable version (as of April 2026)
ARG PB_VERSION=0.37.3

RUN apk add --no-cache \
    unzip \
    ca-certificates

# Download and extract PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v\( {PB_VERSION}/pocketbase_ \){PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ \
    && rm /tmp/pb.zip \
    && chmod +x /pb/pocketbase

# Optional: Copy your custom migrations (uncomment if needed)
# COPY ./pb_migrations /pb/pb_migrations

# Optional: Copy your custom hooks (uncomment if needed)
# COPY ./pb_hooks /pb/pb_hooks

# Create pb_data directory (helps with volume mounting)
RUN mkdir -p /pb/pb_data

EXPOSE 8080

# Start PocketBase (default port is 8080)
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
