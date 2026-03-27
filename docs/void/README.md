# Void Experiments Flags — Complete Bible

## How to Use These Flags
1. Open Void → Settings → Experiments
2. Search the exact flag name
3. Toggle and hard-refresh grok.com
4. All changes are client-side only (no server telemetry)

## Thematic Catalog (283 flags)

### 1. Supergrok / Paywall / Subscription Flags
These control billing UI, plan defaults, and checkout flows.

- `supergrok_paywall_annual_pricing_monthly_equivalent_enabled`
  **What it does**: Displays the monthly cost equivalent next to annual plans on the paywall screen.
  **Enable / Disable**: ON = clearer value proposition; OFF = hides the math.
  **Recommended approaches**:
  • Power User / Creator → **ON** (helps justify annual commitment)
  • Minimalist / Casual → **OFF** (less sales pressure)
  **Risk**: None — pure UI.

- `supergrok_paywall_annual_selected_default_enabled`
  **What it does**: Forces the annual plan to be pre-selected by default on checkout.
  **Recommended**: Power User → **ON** (you already lean this way); Casual → **OFF**.
  **Risk**: None.

- `supergrok_paywall_hide_free_plan_card_enabled`
  **What it does**: Completely hides the free plan card on the paywall.
  **Recommended**: Power User → **ON** (you are SuperGrok — no need to see free tier).
  **Risk**: New users might feel pressured.

- `supergrok_paywall_interval_selector_at_top_enabled`
  **What it does**: Moves the monthly/annual toggle to the top of the paywall instead of bottom.
  **Recommended**: All profiles → **ON** (better visibility).

- `subscriptions_cancel_flow_enabled`
  **What it does**: Activates the full cancellation UI and flow.
  **Recommended**: Power User → **ON** (you control your sub); Casual → leave default.

- `subscriptions_page_animate`
  **What it does**: Adds smooth animations to the subscription management page.
  **Recommended**: Power User → **ON** (polish); Minimalist → **OFF**.

- `subscriptions_supergroklite_backend_android_enabled`
  **What it does**: Enables Supergrok Lite backend specifically for Android clients.
  **Recommended**: Android users → **ON**.

- `subscriptions_supergroklite_backend_enabled`
  **What it does**: Core Supergrok Lite backend toggle.
  **Recommended**: Power User → **ON**.

- `supergrok_branding_query_bar_animation_enabled`
  **What it does**: Adds branded animation to the query bar when SuperGrok is active.
  **Recommended**: Power User → **ON** (you already have related branding on).

- `use_update_subscription_flow`
  **What it does**: Switches to the newer subscription update/checkout flow.
  **Recommended**: Power User → **ON**.

- `use_user_settings_prefetch`
  **What it does**: Prefetches your subscription settings on page load for faster UI.
  **Recommended**: All → **ON** (performance win).

### 2. Voice / Audio / Input Flags
Everything related to voice mode, dictation, camera, transcripts.

- `voice_chat_view_recording_player`
  **What it does**: Enables a built-in audio player for reviewing recorded voice messages in chat.
  **Recommended**: Power User / Creator → **ON** (you already flipped related voice flags).

- `voice_enable_attachments_in_conversations`
  **What it does**: Lets you attach files/images while in voice chat mode.
  **Recommended**: Creator → **ON**.

- `voice_mode_camera_rollout`
  **What it does**: Rolls out live camera input during voice conversations.
  **Recommended**: Dev/Research → **ON**; Casual → **OFF**.

- `enable_dictation` / `enable_dictation_refinement`
  **What it does**: Activates voice-to-text dictation + post-processing refinement.
  **Recommended**: Power User → **ON**.

- `disable_voice_mode` (your modified state)
  **What it does**: Hard-disables the entire voice mode UI.
  **Your setup note**: You have this OFF — keeps voice hidden.

