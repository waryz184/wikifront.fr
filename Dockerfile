# ===== STAGE 1: Build MkDocs =====
FROM python:3.13-slim AS builder

WORKDIR /app

# Install MkDocs et le thème Material
RUN pip install --no-cache-dir mkdocs mkdocs-material

# Copier les sources MkDocs
COPY docs/ docs/
COPY mkdocs.yml .

# Builder le site statique
RUN mkdocs build --clean

# ===== STAGE 2: Serveur nginx minimal =====
FROM nginx:alpine

# Copier le site généré dans le dossier servi par nginx
COPY --from=builder /app/site /usr/share/nginx/html

# Config nginx : compression, cache, SPA-friendly
RUN echo '\
server {\
    listen 8080;\
    server_name _;\
    root /usr/share/nginx/html;\
    index index.html;\
    location / {\
        try_files $uri $uri/ =404;\
    }\
    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg|webp)$ {\
        expires 30d;\
        add_header Cache-Control "public, immutable";\
    }\
    gzip on;\
    gzip_types text/plain text/css text/javascript application/javascript image/svg+xml;\
}' > /etc/nginx/conf.d/default.conf

# Cloud Run fournit le port via PORT, mais on fixe 8080 dans la config
# nginx écoute par défaut sur 8080 dans le container
EXPOSE 8080

# Santé : nginx gère tout seul
CMD ["nginx", "-g", "daemon off;"]