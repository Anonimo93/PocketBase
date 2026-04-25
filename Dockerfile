FROM alpine:latest

# Set the PocketBase version (update this when a new version comes out)
ARG PB_VERSION=0.37.3

RUN apk add --no-cache \
    unzip \
    ca-certificates \
    wget

# Download and extract PocketBase
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v\( {PB_VERSION}/pocketbase_ \){PB_VERSION}_linux_amd64.zip \
    -O /tmp/pb.zip && \
    unzip /tmp/pb.zip -d /pb/ && \
    rm /tmp/pb.zip && \
    chmod +x /pb/pocketbase

# Optional: copy your migrations/hooks if you use them
# COPY ./pb_migrations /pb/pb_migrations
# COPY ./pb_hooks /pb/pb_hooks

# Create data directory (good for volume mounting)
RUN mkdir -p /pb/pb_data

EXPOSE 8080

# Start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