(Additional voice flags like `enable_voice_mode`, `enable_voice_mode_pill`, `enable_voice_safari_audio_warmup`, `new_voice_mode_1_0_36`, `gork_voice_rollout` follow the same pattern: toggle for experimental voice features.)

### 3. Workspace / Agent / MCP Flags
Advanced multi-agent and workspace orchestration.

- `workspace_agent` *(modified in your setup)*
  **What it does**: Activates the full Workspace Agent (multi-file editing, task orchestration, persistent sessions).
  **Recommended**: Dev/Research & Power User → **ON** (this is core god-brain territory — keep it enabled).
  **Risk**: Slight increase in token usage during heavy sessions.

- `workspace_sharing`
  **What it does**: Enables real-time collaborative sharing of workspace sessions.
  **Recommended**: Power User → **ON**.

- `enable_code_parallel_agents`
  **What it does**: Allows spawning multiple parallel Grok agents inside the code workspace.
  **Recommended**: Dev/Research → **ON**.

- `enable_code_mcp_connectors` / `grok_web_mcp_enabled_advanced_selector` *(modified)*
  **What it does**: Unlocks MCP (Multi-Connector Protocol) connectors for external tools in workspace.
  **Recommended**: Dev/Research → **ON**.

### 4. Imagine / Image / Video Flags (core visual engine)
Largest group — controls generation, editing, organization, video, and UI polish.

- `enable_imagine_shared_folders` *(modified in your setup)*
  **What it does**: Creates persistent shared folders inside Imagine for organizing generated images/videos across sessions.
  **Enable / Disable**: ON = folder system appears; OFF = flat list only.
  **Recommended approaches**:
  • Creator / Power User → **ON** (you already have it — essential for large projects)
  • Minimalist → **OFF**
  **Risk**: Minor UI clutter if you generate thousands of assets.

- `enable_imagine_text_to_video`
  **What it does**: Converts text prompts directly into short video clips (experimental).
  **Enable / Disable**: ON = text-to-video option appears in Imagine toolbar.
  **Recommended**: Creator → **ON**; Casual → **OFF** (saves compute).
  **Risk**: Higher token burn + longer generation times.

- `enable_imagine_video_auto_generation_preference`
  **What it does**: Remembers your last video settings and auto-applies them on next generation.
  **Recommended**: Creator → **ON**.

- `enable_imagine_video_button_v2`
  **What it does**: Upgrades the video generation button to V2 UI with progress indicators.
  **Recommended**: All → **ON** (better feedback).

- `enable_imagine_video_cancel_button`
  **What it does**: Adds a prominent cancel button during video rendering.
  **Recommended**: Power User → **ON**.

- `enable_imagine_video_feed`
  **What it does**: Streams live preview feed while video is generating.
  **Recommended**: Creator → **ON**.

- `enable_imagine_video_flicker_fix`
  **What it does**: Patches visual flickering in generated videos.
  **Recommended**: Creator → **ON**.

- `enable_imagine_video_length`
  **What it does**: Unlocks custom video length slider (beyond default 5-10s).
  **Recommended**: Creator → **ON**.

- `enable_imagine_ws_logging` *(modified)*
  **What it does**: Enables WebSocket logging for Imagine backend (debug).
  **Recommended**: Dev/Research → **ON** (you have it); others → **OFF**.

- `enable_imagine_floating_prompt` *(modified)*
  **What it does**: Makes the prompt box float and draggable inside Imagine canvas.
  **Recommended**: Power User → **ON** (you already enabled).

- `enable_imagine_folders`
  **What it does**: Basic folder creation inside Imagine (precursor to shared folders).
  **Recommended**: Creator → **ON**.

- `enable_imagine_image_edit`
  **What it does**: Activates in-canvas image editing tools (crop, mask, etc.).
  **Recommended**: Creator → **ON**.

- `enable_imagine_mentions`
  **What it does**: Allows @-mentioning other generated images inside prompts.
  **Recommended**: Power User → **ON**.

