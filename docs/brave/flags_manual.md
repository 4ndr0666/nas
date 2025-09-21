# Flags Manual

1. `--site-per-process`: Enforces a one-site-per-process security policy: 
  * Each renderer process, for its whole lifetime, is dedicated to rendering pages for just one site. 
  * Thus, pages from different sites are never in the same process. 
  * A renderer process's access rights are restricted based on its site. 
  * All cross-site navigations force process swaps. 
  * <iframe>s are rendered out-of-process whenever the src= is cross-site. More details here: -   https://www.chromium.org/developers/design-documents/site-isolation - https://www.chromium.org/developers/design-documents/process-models - The class comment in site_instance.h, listing the supported process models. IMPORTANT: this isn't to be confused with --process-per-site (which is about process consolidation, not isolation). 
