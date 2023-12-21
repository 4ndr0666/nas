```bash
# Initialize the rollback stack
ROLLBACK_STACK=()

# Function to add a command to the rollback stack
push_to_rollback() {
  ROLLBACK_STACK+=("$1")
}

# Function to execute the rollback
execute_rollback() {
  for cmd in "${ROLLBACK_STACK[@]}"; do
    eval "$cmd"
  done
}
```

This gives us a simple but effective rollback mechanism. We can add rollback commands using `push_to_rollback` and execute them with `execute_rollback`.

#### Example Usage:

```bash
# Adding a new user
adduser newuser
# Adding the corresponding rollback command
push_to_rollback "deluser newuser"

# Creating a new file
touch /tmp/newfile
# Adding the corresponding rollback command
push_to_rollback "rm -f /tmp/newfile"
```

If something goes wrong:

```bash
execute_rollback  # This will remove the new user and delete the new file
```