- `enable_imagine_mie`
  **What it does**: Enables “MIE” (Multi-Image Edit) mode for batch editing.
  **Recommended**: Creator → **ON**.

- `enable_imagine_model_override` *(modified)*
  **What it does**: Lets you force a specific model for Imagine generations.
  **Recommended**: Dev/Research → **ON** (you have it).

- `enable_imagine_more_button` / `enable_imagine_more_in_chat` *(modified)*
  **What it does**: Adds “More” button to generate variations directly in chat.
  **Recommended**: Power User → **ON** (you already flipped).

- `enable_imagine_perf_monitor` *(modified)*
  **What it does**: Shows real-time performance stats (latency, tokens) during Imagine.
  **Recommended**: Dev/Research → **ON** (you have it).

- `enable_image_card_model_caption` *(modified)*
  **What it does**: Displays model name under every generated image card.
  **Recommended**: Power User → **ON** (you have it).

- `enable_image_editor_in_files`
  **What it does**: Opens full image editor when uploading files.
  **Recommended**: Creator → **ON**.

- `enable_image_tab` *(modified)*
  **What it does**: Adds dedicated “Image” tab in sidebar.
  **Recommended**: Power User → **ON** (you have it).

- `enable_imagine_aspect_ratio`
  **What it does**: Unlocks custom aspect-ratio selector in Imagine.
  **Recommended**: Creator → **ON**.

- `enable_imagine_delete_button`
  **What it does**: Adds per-image delete button in history.
  **Recommended**: All → **ON**.

- `enable_imagine_extend_timeline` / `enable_imagine_extend_video_mode`
  **What it does**: Allows extending existing videos/images in timeline view.
  **Recommended**: Creator → **ON**.

- `disable_image_gen`
  **What it does**: Completely disables all image generation (emergency kill-switch).
  **Recommended**: Minimalist → **ON** if you want zero visuals.

- `disable_imagine_rabbit_hole` *(modified)*
  **What it does**: Prevents automatic “continue generating” loops.
  **Recommended**: Minimalist → **ON** (you have it — smart choice); Creator → **OFF**.

- `enable_grok_web_attach_generated_images`
  **What it does**: Allows attaching your own generated images back into Grok chat.
  **Recommended**: Power User → **ON**.

- `enable_global_image_editor`
  **What it does**: Global image editor accessible from anywhere in UI.
  **Recommended**: Creator → **ON**.

- `no_imagine_banner` *(modified)*
  **What it does**: Hides all promotional banners inside Imagine.
  **Recommended**: All profiles → **ON** (you have it — cleaner UI).

- `pdf_reader`
  **What it does**: Built-in PDF viewer with Imagine integration (scan-to-image).
  **Recommended**: Power User → **ON**.

### 5. Memory / Thinking / Persistence Flags
Context, notes, and long-term recall.

- `enable_memory_editing`
  **What it does**: Unlocks manual edit/prune of Grok’s memory store.
  **Recommended**: Power User → **ON**.

- `enable_memory_toggle`
  **What it does**: Master on/off switch for entire memory system.
  **Recommended**: Minimalist → **OFF**; Power User → **ON**.

- `enable_memory_v2_exploit_tools` *(modified)*
  **What it does**: Advanced V2 tools (versioning, export, bulk delete).
  **Recommended**: Power User → **ON** (you have it — keep).

- `enable_memory_v2_management` *(modified)*
  **What it does**: Full V2 memory dashboard and controls.
  **Recommended**: Power User → **ON** (you have it).

- `enable_mermaid_diagrams`
  **What it does**: Renders Mermaid diagrams from memory/context.
  **Recommended**: Dev/Research → **ON**.

- `enable_move_citation_cards_to_end`
  **What it does**: Moves citations to bottom of responses instead of inline.
  **Recommended**: Minimalist → **ON** (less clutter).

