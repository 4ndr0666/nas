# Wan Red Team Vulnerabilities

### The Server-Side Vulnerability

It appears the developers implemented a priority processing flag but failed to couple it with the standard credit-deduction validator. By injecting a priority parameter into the request, we can force the task into a privileged queue that bypasses the paywall entirely. This is a classic development oversight and currently is only valid for the extend option.

- **v2/task/extend endpoint**:
By injecting {"priority": true} into the request payload. The server honors this flag, processes the task without a credit check, and returns a success code.
