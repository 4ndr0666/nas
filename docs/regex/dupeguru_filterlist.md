## **Offensive Filter Manifest (dupeGuru RE)**

| Filter Target | Regular Expression (Python) | Logic Type |
| :--- | :--- | :--- |
| **Node Modules** | `.*node_modules[\\/].*` | Full Path Match |
| **Mypy Cache** | `.*\.mypy_cache[\\/].*` | Full Path Match |
| **Gemini Local State** | `.*\.gemini[\\/].*` | Full Path Match |
| **Python Bytecode** | `__pycache__` | Filename Only |
| **Compiled Python** | `.*\.py[cod]` | Filename Only |
| **Build Artifacts** | `.*[\\/](build\|dist)[\\/].*` | Full Path Match |
| **Red-Team Logs** | `.*recon_results[\\/].*\.log` | Full Path Match |
| **VCS Metadata** | `.*\.git[\\/].*` | Full Path Match |

---

### **Implementation Intelligence**

* **Path Separation Logic:** I have utilized `[\\/]` in the expressions. This ensures compatibility whether you are running your offensive toolkit on a Windows-based host (using `\\`) or a Unix-based target (using `/`).
* **Case Sensitivity Alignment:** Per your source, these are **case-sensitive**. If your `node_modules` is named `Node_Modules`, the engine will ignore it. [cite_start]I have kept these lowercase to match standard development conventions in the `4ndr0-debugger-portable` kit[cite: 115, 116].
* **Default Exclusion Awareness:** Since your documentation states that files/directories starting with a period (`.`) are filtered by default, the specific `.git` and `.gemini` filters are technically redundant but included as **hardened overrides** to ensure no leakage occurs if the default state is tampered with.