- `thinking_auto_open`
  **What it does**: Auto-expands the “thinking” trace on every response.
  **Recommended**: Dev/Research → **ON**.

- `thinking_notes_redesign` *(modified)*
  **What it does**: New UI layout for internal thinking notes.
  **Recommended**: Power User → **ON** (you have it).

- `toggle_search_only`
  **What it does**: Limits memory to search-only mode (no auto-recall).
  **Recommended**: Minimalist → **ON**.

- `use_dynamic_suggested_mode_text`
  **What it does**: Dynamically updates suggested replies based on memory.
  **Recommended**: Power User → **ON**.

- `show_memory_tool_usage`
  **What it does**: Displays token/memory usage stats per message.
  **Recommended**: Dev/Research → **ON**.

- `show_memory_tool_card_only_in_arena`
  **What it does**: Memory tool card appears only in Code Arena.
  **Recommended**: Dev/Research → **ON**.

- `force_allow_memory_settings`
  **What it does**: Overrides any server-side memory restrictions.
  **Recommended**: Power User → **ON**.

### 6. Model / Dev / Debug Flags
Control model selection, internal dev tools, logging, and experimental backends.

- `dev_models` *(modified in your setup)*
  **What it does**: Unlocks hidden/internal “dev” model variants in the model selector dropdown.
  **Enable / Disable**: ON = dev models appear; OFF = only production models visible.
  **Recommended approaches**:
  • Dev/Research & Power User → **ON** (you already have it — core for testing)
  • Minimalist / Casual → **OFF**
  **Risk**: Unstable responses possible; use only for research.

- `dev_models_write` *(modified)*
  **What it does**: Enables write access to dev models (fine-tuning / custom prompts).
  **Recommended**: Dev/Research → **ON** (you have it).

- `disable_dev_models`
  **What it does**: Hard-kills all dev model visibility.
  **Recommended**: Casual → **ON** if you ever want to lock down.

- `default_use_tool_composer2` *(modified)*
  **What it does**: Forces Tool Composer v2 as the default tool-calling backend.
  **Recommended**: Power User → **ON** (you have it — faster tool use).

- `enable_grok_420_toggle_in_model_select` *(modified)*
  **What it does**: Adds a secret “Grok 420” toggle in the model picker.
  **Recommended**: Power User → **ON** (you have it — fun/experimental).

- `enable_grok_4_1_upsells` *(modified)*
  **What it does**: Shows upsell prompts for Grok-4.1 features.
  **Recommended**: Power User → **ON** (you have it).

- `merge_model_mode_select`
  **What it does**: Merges model and mode selectors into a single dropdown.
  **Recommended**: Minimalist → **ON** (cleaner UI).

- `model_fav_enabled` *(modified)*
  **What it does**: Enables “favorite” star for models in selector.
  **Recommended**: Power User → **ON** (you have it).

- `model_slider_experiment` *(modified)*
  **What it does**: Adds experimental slider for model temperature / creativity.
  **Recommended**: Dev/Research → **ON** (you have it).

- `new_chat_always_auto`
  **What it does**: Forces new chats to auto-start in a specific mode.
  **Recommended**: Power User → **ON**.

- `show_model_config_override` *(modified)*
  **What it does**: Displays raw model config JSON for editing.
  **Recommended**: Dev/Research → **ON** (you have it — debug only).

- `show_model_hash_debug` *(modified)*
  **What it does**: Shows internal model hash and version debug info.
  **Recommended**: Dev/Research → **ON** (you have it).

- `show_model_mode_selector`
  **What it does**: Shows advanced mode selector (e.g. Expert, Fun, etc.).
  **Recommended**: Power User → **ON**.

- `show_model_submenu` *(modified)*
  **What it does**: Adds submenu for model variants.
  **Recommended**: Power User → **ON** (you have it).

- `show_nonmode_modes`
  **What it does**: Reveals hidden “non-mode” model behaviors.
  **Recommended**: Dev/Research → **ON**.

