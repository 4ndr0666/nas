# Brave Browser Technical Analysis (Arch Linux Focus)

## Project Structure and Build Workflow

Brave Browser is built on the open-source **Chromium** engine, with Brave-specific modifications layered via the **Brave Core** project. The build system is organized as follows:

* **Primary Repositories**: The GitHub **`brave/brave-browser`** repo contains build scripts and configuration for desktop platforms (Linux, macOS, Windows). It pulls in two major codebases:

  * **Chromium Source** – fetched using Google’s depot\_tools at a specific Chromium tag (e.g. `65.0.x` or `118.x`) as defined in Brave’s package manifest.
  * **Brave Core** – the Brave-specific code, fetched into `src/brave`. This includes Brave’s features (Shields, Rewards, Wallet, etc.) and **patches** to Chromium.
* **Patching Mechanism**: After syncing the code, Brave’s build hooks automatically **apply a series of patches to the Chromium source**. These patch files (maintained in the `brave-core` repo) alter or remove certain Chromium features and integrate Brave’s components. (The patch set can be inspected under `brave-core/patches`.) In essence, Brave Core “injects” Brave-specific changes into the Chromium codebase during the build process.

Brave also brings in additional Brave-maintained modules. Notably, the **Brave Ad Block engine** is implemented in Rust and included as a dependency (`adblock-rust` via a FFI bridge) for performant content filtering. The Brave Core DEPS file pulls such submodules (including a “brave-extension” component that contains built-in extension code).

**Directory Layout**: Once `npm run init` is done (see Build Workflow below), you will have a `src/` directory containing the entire Chromium source and a `src/brave/` subfolder with Brave Core. Brave’s custom code is largely under `brave/*` (e.g. `brave/browser/...`, `brave/components/...`) whereas patched Chromium code lives in its normal locations but with Brave’s changes applied.

## Brave vs Chromium: Integrations and Removed Features

Brave’s philosophy is to **add privacy features** on top of Chromium and **strip out or neutralize** aspects that conflict with privacy or decentralization. Many of Chromium’s built-in services have been modified as follows:

* **Removed Google Integration**: Brave **disables Chromium’s Google account (GAIA) login integration**. All Chrome-specific “phone home” services are turned off – *metrics reporting, Google safe-browsing updates (directly to Google), Google Sync, etc.* are either removed from settings or stubbed out. For example, Brave deletes or disables code that would upload usage statistics, RLZ tracking, or connectivity checks to Google servers.
* **Disabled Web Features**: By default, Brave **turns off certain APIs and features for privacy**. Via patches, Brave sets many features as disabled at runtime:

  * Network prediction / DNS prefetching (disabled to prevent connection leaks).
  * Google’s “URL Tracker” and navigation error suggestions.
  * Background sync, Google Cloud Messaging, and Firebase Push messaging in Chromium are all disabled.
  * Miscellaneous web APIs that could be used for fingerprinting or tracking are turned off: e.g. the Battery Status API, WebBluetooth, WebUSB, *Idle Detection*, device *Motion sensors*, *Network Information API*, etc. are patched out or disabled by Brave. (Brave often preemptively disables experimental or privacy-risky APIs like FLoC and Topics as well.)
  * Hyperlink auditing (`<a ping>` attributes) is disabled by default.
* **Default Feature Flags**: Brave uses Chromium’s feature flag system to disable certain components on launch. For instance, the Brave code appends a list of `--disable-features=<FeatureNames>` at startup to ensure things like *Chrome Cleanup*, *Safe Browsing Extended Reporting*, *Notification triggers*, *Idle Detection*, etc., stay off. (These flags are set internally so the user doesn’t need to supply them.)
* **Brave Additions**: Conversely, Brave adds its own features on top of Chromium:

  * **Brave Shields** (ad/tracker blocking, anti-fingerprinting), implemented partly as a Rust library and partly as a “Brave extension” that hooks into browser events.
  * **Brave Rewards** (integrated BAT wallet and advertising system).
  * **Brave Wallet** (built-in crypto wallet).
  * **Tor private browsing mode**, which integrates Tor routing for incognito windows.
  * **IPFS support** for `.ipfs` addresses and content resolution.
  * **Brave News**, **Brave Search** as default engine, etc.
    These are mostly implemented in the Brave Core codebase and do not exist in vanilla Chromium.
