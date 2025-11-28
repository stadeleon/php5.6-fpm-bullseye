FROM debian:11-slim

LABEL authors="StaDeLeon"
LABEL maintainer="stadeleons@gmail.com"
LABEL description="Debian 11 (Bullseye) with PHP 5.6 FPM from Sury repository"
LABEL org.opencontainers.image.source="https://github.com/stadeleon/php5.6-fpm-bullseye"
LABEL org.opencontainers.image.licenses="MIT"
LABEL version="1.0.0"

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Configure timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install basic dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  curl \
  vim \
  iputils-ping \
  net-tools \
  telnet \
  htop \
  gnupg2 \
  ca-certificates \
  apt-transport-https \
  lsb-release \
  && rm -rf /var/lib/apt/lists/*

# Add Sury PHP repository for Debian 11 (Bullseye)
RUN wget -qO /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
  && echo "deb https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php.list

# Install PHP 5.6 FPM with essential extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
  php5.6-fpm \
  php5.6-cli \
  php5.6-common \
  php5.6-json \
  php5.6-xml \
  php5.6-opcache \
  php5.6-readline \
  && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM to run in foreground
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php/5.6/fpm/php-fpm.conf

# Create php-fpm run directory
RUN mkdir -p /run/php && chmod 755 /run/php

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose PHP-FPM port
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm5.6"]