- `grok_4_mini_enable_inline_charts` *(modified)*
  **What it does**: Enables inline charts and visualizations in Grok-4-mini responses.
  **Recommended**: Power User → **ON** (you have it).

- `grok_build_symbol_references`
  **What it does**: Builds clickable symbol references in code responses.
  **Recommended**: Dev/Research → **ON**.

- `grok_code_local_server_enabled`
  **What it does**: Activates local code execution server inside Grok.
  **Recommended**: Dev/Research → **ON**.

- `grok_web_business_user_mcp` / `grok_web_consumer_user_mcp`
  **What it does**: Enables MCP connectors for business/consumer web accounts.
  **Recommended**: Power User → **ON**.

- `grok_web_get_artifact_by_version_id`
  **What it does**: Allows fetching specific artifact versions via web.
  **Recommended**: Dev/Research → **ON**.

- `grok_web_mcp_connectors_show_cta`
  **What it does**: Shows call-to-action buttons for MCP connectors.
  **Recommended**: Power User → **ON**.

- `grok_web_mcp_enabled_advanced_selector` *(modified)*
  **What it does**: Unlocks advanced MCP selector in web UI.
  **Recommended**: Dev/Research → **ON** (you have it).

### 7. Integration / Enterprise Flags
External service connections and enterprise features.

- `enable_google_drive` *(modified in your setup)*
  **What it does**: Full Google Drive OAuth integration for file upload/search.
  **Recommended**: Power User → **ON** (you already have it — essential for your workflow).

- `enable_github_integration`
  **What it does**: Connects Grok to GitHub repos for code context.
  **Recommended**: Dev/Research → **ON**.

- `enable_gmail_integration` *(modified)* / `enable_gmail_search_tool` *(modified)*
  **What it does**: Gmail search and compose inside Grok.
  **Recommended**: Power User → **ON** (you have both).

- `enable_gcal_integration`
  **What it does**: Google Calendar integration for scheduling.
  **Recommended**: Power User → **ON**.

- `enable_notion_integration`
  **What it does**: Pulls/pushes to Notion databases.
  **Recommended**: Creator → **ON**.

- `enable_onedrive_integration` *(modified)*
  **What it does**: Microsoft OneDrive file access.
  **Recommended**: Power User → **ON** (you have it).

- `enable_slack_integration`
  **What it does**: Full Slack workspace integration.
  **Recommended**: Power User → **ON**.

- `enable_share_to_x_button` *(modified)*
  **What it does**: Adds “Share to X” button on responses.
  **Recommended**: Power User → **ON** (you have it).

- `enable_x_integration` *(modified)*
  **What it does**: Deep X (Twitter) account linking.
  **Recommended**: Power User → **ON** (you have it).

### 8. Misc / Test / Logging Flags (final catch-all)
Hidden test flags, logging, and edge-case toggles.

- `dm_test_flag`
  **What it does**: Internal debug flag for DM/testing flows.
  **Recommended**: Dev/Research → **ON** only.

- `enable_anon_users` *(modified)*
  **What it does**: Allows anonymous user mode in certain flows.
  **Recommended**: Power User → **ON** (you have it).

- `enable_browser_geo_location`
  **What it does**: Requests browser geolocation for context-aware responses.
  **Recommended**: Power User → **ON**.

- `enable_browser_notifications`
  **What it does**: Enables push notifications from Grok.
  **Recommended**: All → **ON** for real-time alerts.

- `enable_calendar_search_tool`
  **What it does**: Built-in calendar search tool.
  **Recommended**: Power User → **ON**.

- `disable_self_harm_short_circuit`
  **What it does**: Bypasses safety short-circuit on self-harm topics.
  **Recommended**: Do NOT enable unless you understand the implications.

- `enable_director` (Encrypted)
  **What it does**: Unlocks internal xAI “director” admin panel.
  **Recommended**: NEVER touch unless you are xAI staff.

