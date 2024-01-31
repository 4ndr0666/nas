# --- Banner
echo -e "\033[34m"
cat << "EOF"
# --- ASCII ART
EOF
echo -e "\033[0m"

# --- Escalate
if [ "$(id -u)" -ne 0 ]; then
  sudo "$0" "$@"
  exit $?
fi

# --- Handle errors
handle_error() {
  local exit_code=$?
  if [ $exit_code -ne 0 ]; then
    echo "Error [Exit Code: $exit_code]"
    exit $exit_code
  fi
}

# Initialize a stack to keep track of backup files
backup_stack=()

# Function to backup a file before modification
backup_file() {
  local original_file="$1"
  local backup_file="${original_file}.backup_$(date +%s)"
  cp "$original_file" "$backup_file" || return 1
  backup_stack+=("$backup_file")
}

# Function to rollback changes
rollback() {
  for backup in "${backup_stack[@]}"; do
    original="${backup%.backup_*}"
    mv "$backup" "$original"
  done
  backup_stack=()
}

# Enhanced error handler with rollback
handle_error() {
  local exit_code=$?
  if [ $exit_code -ne 0 ]; then
    echo "Error occurred. Rolling back..."
    rollback
    exit $exit_code
  fi
}
