FROM ubuntu:24.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    wget \
    gnupg \
    apt-transport-https \
    ca-certificates \
    lsb-release \
    git \
    && mkdir -p /etc/apt/keyrings \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy init script and run it
COPY init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh && /tmp/init.sh

# Set default working directory
WORKDIR /root

CMD ["/bin/bash"]