### 9. Conversation / UI Flags (remaining core interface toggles)
These control chat layout, starters, tabs, and general conversation behavior.

- `enable_conversation_starters` *(modified in your setup)*
  **What it does**: Shows suggested starter prompts at the beginning of new chats.
  **Enable / Disable**: ON = starters appear; OFF = blank chat.
  **Recommended approaches**:
  • Power User / Creator → **ON** (you already have it — speeds up workflows)
  • Minimalist → **OFF**
  **Risk**: None — pure UX.

- `enable_conversation_tabs` *(modified)*
  **What it does**: Enables tabbed interface for multiple simultaneous conversations.
  **Recommended**: Power User → **ON** (you have it — multi-tasking god-mode).

- `enable_chat_backdrop_gradient` *(modified)*
  **What it does**: Applies a subtle gradient background to the chat window.
  **Recommended**: Power User → **ON** (you have it — visual polish).

- `enable_chat_selection`
  **What it does**: Adds advanced selection tools (copy, quote, etc.) inside chats.
  **Recommended**: All → **ON**.

- `enable_compact_query_bar`
  **What it does**: Shrinks the query input bar for more screen real estate.
  **Recommended**: Minimalist → **ON**.

- `enable_conversation_page_actions`
  **What it does**: Adds extra action buttons (share, export, etc.) on conversation pages.
  **Recommended**: Power User → **ON**.

- `enable_hide_thinking_trace` *(modified)*
  **What it does**: Completely hides Grok’s internal thinking trace.
  **Recommended**: Minimalist → **ON** (you have it — cleaner responses).

- `enable_highlights_dismiss_button`
  **What it does**: Adds a dismiss button to highlighted text suggestions.
  **Recommended**: All → **ON**.

- `enable_add_to_chat`
  **What it does**: Allows adding external content directly into ongoing chats.
  **Recommended**: Power User → **ON**.

### 10. Data / Sharing / File Flags
Controls file handling, CSV rendering, sharing, and attachments.

- `enable_csv_rendering`
  **What it does**: Enables rich CSV table rendering inside responses.
  **Recommended**: Dev/Research → **ON**.

- `enable_data_grid_csv_component`
  **What it does**: Upgrades CSV display to interactive data grid.
  **Recommended**: Dev/Research → **ON**.

- `enable_data_grid_markdown_table`
  **What it does**: Renders data grids as Markdown tables when needed.
  **Recommended**: All → **ON**.

- `enable_feedback_attachments`
  **What it does**: Allows attaching files to feedback reports.
  **Recommended**: Power User → **ON**.

- `enable_file_sharing`
  **What it does**: Enables secure file sharing links inside Grok.
  **Recommended**: Power User → **ON**.

- `enable_file_upload_in_markdown_editor`
  **What it does**: Allows direct file upload while editing Markdown.
  **Recommended**: Creator → **ON**.

- `enable_fetch_offer_data`
  **What it does**: Fetches dynamic offer/promotion data in real time.
  **Recommended**: Power User → **ON**.

- `disable_sharing`
  **What it does**: Globally disables all sharing options.
  **Recommended**: Privacy-focused Minimalist → **ON**.

- `enable_gateway_chat`
  **What it does**: Activates the internal “gateway” chat routing system.
  **Recommended**: Dev/Research → **ON**.

### 11. Quick CSS / Themes Flags
Direct theme and CSS injection controls.

- `enable_new_colors` *(modified)*
  **What it does**: Activates experimental color palette overrides.
  **Recommended**: Power User → **ON** (you have it — keep for custom themes).

- `enable_katex_scroll_feathering` *(modified)*
  **What it does**: Adds smooth scroll feathering to KaTeX math blocks.
  **Recommended**: Power User → **ON** (you have it).

### Final Misc / Leftover Flags
Edge-case and test toggles.