* **Service Proxying**: For certain necessary services, Brave uses its own proxy servers to preserve privacy. For example, Safe Browsing update requests, geolocation lookups, and even Chrome’s component updater calls are **proxied through Brave’s servers** so that Google cannot identify the client. (Brave fetches Google SafeBrowsing lists via its own API proxy, and geolocation API requests are forwarded through Brave’s servers with no client IP info passed to Google.)

All these deviations are managed via the patching system in Brave Core. Brave’s Help Center explicitly documents that these patches *“remove or disable features that send data to Google”* and similar, to align the browser with Brave’s privacy policy. Essentially, **Chromium is the engine, but Brave supplies the steering** – stripping out Google’s cloud integration and adding in a privacy-preserving feature stack.

*(For a detailed list of services removed or altered, see Brave’s support article on “what Brave removes from Chromium” which enumerates each change.)*

## Build System and Automation (Arch Linux Perspective)

Building Brave from source on an Arch Linux system requires a robust setup, but Brave’s build system provides scripts to automate much of the process. The high-level build workflow:

1. **Install Prerequisites**: You’ll need **Node.js**, **npm**, Python, and the usual C++ build toolchain (Clang, Ninja, etc.) as per Chromium’s requirements. (In 2024, Brave started enforcing a specific Node.js version in its build scripts to avoid incompatibilities – ensure you use the recommended Node LTS version. For example, Node v15 caused init script failures whereas Node v12 worked for Brave 1.21; this is now addressed by checks in the build.)
2. **Clone Repos**: The Brave Browser repo (`brave-browser`) acts as a wrapper. On Arch, you can clone it directly or use the AUR’s PKGBUILD. A manual clone example:

   ```bash
   git clone https://github.com/brave/brave-browser.git && cd brave-browser
   npm install   # installs build scripts and tools listed in package.json
   ```

   Next, Brave’s scripts will fetch Brave Core and Chromium:

   ```bash
   cd brave-browser
   npm run init
   ```

   The `init` step performs a **gclient sync**: it downloads the specified Chromium version into `./src` and clones the `brave/brave-core` repository into `./src/brave`. This is a large download (tens of gigabytes; expect \~100+ GB disk usage for a full build). The script output will show *“Performing initial checkout of brave-core…”* and then run `gclient` to fetch Chromium. After fetching, **hook scripts apply Brave’s patches** automatically – you’ll see messages about patch files being applied.

   * **Note**: The `npm run init` script is meant to be run once. It will fail if run again without cleaning, since it won’t clone over an existing `src/brave` directory (you’d need to remove or move the old `src/brave` first to re-init). In other words, the init process isn’t fully idempotent. However, Brave provides a separate **sync script** (below) to handle subsequent updates without wiping everything.
3. **Configuration & Build Flags**: Brave’s build uses **GN** (generate ninja) like Chromium. Build configuration flags are set in `args.gn` via scripts. Brave has some custom build flags controlled by a `.env` file in `brave-core`. Official Brave builds require certain API keys and identifiers (for integrating services like Binance, Uphold, etc.). For example, `binance_client_id`, `brave_google_api_key`, `brave_infura_project_id`, etc., are expected in an official build. **Community/third-party builds (like AUR)** can supply dummy values for these in `.env` (or let them unset) – the browser will simply disable those particular integrations if real keys are not present. In practice, the Arch build sets `is_official_build=false` and omits the proprietary keys, meaning some branded services (like Brave VPN or certain widget integrations) won’t function, but the core browser works fully.

   * The Arch Linux maintainers apply a few patches to adapt Brave’s build to the distro. For instance, they **disable use of Google’s prebuilt sysroots** and use Arch system libraries instead (patching `BUILD.gn` to skip adding Google’s Linux sysroot libs). They also adjust how ICU data files are handled (only include `icudtl.dat` if building with a separate ICU data file). These patches ensure Brave builds cleanly with Arch’s toolchain and FHS layout.
