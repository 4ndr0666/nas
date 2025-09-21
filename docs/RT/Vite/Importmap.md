# AI Studio Projects

### Vite
These projects/apps are setup to use Vite, a modern build tool that handles module imports, including path aliases like `@/`. 

**Conflicts**:
The `Index.html` file may also contain an `importmap`, which tells the browser to load dependencies like React directly from a CDN. This creates a conflict: the `importmap` is bypassing Vite's module resolution system, so when the browser encounters an aliased path like "@/Components/Icons", it doesn't know how to handle it.

---

## Solution

The correct approach for a Vite-based project is to let Vite manage all module resolution. Remove the line `<script type="importmap">`. This will delegate full control over module imports back to Vite, allowing it to correctly resolve both your dependencies from node_modules and your custom path aliases.*
