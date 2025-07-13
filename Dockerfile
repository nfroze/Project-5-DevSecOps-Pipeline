FROM node:18-alpine AS builder

# Build stage - install dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

FROM node:18-alpine

# Install dumb-init for proper signal handling
RUN apk add --no-cache dumb-init

# Create non-root user with specific UID/GID matching K8s security context
RUN addgroup -g 10001 -S nodejs && \
    adduser -u 10001 -S nodejs -G nodejs

# Create app directory with correct permissions
WORKDIR /app

# Copy node_modules from builder
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules

# Copy application files
COPY --chown=nodejs:nodejs package*.json ./
COPY --chown=nodejs:nodejs index.js ./
COPY --chown=nodejs:nodejs routes ./routes
COPY --chown=nodejs:nodejs public ./public

# Create temp directory for Node.js
RUN mkdir -p /tmp/app && chown -R nodejs:nodejs /tmp/app

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 3000

# Set Node.js temp directory
ENV NODE_ENV=production
ENV NODE_TMPDIR=/tmp/app

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (res) => {res.on('data', () => {}); res.on('end', () => {process.exit(res.statusCode === 200 ? 0 : 1)})}).on('error', () => {process.exit(1)})"

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "index.js"]