4. **Compile the Browser**: After init, simply run:

   ```bash
   npm run build
   ```

   By default this triggers a **“component” build** (which produces multiple `.so` component libs – faster linking, good for development). Other build variants:

   * **Release build** (optimized, static linking): `npm run build Release` – this enables LTO and full optimization. **Note:** A full Release build can be extremely slow and memory-intensive on Linux (the LLVM gold plugin LTO linker can use 16GB+ of RAM). Expect hours of build time on a multi-core CPU for a Release build of Brave.
   * **Static build**: `npm run build -- Static` – this forces a statically-linked build (monolithic binary) which takes even longer to compile but may start up slightly faster.
   * **Debug build**: `npm run build -- Debug` – compiles with `is_debug=true` (unoptimized, with symbols) for debugging.
     These correspond to different GN args sets. In practice, Arch’s official Brave package uses a release build type with certain optimizations suitable for distribution.
5. **Run and Test**: Once built, you can run the binary. Brave provides a convenient launcher:

   ```bash
   npm start            # Runs the default (component) build
   npm start Release    # Runs the Release build
   ```

   This effectively executes the `brave` binary from the output directory with proper LD\_LIBRARY\_PATH for component builds.

**Build Automation & Idempotency**: Brave’s dev workflow includes a powerful sync script to handle updates and ensure consistency:

* **`npm run sync`**: This script will synchronize Brave Core and (optionally) Chromium to the latest revisions and re-apply patches. It’s very useful for maintaining an updated source tree:

  * With no arguments, `npm run sync` checks if Chromium’s version (as listed in package.json) changed, and if not, it just updates Brave Core to latest on its branch and re-applies any changed patches. It will also update dependent submodules if needed.
  * `npm run sync -- --force` forces updating both Brave Core *and* Chromium to the tip of their expected branches, and re-applies **all** patches from scratch (useful if something went out-of-sync or you want the absolute latest).
  * `npm run sync -- --init` is essentially a full re-initialization: it resets Brave Core and Chromium to the exact versions specified in `package.json` (clean slate). This is equivalent to running the initial `init` again and will discard local changes.
  * The sync script handles common pitfalls: it will attempt to stash local modifications in Brave Core, warn you if your Node version is wrong, and so on. It also supports flags like `--sync_chromium=false` (to update Brave Core without touching Chromium version, in case you want to avoid a large rebase temporarily) and `-D/--delete_unused_deps` to remove leftover third-party directories after a Chromium bump.
* **Patch Application**: There’s also a shorter command `npm run apply_patches` which (assuming Chromium version is unchanged) just re-applies Brave’s patch files to the source. This is a faster way to, say, switch git branches in `brave-core` and apply new patches without doing a full sync.

**Build Errors and Enhancements**: Historically, building Brave could be tricky to set up, but it has improved:

* You must use a **Node.js version that matches Brave’s requirements**. For example, using an unsupported Node version led to the `init.js` script failing to read config (showing “repository ‘undefined’ does not exist” on git clone). Now Brave’s build scripts define acceptable Node versions and will stop with a clear error if mismatched.
* The build is *massive* – to optimize rebuilds on Arch, consider using **ccache** (Chromium’s GN can be configured to use ccache) and have ample RAM for linking. The AUR package sets up `ccache` by default if available, making subsequent builds much faster.
* The process is not fully idempotent by itself (you might need to manually delete `src/brave` or `src/out` in some scenarios). However, leveraging `npm run sync` can often recover the build state without manual cleaning – e.g., `npm run sync -- --force` will attempt to reset to a known good state if something gets corrupted.
* **Automation idea**: For Arch users, you can script the entire build (clone -> init -> build) and reuse output for updates. The Brave team’s provided scripts cover most needs, but an additional wrapper could check for existing `src` and skip clone if present, making it safe to re-run. This is essentially what the AUR’s PKGBUILD does: it applies patches, sets GN args (like `use_sysroot=false`, `icu_use_data_file=true`), and calls Ninja to build in one non-interactive sequence. The result is an **idempotent build process**: running `makepkg` repeatedly produces the same output or updates to a new version cleanly, thanks to those patches and flags ensuring no reliance on network after initial fetch.

