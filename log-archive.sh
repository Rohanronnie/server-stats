#!/bin/bash

# ─────────────────────────────────────────
#  LOG ARCHIVE TOOL
#  Usage: ./log-archive.sh <log-directory>
# ─────────────────────────────────────────

# Step 1 — Check if user provided a directory
if [ -z "$1" ]; then
  echo "Error: No log directory provided."
  echo "Usage: ./log-archive.sh <log-directory>"
  exit 1
fi

LOG_DIR=$1

# Step 2 — Check if the directory actually exists
if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory '$LOG_DIR' does not exist."
  exit 1
fi

# Step 3 — Create archive directory if it doesn't exist
ARCHIVE_DIR=~/log-archives
mkdir -p $ARCHIVE_DIR

# Step 4 — Generate filename with date and time
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

# Step 5 — Compress the logs
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$(dirname $LOG_DIR)" "$(basename $LOG_DIR)"

# Step 6 — Log the archive activity
LOG_FILE="$ARCHIVE_DIR/archive_log.txt"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Archived '$LOG_DIR' → '$ARCHIVE_NAME'" >> $LOG_FILE

# Step 7 — Print success message
echo "✅ Archive created successfully!"
echo "📦 File     : $ARCHIVE_DIR/$ARCHIVE_NAME"
echo "📁 Size     : $(du -sh $ARCHIVE_DIR/$ARCHIVE_NAME | cut -f1)"
echo "📋 Log file : $LOG_FILE"
