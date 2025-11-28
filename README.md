# php5.6-fpm-bullseye
# PHP 5.6 FPM on Debian 11 (Bullseye)

[![Build and Push to Docker Hub](https://github.com/stadeleon/php5.6-fpm-bullseye/actions/workflows/docker-hub-push.yml/badge.svg)](https://github.com/stadeleon/php5.6-fpm-bullseye/actions/workflows/docker-hub-push.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/stadeleon/php5.6-fpm-bullseye)](https://hub.docker.com/r/stadeleon/php5.6-fpm-bullseye)
[![Docker Image Size](https://img.shields.io/docker/image-size/stadeleon/php5.6-fpm-bullseye/latest)](https://hub.docker.com/r/stadeleon/php5.6-fpm-bullseye)

Debian 11 (Bullseye) base image with PHP 5.6 FPM from [Ondřej Surý's repository](https://packages.sury.org/php/).

## 🚀 Quick Start

```bash
docker pull stadeleon/php5.6-fpm-bullseye:latest
```

## 📦 What's Inside

### Operating System
- **Debian 11 (Bullseye)** - Latest stable Debian release

### PHP 5.6 FPM
- **Version:** 5.6.40 from trusted Sury repository
- **Extensions:** opcache, json, xml, readline, cli, common
- **Configuration:** Ready for production use

### System Tools
- **Network:** curl, wget, iputils-ping, net-tools, telnet
- **Editors:** vim
- **Monitoring:** htop
- **Security:** gnupg2, ca-certificates
- **Package Management:** apt-transport-https, lsb-release

### Architecture
- **Multi-arch support:** linux/amd64, linux/arm64
- **Image size:** ~250-280 MB compressed

## 💻 Usage

### Basic Dockerfile:

```dockerfile
FROM stadeleon/php5.6-fpm-bullseye:latest

# Install additional PHP extensions
RUN apt-get update && apt-get install -y \
    php5.6-mysql \
    php5.6-redis \
    php5.6-gd \
    php5.6-curl \
    php5.6-mbstring \
    && rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app
```

### With Docker Compose:

```yaml
version: '3.8'

services:
  app:
    image: stadeleon/php5.6-fpm-bullseye:latest
    volumes:
      - ./:/var/www/html
    ports:
      - "9000:9000"
    environment:
      - TZ=UTC
```

### With nginx:

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./:/var/www/html
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - app

  app:
    image: stadeleon/php5.6-fpm-bullseye:latest
    volumes:
      - ./:/var/www/html
```

## 🔌 PHP Extensions

### Pre-installed:
- **Core:** date, ereg, filter, hash, libxml, openssl, pcre, Reflection, SPL, standard, zlib
- **PHP Modules:** cli, fpm, common, json, xml, opcache, readline

### Available for installation via apt:

#### Database Drivers
```bash
php5.6-mysql php5.6-pgsql php5.6-sqlite3 php5.6-odbc
```

#### Caching & Performance
```bash
php5.6-redis php5.6-memcached php5.6-memcache
php5.6-igbinary php5.6-msgpack php5.6-apcu
```

#### Image Processing
```bash
php5.6-gd php5.6-imagick
```

#### String & Data Processing
```bash
php5.6-curl php5.6-mbstring php5.6-xml php5.6-zip
php5.6-bcmath php5.6-intl php5.6-gmp php5.6-soap
```

#### Message Queues & Communication
```bash
php5.6-gearman php5.6-amqp php5.6-zmq
```

#### Security & Authentication
```bash
php5.6-mcrypt php5.6-ldap php5.6-ssh2
```

#### Development & Debugging
```bash
php5.6-xdebug php5.6-dev
```

#### Other Extensions
```bash
php5.6-xmlrpc php5.6-imap php5.6-tidy
```

### Installation Example:

```dockerfile
FROM stadeleon/php5.6-fpm-bullseye:latest

RUN apt-get update && apt-get install -y \
    php5.6-mysql \
    php5.6-redis \
    php5.6-memcached \
    php5.6-gd \
    php5.6-curl \
    php5.6-mbstring \
    php5.6-xml \
    php5.6-zip \
    php5.6-bcmath \
    php5.6-intl \
    php5.6-gearman \
    && rm -rf /var/lib/apt/lists/*
```

## 🛠️ System Tools Included

### Network Diagnostics
```bash
# Test connectivity
docker exec <container> ping google.com
docker exec <container> curl https://example.com
docker exec <container> wget https://example.com

# Network information
docker exec <container> ifconfig
docker exec <container> netstat -tuln
docker exec <container> telnet localhost 3306
```

### System Monitoring
```bash
# Process monitoring
docker exec -it <container> htop

# View PHP-FPM processes
docker exec <container> ps aux | grep php-fpm
```

### File Editing
```bash
# Edit configuration files
docker exec -it <container> vim /etc/php/5.6/fpm/php.ini
```

## 🏷️ Available Tags

- `latest` - Latest stable build from main branch
- `v1.0.0` - Specific version (semantic versioning)
- `v1.0` - Latest patch version of 1.0.x
- `v1` - Latest minor version of 1.x.x
- `main` - Development build from main branch

## 🔧 Building Locally

```bash
# Clone repository
git clone https://github.com/stadeleon/php5.6-fpm-bullseye.git
cd php5.6-fpm-bullseye

# Build image
docker build -t php5.6-fpm-bullseye .

# Run container
docker run -d -p 9000:9000 php5.6-fpm-bullseye

# Test PHP version
docker exec <container> php -v
```

## 📊 Image Details

| Component | Version/Details |
|-----------|----------------|
| **Base OS** | Debian 11 (Bullseye) |
| **PHP Version** | 5.6.40 |
| **PHP SAPI** | FPM (FastCGI Process Manager) |
| **Architecture** | amd64, arm64 |
| **Compressed Size** | ~250-280 MB |
| **Uncompressed Size** | ~700-800 MB |

## 🔐 Security

This image includes:
- ✅ GPG verification for all packages via `gnupg2`
- ✅ Trusted CA certificates via `ca-certificates`
- ✅ Secure APT transport via `apt-transport-https`
- ✅ PHP from official Sury repository with security updates

## 🚀 Production Recommendations

### Minimal Production Image

For production, extend this base image and install only required extensions:

```dockerfile
FROM stadeleon/php5.6-fpm-bullseye:latest

# Install only necessary extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    php5.6-mysql \
    php5.6-opcache \
    php5.6-mbstring \
    php5.6-xml \
    && rm -rf /var/lib/apt/lists/*

# Copy application code
COPY --chown=www-data:www-data . /var/www/html
WORKDIR /var/www/html

# Run as non-root user
USER www-data
```

### Performance Tuning

Configure PHP-FPM for production:

```dockerfile
FROM stadeleon/php5.6-fpm-bullseye:latest

# Copy optimized PHP-FPM pool configuration
COPY php-fpm-pool.conf /etc/php/5.6/fpm/pool.d/www.conf

# Copy optimized php.ini
COPY php.ini /etc/php/5.6/fpm/php.ini
```

## 🐛 Troubleshooting

### Check PHP-FPM status
```bash
docker exec <container> php-fpm5.6 -t  # Test configuration
docker exec <container> php-fpm5.6 -v  # Show version
```

### View PHP configuration
```bash
docker exec <container> php -i  # phpinfo()
docker exec <container> php -m  # List modules
```

### Check network connectivity
```bash
docker exec <container> ping -c 4 8.8.8.8
docker exec <container> curl -I https://packages.sury.org
```

### Inspect running processes
```bash
docker exec <container> htop
docker exec <container> ps aux
```

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details

## 🙏 Credits

- **PHP packages** maintained by [Ondřej Surý](https://github.com/oerdnj)
- **Base image:** Official [Debian Docker image](https://hub.docker.com/_/debian)
- **Repository:** [Sury PHP Repository](https://packages.sury.org/php/)

## 🔗 Links

- **Docker Hub:** https://hub.docker.com/r/stadeleon/php5.6-fpm-bullseye
- **GitHub Repository:** https://github.com/stadeleon/php5.6-fpm-bullseye
- **Sury PHP Repository:** https://packages.sury.org/php/
- **Issue Tracker:** https://github.com/stadeleon/php5.6-fpm-bullseye/issues

## 📮 Support

- **Issues:** Report bugs or request features via [GitHub Issues](https://github.com/stadeleon/php5.6-fpm-bullseye/issues)
- **Discussions:** Ask questions in [GitHub Discussions](https://github.com/stadeleon/php5.6-fpm-bullseye/discussions)

---

**Note:** PHP 5.6 reached End of Life (EOL) in January 2019. This image is maintained for legacy applications only. Consider upgrading to PHP 7.4+ for security and performance benefits.