In summary, Brave’s build system piggybacks on Chromium’s but provides user-friendly NodeJS commands to manage it. On Arch Linux, it’s recommended to use the AUR package (`brave` or `brave-bin`) which automates these steps and includes Arch-specific fixes. If building manually, follow Brave’s Linux guide, be prepared for a long build, and ensure the environment (Node, Python2/3, etc.) matches Brave’s documented requirements to avoid mysterious errors.

## Runtime Flags and Configuration Options

Like Chromium, Brave supports a multitude of **command-line flags** (switches) that can control browser behavior at launch. In fact, Brave inherits *hundreds* of Chromium flags – many are identical to Chrome’s and undocumented. We will focus on flags that are particularly relevant to Brave or have unique effects in Brave. These flags can be supplied when launching `brave-browser` (e.g., via terminal, script, or modifying the desktop launcher).

**Common Chromium Flags (Supported in Brave)** – These work the same in Brave as in Chrome/Chromium:

* `--user-data-dir=<DIR>` – Use a custom profile directory for user data. By default on Linux, Brave stores profiles in `~/.config/brave-browser` (and cache in `~/.cache/brave-browser`). Specifying a different `DIR` allows running a separate instance with its own profile. (Remember: one Brave instance per profile directory – launching a second Brave without changing this will reuse the existing browser process for that profile.)
* `--incognito` – Launches in a Private browsing window (incognito mode). In Brave this means no history/cookies kept, and **Shields** are still active by default. There isn’t a separate CLI flag for “Private Window with Tor” in Brave (Tor mode must be activated from the UI; attempts like `--incognito --tor` are not supported as a single flag as of now).
* `--app=<URL>` – Opens the given URL in an app-like window (without the UI toolbar). Useful for web apps/PWAs.
* `--new-window` – Forces opening a new window (even if an existing instance is running) for the given URL or profile.
* **Proxy Settings**: Brave uses Chromium’s networking stack, so all proxy flags apply:

  * `--proxy-server=<host:port>` – Use a specific proxy server for all HTTP/HTTPS traffic (supports socks5, socks4, etc. as schemas).
  * `--proxy-pac-url=<URL>` – Use a PAC script for proxy configuration.
  * `--proxy-auto-detect` – Auto-detect system proxy (WPAD).
  * `--no-proxy-server` – Disable all proxies, ignoring environment proxy vars.
* `--password-store=<basic|gnome|kwallet>` – On Linux, specifies which keyring to use for storing passwords. Brave defaults to detecting the desktop environment (gnome-keyring or KWallet), but you can force the plain text store with `basic` (not encrypted) or another system.
* `--remote-debugging-port=<port>` – (Not Brave-specific, but useful for developers) Allows attaching a debugger or automation tool by exposing the DevTools protocol on that port.

