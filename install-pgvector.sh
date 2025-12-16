#!/bin/bash
set -e

# Navigate to in-dyno PostgreSQL extension directory
cd /app/.indyno/vendor/postgresql/share/extension

# Clone pgvector repository (version 0.8.1)
git clone --branch v0.8.1 https://github.com/pgvector/pgvector.git

# Navigate into the cloned directory
cd pgvector

# Set PostgreSQL config path
export PG_CONFIG=/app/.indyno/vendor/postgresql/bin/pg_config

# Build and install pgvector
make
make install

# Copy vector extension files into the expected location for in-dyno
cp -r /app/.indyno/vendor/postgresql/include/server/extension/vector /app/.indyno/vendor/postgresql/share/extension

# Create the vector extension in the database
psql $DATABASE_URL -c "create extension vector;"