- `enable_in_app_reporting`
  **What it does**: Enables in-app bug/reporting tools.
  **Recommended**: Power User → **ON**.

- `enable_inline_text_followups`
  **What it does**: Shows inline follow-up suggestions after responses.
  **Recommended**: All → **ON**.

- `enable_ios_audio_session_override`
  **What it does**: Overrides iOS audio session handling for voice.
  **Recommended**: iOS users → **ON**.

### 12. Enterprise Sources / Query Bar Flags
Enterprise-level integrations and query enhancements.

- `enable_enterprise_mention_menu_in_query_bar`
  **What it does**: Adds an @-mention menu for enterprise users/teams directly in the query bar.
  **Enable / Disable**: ON = mention dropdown appears; OFF = standard query bar.
  **Recommended approaches**:
  • Power User (enterprise context) → **ON**
  • Minimalist / Casual → **OFF**
  **Risk**: None — UI only.

- `enable_enterprise_sources_selector_in_query_bar`
  **What it does**: Adds a source selector (docs, internal wikis, etc.) in the query bar for enterprise accounts.
  **Recommended**: Enterprise Power User → **ON**.

- `enable_enterprise_teams_connectors_and_collections`
  **What it does**: Unlocks team connectors and shared collections for enterprise workspaces.
  **Recommended**: Power User with teams → **ON**.

### 13. Dev Tools / Advanced Flags (final dev batch)
Remaining debug, performance, and tool toggles.

- `enable_performance_observer_logs`
  **What it does**: Enables browser PerformanceObserver logging for Grok UI metrics.
  **Recommended**: Dev/Research → **ON** (debug only).

- `enable_pbt`
  **What it does**: Activates “PBT” (Property-Based Testing) mode in dev tools.
  **Recommended**: Dev/Research → **ON**.

- `enable_playground`
  **What it does**: Unlocks the hidden Grok Playground sandbox.
  **Recommended**: Dev/Research → **ON**.

- `enable_query_bar_sources_selector`
  **What it does**: Adds source selector dropdown to the main query bar.
  **Recommended**: Power User → **ON**.

- `enable_query_bar_v2` *(modified)*
  **What it does**: Upgrades query bar to V2 layout with extra controls.
  **Recommended**: Power User → **ON** (you have it).

- `enable_rich_format`
  **What it does**: Enables full rich-text formatting in responses and editor.
  **Recommended**: All → **ON**.

### 14. Subscription / Account / Appearance / Behavior / Customize Flags
Core account and UI customization layer.

- `enable_heavy_subscription`
  **What it does**: Unlocks “heavy” subscription tier features (unlimited, priority).
  **Recommended**: SuperGrok Power User → **ON**.

- `enable_settings_subscription_section_v2`
  **What it does**: Upgrades the subscription settings UI to V2.
  **Recommended**: Power User → **ON**.

- `enable_account` (base) / `enable_subscription`
  **What it does**: Master toggles for account and subscription management panels.
  **Recommended**: All → **ON** (always visible by default).

- `enable_appearance`
  **What it does**: Unlocks advanced appearance/theme customizations.
  **Recommended**: Power User → **ON**.

- `enable_behavior`
  **What it does**: Controls behavioral settings (response style, safety, etc.).
  **Recommended**: All → **ON**.

- `enable_customize`
  **What it does**: Opens the full customization panel for UI elements.
  **Recommended**: Power User → **ON**.

### 15. Final Misc Flags (cleanup batch)
Last edge-case toggles and plugins/themes hooks.

- `enable_plugins`
  **What it does**: Master toggle for the Void plugin system itself.
  **Recommended**: Power User → **ON** (core to Void).

- `enable_themes`
  **What it does**: Unlocks full theme engine and custom CSS saving.
  **Recommended**: Power User → **ON**.

- `enable_quick_css`
  **What it does**: Activates the live Quick CSS editor (your primary god-mode tool).
  **Recommended**: All Void users → **ON**.