And many more (GPU flags, headless mode flags, etc.) – Brave doesn’t remove these, so references like the [Chromium flags list](https://peter.sh/experiments/chromium-command-line-switches/) apply to Brave. **Note**: as Brave’s manual states, many flags are “added and removed at the whim of developers” and are not formally documented. Stick to known stable flags unless you’re experimenting.

**Brave-Specific Flags and Behavior**:

Brave introduces a few custom runtime flags of its own, mostly to control Brave-exclusive features. Key ones include:

* **Brave Rewards flags** – Brave has a combined flag `--rewards=<options>` which accepts a comma-separated list of settings for the Rewards system. This is primarily used by developers or power-users to test Brave Rewards (the BAT earning system). The available sub-options are:

  | **Option**           | **Values/Type**       | **Description**                                                                                                                                                                                           |
  | -------------------- | --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `staging`            | `true`/`false`        | If `true`, use the Brave Rewards **staging servers** (testing environment) instead of production servers. Defaults to false (production).                                                                 |
  | `reconcile-interval` | Integer (minutes)     | Overrides the interval for the monthly auto-contribution cycle in minutes. (Default is 30 days; a small number like 5 is used in testing to simulate monthly grants quickly.)                             |
  | `short-retries`      | `true`/`false`        | If true, enable **short retry intervals** for contribution failures. Normally, retries backoff over hours/days – with this flag, retries occur more rapidly (for testing error handling).                 |
  | `current-country`    | Country code (string) | Pretend the browser is in the given country (e.g. “JP”). Used to test geo-restricted Brave Ads behavior. Only certain values have an effect (at time of writing, “JP” triggers Japan-specific ads logic). |

  **Usage example**:

  * To run Brave with Rewards pointing to staging and a fast cycle, you could launch:

    ```bash
    brave-browser --rewards=staging=true,reconcile-interval=5
    ```

    This would connect to Brave’s staging servers (for test ads) and attempt auto-contribute every 5 minutes (instead of the normal \~43200 minutes in a month). Multiple options are comma-separated as shown. If using `npm start` from source, you’d do `npm run start -- --rewards=...`.
  * If you omit an option, default is used (e.g. `--rewards=staging=true` only switches servers, other settings unchanged).

* **Disable Brave Extensions** – In earlier versions of Brave, there were flags to disable certain built-in components implemented as extensions:

  * `--disable-brave-extension`: This flag **disabled the core Brave extension** which powers Brave Shields (ad-block, tracker blocking UI). Effectively, it turned off Brave’s native ad-blocker/Shields (use case: if you prefer a third-party adblock extension, etc.). It also removed the right-click “Brave” menu and related UI. **Note:** As of late 2023, Brave removed this flag in stable builds to prevent users from accidentally disabling fundamental privacy features. It may no longer work in current versions (the internal code was refactored, so Shields can’t be fully turned off via CLI now).
  * `--disable-brave-rewards-extension`: Similarly, this flag used to disable the Brave Rewards UI/extension (hiding Brave Rewards icons, wallet, ads service). This too was **removed** in recent versions, as Brave now provides in-app settings to disable Rewards more gracefully. In current Brave (1.5x+), to disable Rewards you would toggle it off in settings rather than use a flag.

  These “disable” flags were mostly intended for diagnostic or enterprise use. Their removal is noted in Brave’s issue tracker, but if you are on an older build you might find them functional. Always check `brave://version` after launching to see which flags were applied.

* **Experimental Features (via flags)** – Brave’s new features sometimes debut behind Chromium’s experiment system (`brave://flags`). While not direct command-line switches, they can be enabled with `--enable-features` flags. For example:

  * **Brave AI (Leo)**: Brave’s AI chat assistant was behind a flag `#brave-ai-chat` in early releases. Manually, one could launch Brave with `--enable-features=BraveAIChat` to force the Leo AI sidebar on, even if it’s not enabled by default. By 2024, BraveAIChat flag was enabled by default in stable builds, but this illustrates how features can be toggled.
  * **Native Brave Wallet**: There’s a `#native-brave-wallet` flag in `brave://flags` to disable the native crypto wallet integration (for users who prefer MetaMask, etc.). The corresponding feature name is likely `BraveWallet` – so `--disable-features=BraveWallet` could turn it off. (In practice, Brave Wallet can also be turned off via settings now.)
  * **Brave VPN**: Initially Brave had an experimental flag `#brave-vpn` for its VPN feature on desktop, but it was later removed as the feature matured. There is currently no command-line switch to fully disable the Brave VPN UI; Enterprise policy or settings must be used if one doesn’t want the VPN offer visible.

  In summary, Brave supports Chrome’s `--enable-features=<Feature>` and `--disable-features=<Feature>` syntax for many Brave-specific features. These are primarily of interest to developers or testers; normal users can toggle most of these via the `brave://flags` page or the Settings UI. Always **restart the browser** after changing flags (or use the Relaunch button in `brave://flags`) for them to take effect.

* **Logging and Debugging**: Brave inherits Chromium’s verbose logging flags:

  * `--v=<level>` sets the verbosity (INFO=0, ERROR=1, etc.). Brave’s own components use these log levels too.
  * `--vmodule=<pattern>=<level>` enables debug logging for specific modules. For example, Brave’s Rewards team notes you can use `--vmodule=*rewards*=6` to get extremely detailed logs from any code with “rewards” in its filename. You can combine this with `--v=3` (info) to get general logs plus Rewards-specific trace logs. The logs will be written to the console (if launched from terminal) or to `chrome_debug.log` in the profile folder by default.
  * Additionally, Brave on Linux will honor `--enable-logging` and related flags the same as Chrome.

* **No Experiments**: If you enabled something via `brave://flags` that is causing crashes, you can launch with `--no-experiments` (a Chromium flag) to **ignore all field trials and flags**. This essentially starts Brave in a baseline state (all experiments = default). It’s useful for troubleshooting issues after messing with flags.

**Using Flags on Arch Linux**: On Arch, if you installed Brave via the AUR (`brave` or `brave-bin`), there is a convenient way to persist custom flags. The Arch package provides a wrapper that reads **`~/.config/brave-flags.conf`** for any user-defined flags and appends them at launch. You can echo flags into that file (one per line) and they will apply every time you start Brave normally (no need to edit desktop files). For example:

```bash
echo "--incognito" >> ~/.config/brave-flags.conf
echo "--rewards=staging=true" >> ~/.config/brave-flags.conf
```

Now launching Brave will always open in private mode with Rewards on staging (until you remove those lines). This is an Arch-specific enhancement – **other distros** don’t have this auto-flag file by default. On Fedora or Debian-based systems, you’d typically copy the Brave desktop launcher from `/usr/share/applications/brave-browser.desktop` to `~/.local/share/applications/` and edit the `Exec=` line to add your flags manually (or launch from terminal with a wrapper script). Arch’s approach is more convenient, aligning with how Chromium on Arch supports a `chromium-flags.conf`.

**Environment Variables**: Brave doesn’t introduce special env vars beyond Chromium’s. It will respect `http_proxy`, `https_proxy`, `no_proxy` environment variables for network if no command-line proxy flags are given (with the same caveats as Chrome regarding GUI environments). Brave also uses the `$DISPLAY`/`$WAYLAND_DISPLAY` environment for selecting X11/Wayland in Linux, just like Chrome (and supports `--ozone-platform=wayland` flag for Wayland). One Brave-specific env variable is `BRAVE_P3A_ENABLED` which can force-disable anonymous usage metric collection (P3A) if set to 0, but P3A is on by default in Brave release builds and is privacy-preserving (and not the same as Google’s metrics, which are fully removed).

## Conclusion and Further Customization

Brave’s architecture – Chromium plus Brave Core – means most low-level behaviors are controlled by Chromium’s extensive set of flags, while Brave-specific features add a handful of new flags and build-time settings. On Arch Linux, compiling Brave is feasible and made easier by Brave’s npm-based build tools and Arch’s packaging scripts, which together handle the heavy lifting of syncing  gigabytes of source and applying patches in an idempotent way.

For developers or power users, **runtime flags** provide a powerful way to tweak Brave’s behavior:

* They allow disabling or enabling components at launch (e.g. turning off Rewards entirely, testing new features like the Brave AI assistant, or running multiple isolated instances with different profiles).
* They can be combined with system integration (like the `brave-flags.conf` on Arch or custom launchers) to tailor the browser’s startup to your needs – for example, an administrator could create a desktop shortcut that launches Brave in a hardened mode with certain privacy flags always on.

Finally, it’s worth noting that Brave is under active development (with over 10,000 Git commits and frequent version bumps). Always consult the latest Brave release notes and documentation for any new flags or deprecations. The Brave Wiki and community forums are excellent resources for build tips and flag usage. With the above understanding of Brave’s build system, patch integrations, and runtime configurability, advanced users and developers on Arch can fully inspect, build, and customize Brave Browser to fit their workflows and ensure optimal performance and privacy.

**Sources:**

- Brave Browser Build README: https://github.com/brave/brave-browser/blob/master/README.md
- Brave Core Repository: https://github.com/brave/brave-core
- Brave Support: "What does Brave remove from Chromium?": https://support.brave.com/hc/en-us/articles/360017916272
- Brave-Core Wiki (Build Configuration & API keys): https://github.com/brave/brave-core/wiki/Development-Environment
- Brave Rewards Developer Guide: https://github.com/brave/brave-core/wiki/Rewards-Development-Guide
- Brave Community Forum (build issues, Node versions): https://community.brave.com/c/developer-support/22
- Brave Linux Man Page (CLI flags, environment variables): https://github.com/brave/brave-browser/wiki/Command-Line-Options
- Chromium Command-Line Switches (applicable to Brave): https://peter.sh/experiments/chromium-command-line-switches/
- Brave Desktop Environment Integration (Arch Linux-specific flag handling): https://aur.archlinux.org/packages/brave-bin
