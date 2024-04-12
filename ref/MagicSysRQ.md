## Magic SysRq Key Sequences in Linux

Magic SysRq keys are used on Linux systems to perform system functions during various states of unresponsiveness or for controlled operations. Here are some of the sequences and their uses:

### REISUB - Safely Reboot a Frozen System
- **R**: Switch the keyboard from raw mode to XLATE mode.
- **E**: Send SIGTERM to all processes except init.
- **I**: Send SIGKILL to all processes except init.
- **S**: Sync all mounted filesystems.
- **U**: Remount all filesystems read-only.
- **B**: Reboot the system.

### REISUO - Safely Shut Down a Frozen System
- **O**: Shut off the computer.

### Individual Key Functions
- **ALT + SysRq + F**: Call oom_kill, which kills a process to alleviate an Out of Memory condition.
- **ALT + SysRq + K**: Kill all processes on the current virtual console.
- **ALT + SysRq + S**: Sync all mounted filesystems.
- **ALT + SysRq + E**: Send SIGTERM to all processes except init.
- **ALT + SysRq + I**: Send SIGKILL to all processes except init.
- **ALT + SysRq + U**: Remount all filesystems read-only.

These sequences are part of the Linux kernel's magic SysRq key functionality, enabling users to perform low-level commands regardless of the system's state, assuming the kernel parameter that enables SysRq support is turned on. This can be critical for system administrators and users when the Linux system becomes unresponsive due to software issues.

For detailed usage and additional commands, consult the Linux Kernel documentation or specific Linux distribution support forums.