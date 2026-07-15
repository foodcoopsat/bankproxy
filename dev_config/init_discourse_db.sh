#!/usr/bin/env bash
set -e

DB_NAME="discourse"
DB_USER="root"
DB_HOST="${DB_HOST:-postgres}"

export PGPASSWORD="${PGPASSWORD:-secret}"

echo "Checking if database '$DB_NAME' exists..."

if ! psql -h "$DB_HOST" -U "$DB_USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'" | grep -q 1; then
  echo "Creating database '$DB_NAME'..."
  psql -h "$DB_HOST" -U "$DB_USER" -d postgres -c "CREATE DATABASE $DB_NAME;"
else
  echo "Database '$DB_NAME' already exists."
fi
