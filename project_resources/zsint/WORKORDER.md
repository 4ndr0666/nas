# WORKORDER: Open-Source Intelligence Monitoring Pipeline

**Classification:** UNCLASSIFIED // FOR INTERNAL USE
**Issue:** 2026-10-04
**Owner:** Agentic R&D Team
**Review cadence:** Weekly (automated), Monthly (human)

---

## Task 01 — PURSUE Release Monitor

| Field | Value |
|---|---|
| **Objective** | Detect new PURSUE declassification releases within 24h of publication |
| **Sources** | Zenodo record `20136108` (publisher: `war.gov`); `war.gov/medialink/ufo/` |
| **Pipeline** | 1. Poll `GET /api/records/20136108` every 6h → check `updated` timestamp and `version` field. 2. On change, pull `GET /api/records/20136108?all_versions=true` → diff file manifests. 3. Poll `GET /api/records?q=war.gov+UAP&sort=mostrecent` for sibling records. 4. On detection, trigger alert + auto-download all new files. |
| **Outputs** | (a) Alert (webhook/email) within 24h of new release. (b) New-file manifest with redaction rate per file (count redaction blocks / total blocks via PDF text extraction). (c) Changelog: "Release N added X files, Y redacted (Z%)." |
| **Cadence** | Poll: 6h. Report: on-event. |
| **Success criteria** | Zero missed releases. Redaction rate computed within 1h of detection. |
| **Dependencies** | Zenodo API (free), PDF text extraction (PyMuPDF or pdfplumber) |
| **Priority** | **P0** |

---

## Task 02 — UAP Document Catalog Cross-Reference

| Field | Value |
|---|---|
| **Objective** | Maintain a machine-readable index of all declassified UAP documents with structured metadata for redaction-pattern analysis |
| **Sources** | Zenodo record `21605258` (UFO Declassified CSV, CC BY 4.0); individual PURSUE PDFs (Task 01 output) |
| **Pipeline** | 1. Download CSV from `GET /api/records/21605258/files` → parse into SQLite/Postgres. 2. For each PURSUE PDF (from Task 01), extract structured fields: `originator_unit`, `mission_wing`, `operation`, `domain`, `cc`, `service`, `declassified_by`, `declassified_date`, `original_classification`, `uap_description`, `kinetic_velocity`, `kinetic_altitude`, `uap_event_type`, `intelligent_control`, `propulsion`. 3. Tag redacted fields as `DATA_MASKED` / `REDACTED`. 4. Compute per-document redaction ratio. 5. Join against CSV catalog. |
| **Outputs** | (a) SQLite DB: `documents` table (id, source, date, agency, release_number, redaction_ratio, classification, unit, operation). (b) `uap_observations` table (doc_id, description, velocity, altitude, trajectory, eei_count, intelligent_control). (c) Monthly summary: "N new docs, M redacted, X% of UAP fields unredacted, top 5 redacted field types." |
| **Cadence** | On-event (triggered by Task 01). Full re-index: monthly. |
| **Success criteria** | 100% of PURSUE PDFs parsed within 2h of download. Zero field extraction errors on structured (non-narrative) fields. |
| **Dependencies** | Task 01 (PDF ingestion), PyMuPDF, SQLite |
| **Priority** | **P0** |

---

## Task 03 — Chinese Stealth / CEM Research Tracker

| Field | Value |
|---|---|
| **Objective** | Detect open-literature publications indicating progress on Chinese stealth shaping, RAM, or multispectral suppression |
| **Sources** | Zenodo: `GET /api/records?q=radar+cross+section+reduction+OR+stealth+OR+radar+absorbing+material&sort=mostrecent`. arXiv: `cs.CE`, `physics.optics`, `eess.SY`. Chinese journals (AIP J. Appl. Phys., IEEE Antennas Propag. Mag.) |
| **Pipeline** | 1. Daily query Zenodo + arXiv API with keyword set: `RCS reduction`, `flying wing`, `metamaterial absorber`, `IR emissivity`, `multispectral stealth`, `Olive`, `Shiyan`, `H-20`, `WZ-X`, `NAU`, `NUDT`, `CAS`. 2. Filter: exclude non-Chinese-affiliated unless co-authored. 3. Score each hit: (a) is it a *measurement* (not simulation)? (b) does it demonstrate on a *flying-wing geometry*? (c) is it multispectral (RCS + IR)? 4. Flag score ≥ 2 as "program-relevant." 5. Auto-generate 3-sentence summary. |
| **Outputs** | (a) Weekly digest: "N new papers, M program-relevant." (b) Alert on any paper demonstrating: >20 dB RCS reduction across 1–18 GHz on a flying-wing geometry, OR IR emissivity <0.2 on a stealth-shaped platform, OR a measured (not simulated) RCS of a flying-wing body <0.01 m². (c) Timeline: "First public measurement of X capability: [date], [institution]." |
| **Cadence** | Query: daily. Digest: weekly (Monday). Alert: on-event. |
| **Success criteria** | No missed papers from top 5 Chinese aerospace institutions (NAU, NUDT, CAS, XJTU, BUAA). Alert within 48h of arXiv/Zenodo publication. |
| **Dependencies** | Zenodo API, arXiv API, NLP classifier (fine-tuned on "measurement vs. simulation" — ~200 labeled examples from Task 07 corpus) |
| **Priority** | **P1** |

---

## Task 04 — Satellite Maneuver Detection (Training Data Pipeline)

| Field | Value |
|---|---|
| **Objective** | Build and maintain a labeled dataset of satellite maneuver events for training a detection model |
| **Sources** | Zenodo: SpaceNet (record `11609935`), ESA OPS-SAT anomaly dataset (record `12588359`). Space-Track TLEs (free account). LeoLabs public platform (23,000+ objects). |
| **Pipeline** | 1. Download SpaceNet + OPS-SAT datasets → normalize to common schema (object_id, timestamp, position, velocity, label). 2. Pull 24h of TLEs from Space-Track for all objects in 300–800 km SSO. 3. Propagate with Orekit (SGP4) → compute residual (actual − propagated). 4. Label: residual > 1 km = "maneuver candidate." 5. Cross-reference with LeoLabs public maneuver alerts (if available without login). 6. Store in time-series DB (TimescaleDB or InfluxDB). |
| **Outputs** | (a) Labeled dataset: (object_id, epoch, propagated_state, observed_state, residual, label). Target: 10,000+ labeled events within 30 days. (b) Baseline model: logistic regression on residual magnitude + direction → F1 > 0.85 on 20% holdout. (c) Weekly: "N new maneuver candidates detected, M confirmed (cross-ref LeoLabs), K false positives." |
| **Cadence** | TLE pull: hourly. Model retrain: weekly. Report: weekly. |
| **Success criteria** | Detection latency < 24h from maneuver to flag. False positive rate < 15%. Dataset growing ≥ 500 new labeled events/week. |
| **Dependencies** | Space-Track account, Orekit (Java/Python), TimescaleDB, LeoLabs public API |
| **Priority** | **P1** |

---

## Task 05 — Declassified Document Version Diffing

| Field | Value |
|---|---|
| **Objective** | Automate the "what changed between releases" analysis for PURSUE and any future declassification batch |
| **Sources** | Task 01 output (file manifests per version). war.gov release pages. |
| **Pipeline** | 1. Maintain a `releases` table: (release_number, date, total_files, redacted_files, redaction_rate). 2. On new release (Task 01 trigger): download all files → hash (SHA-256). 3. Diff against prior release hash set → new files, removed files, modified files. 4. For new files: run Task 02 extraction. 5. Compute: redaction rate delta, new classification levels introduced, new units/operations appearing, new UAP event types. 6. Generate changelog. |
| **Outputs** | (a) Per-release changelog: "Release 07: +N files, redaction rate X% (was Y%), new units: [...], new operations: [...], new UAP types: [...]." (b) Cumulative trend chart: redaction rate vs. release number. (c) "Evidence vs. Program" ratio: (unredacted UAP fields) / (redacted operational fields) per release. |
| **Cadence** | On-event (triggered by Task 01). |
| **Success criteria** | Changelog generated within 1h of new release detection. Zero missed files in diff. |
| **Dependencies** | Task 01, Task 02 |
| **Priority** | **P0** |

---

## Task 06 — AAWSAP Exotic-Physics Preprint Tracker

| Field | Value |
|---|---|
| **Objective** | Detect open-literature publications that precede or mirror classified AAWSAP task orders |
| **Sources** | Zenodo: `GET /api/records?q=Alcubierre+OR+warp+drive+OR+Natario+OR+wormhole+OR+antigravity+OR+permittivity+collapse&sort=mostrecent`. arXiv: `gr-qc`, `hep-th`, `physics.plasm-ph`. |
| **Pipeline** | 1. Daily query with keyword set: `Alcubierre`, `Natário`, `warp drive`, `wormhole`, `antigravity`, `permittivity collapse`, `tension-optimized`, `Newtonian entropy`, `exotic matter`, `negative energy density`. 2. Classify: (a) rigorous (peer-reviewed or arXiv with >10 citations in 90 days), (b) speculative (preprint, no citations), (c) crank (no math, no references). 3. Flag "rigorous" papers. 4. Cross-reference: if a "rigorous" paper's topic appears in a subsequent PURSUE release (Task 02 DB), mark as "confirmed program-relevant." 5. Track burst detection: >3 papers in same sub-niche within 30 days = "possible new task order signal." |
| **Outputs** | (a) Weekly: "N new papers, M rigorous, K confirmed program-relevant." (b) Alert on burst: "3+ papers on [sub-niche] in 30 days — possible new AAWSAP task order." (c) Annual: "AAWSAP open-literature footprint: X papers, Y sub-niches, Z institutions." |
| **Cadence** | Query: daily. Digest: weekly. Burst alert: on-event. |
| **Success criteria** | No missed arXiv preprints in `gr-qc`/`hep-th` matching keyword set. Burst detection within 7 days of 3rd paper. |
| **Dependencies** | arXiv API, Zenodo API, citation tracking (Semantic Scholar API) |
| **Priority** | **P2** |

---

## Task 07 — RCS Reference Library (Platform Fingerprinting)

| Field | Value |
|---|---|
| **Objective** | Build a measured RCS signature library for known platforms to enable open-source fingerprinting |
| **Sources** | Zenodo: PEACC anechoic chamber dataset (5.7 GB), UAV RCS dataset (IEEE DataPort cross-ref), insect RCS morphometric dataset (65 species). Published measurements: Olive-B paper (24.8 km / 61.9 km at L-band), B-2 published estimates. |
| **Pipeline** | 1. Download all three datasets → normalize to (platform, frequency, polarization, aspect_angle, RCS_dBsm). 2. Build lookup table: platform → RCS envelope (min, max, mean, std) per frequency band (L, S, C, X, Ku, K). 3. Train classifier: input = (RCS_magnitude, aspect_modulation_pattern, frequency_dependence) → output = class {conventional, stealth_shaped, unknown}. 4. Validate: classifier must separate "conventional" from "stealth" with F1 > 0.90 on held-out UAV data. 5. Cross-check: apply classifier to Olive-B published numbers → should classify as "stealth_shaped." |
| **Outputs** | (a) SQLite/Postgres: `rcs_library` table (platform, freq, pol, aspect, rcs_dBsm, source, measurement_type). (b) Trained classifier (saved model + metadata). (c) "Gap report": which frequency bands / aspect ranges have no measured data for stealth platforms. (d) Monthly: "N new measurements ingested, classifier F1: X." |
| **Cadence** | Ingest: on-event (new dataset published). Retrain: monthly. |
| **Success criteria** | Library covers ≥ 50 platforms across L–K band. Classifier F1 > 0.90. Gap report identifies specific (freq, aspect) combinations needing measurement. |
| **Dependencies** | Zenodo API, scikit-learn or XGBoost, PEACC/UAV/insect datasets |
| **Priority** | **P1** |

---

## Task 08 — DIY Maneuver Detection from Public TLEs

| Field | Value |
|---|---|
| **Objective** | Detect satellite maneuvers independently of US tracking infrastructure, using only public TLEs |
| **Sources** | Space-Track (free account, hourly TLEs). Orekit (open-source, SGP4/SDP4). |
| **Pipeline** | 1. Pull all TLEs for 300–800 km SSO (covers Shiyan-24, Shijian-6, most ISR sats). 2. For each object: propagate prior-epoch TLE forward 24h with Orekit SGP4. 3. Compare propagated position to next-epoch TLE → compute 3D residual. 4. Flag: residual > 1 km OR ΔV estimate > 0.1 m/s. 5. For flagged objects: track over subsequent epochs → classify as (a) single impulse, (b) sustained thrust (RPO), (c) station-keeping. 6. Cross-reference with Task 04 (LeoLabs public data) for confirmation. 7. Alert on: multi-object correlated maneuvers (2+ objects in same orbital plane, residual > 1 km within 24h of each other) — this is the Shiyan-24 signature. |
| **Outputs** | (a) Daily: "N maneuver candidates, M confirmed, K multi-object events." (b) Alert on multi-object correlated event: "Objects [IDs] in orbital plane [inclination] showing correlated residuals > 1 km over [N] consecutive epochs — consistent with RPO." (c) Monthly: "Total maneuvers detected: X. False positive rate: Y%. Multi-object events: Z." |
| **Cadence** | TLE pull: hourly. Analysis: daily (00:00 UTC). Alert: on-event. |
| **Success criteria** | Detect Shiyan-24-style RPO (3+ objects, <10 km separation, 7+ days) within 48h of start. False positive rate < 20%. Zero missed single-impulse maneuvers > 0.5 m/s. |
| **Dependencies** | Space-Track account, Orekit (Python bindings), Task 04 (cross-ref) |
| **Priority** | **P1** |

---

## Task 09 — Hypersonic IR Signature & Scramjet Plume Tracker

| Field | Value |
|---|---|
| **Objective** | Track open-literature modeling of hypersonic vehicle IR signatures to determine OPIR detection envelopes |
| **Sources** | Zenodo: `GET /api/records?q=hypersonic+infrared+OR+scramjet+plume+OR+waverider+OR+HGV+trajectory+OR+OPIR&sort=mostrecent`. MDPI Aerospace. AIAA journals. India HSTDV test data (record `11609935`). |
| **Pipeline** | 1. Daily query with keywords: `hypersonic IR`, `scramjet plume`, `waverider`, `HGV trajectory`, `OPIR detection`, `boost phase IR`, `Mach 6`, `Mach 10`, `Mach 15`, `infrared signature`, `thermal model`. 2. Classify: (a) *modeling* (computational IR flux calculation), (b) *measurement* (flight test IR data), (c) *detection threshold* (sensor sensitivity vs. target flux). 3. Extract key parameters: vehicle speed, altitude, aspect, IR flux (W/sr), wavelength band, detection range. 4. Build a "detection envelope" table: (speed, altitude, aspect) → (min detectable range for SBIRS/EOIR/SDA Tracking Layer). 5. Flag: any paper demonstrating HGV IR flux *below* OPIR detection threshold at operational range. |
| **Outputs** | (a) Weekly: "N new papers, M modeling, K measurement, J detection-threshold." (b) Updated detection envelope table (versioned). (c) Alert: "Paper [ID] demonstrates HGV at [speed], [altitude] is below [sensor] detection threshold at [range] — confirms gap for [theater]." (d) Quarterly: "Detection envelope update: N new data points, M gaps identified." |
| **Cadence** | Query: daily. Digest: weekly. Alert: on-event. |
| **Success criteria** | Detection envelope covers Mach 4–20, 20–100 km altitude, 0–180° aspect. All published HGV flight test IR data (India HSTDV, US HGV-1, China DF-ZF if released) ingested. |
| **Dependencies** | Zenodo API, MDPI/AIAA access, IR sensor spec data (SBIRS, SDA Tracking Layer — public portions) |
| **Priority** | **P2** |

---

## Task 10 — CCA Swarm C2 Architecture Tracker

| Field | Value |
|---|---|
| **Objective** | Track the command-and-control architecture research that enables the 1,000-aircraft autonomous goal |
| **Sources** | Zenodo: `GET /api/records?q=collaborative+combat+OR+autonomous+swarm+OR+multi-agent+formation+OR+manned+unmanned+teaming&sort=mostrecent`. arXiv: `cs.MA`, `cs.RO`. AIAA, IEEE. |
| **Pipeline** | 1. Daily query with keywords: `CCA`, `collaborative combat aircraft`, `loyal wingman`, `autonomous swarm`, `multi-agent formation`, `manned-unmanned teaming`, `hierarchical autonomy`, `C2 architecture`, `communication bottleneck`, `Swarm Aero`, `Legion`, `K-SWARM`. 2. Classify: (a) *C2 architecture* (how agents coordinate, communication topology, autonomy levels), (b) *airframe/flight* (not relevant), (c) *demonstration/exercise* (field test report). 3. Flag (a) and (c). 4. For (a): extract: number of agents, communication bandwidth, autonomy level, human-in-loop vs. human-on-loop, failure mode handling. 5. Track "DoD-affiliated" papers (author affiliation: AFRL, AFWERX, SDA, USNA, MIT Lincoln, DARPA). 6. Flag: any paper from a US DoD-affiliated lab on "hierarchical autonomy for heterogeneous UCAV swarms" → "possible CCA program tasking indicator." |
| **Outputs** | (a) Weekly: "N new papers, M C2-architecture, K demonstrations, J DoD-affiliated." (b) Alert: "DoD-affiliated paper on [C2 sub-niche] — possible CCA tasking indicator." (c) Quarterly: "C2 architecture maturity: N papers, M distinct approaches, top 3 open problems: [...]." (d) "Bottleneck report": what the literature says is the actual constraint on 1,000-aircraft scale (communication, compute, autonomy, certification). |
| **Cadence** | Query: daily. Digest: weekly. Alert: on-event. |
| **Success criteria** | No missed DoD-affiliated C2 papers. Bottleneck report updated quarterly. Alert within 48h of DoD-affiliated publication. |
| **Dependencies** | Zenodo API, arXiv API, Semantic Scholar (affiliation resolution) |
| **Priority** | **P2** |

---

## Cross-Cutting Requirements

| Item | Spec |
|---|---|
| **API rate limits** | Zenodo: 5 req/s (free). arXiv: 1 req/3s. Space-Track: 1000 TLEs/request. Respect all. |
| **Storage** | Postgres (structured) + S3 (raw PDFs/datasets) + TimescaleDB (time-series). |
| **Alerting** | Webhook (Slack/Teams) + email. P0: immediate. P1: within 4h. P2: next daily digest. |
| **Versioning** | All models, datasets, and reports versioned in Git. Config in YAML. |
| **Logging** | Every API call, every classification decision, every alert logged with timestamp + input hash. |
| **Security** | All data UNCLASSIFIED. No CUI. No PII. If any source returns CUI-marked data, discard and log. |
| **Human review** | Monthly: 1h review of all alerts + digests. Quarterly: 4h review of trend reports + model performance. |
| **Kill switch** | Any single task can be paused via config flag without affecting others. |

---

## Dependency Graph

```
Task 01 ──→ Task 02 ──→ Task 05
   │            │
   │            └──→ (feeds Task 06 cross-ref)
   │
   └──→ (triggers Task 05)

Task 04 ──→ Task 08 (cross-ref)

Task 07 ──→ (independent, feeds Task 03 classifier)

Task 03, 06, 09, 10 ──→ (independent, feed weekly digest)
```

---

## Sprint Plan (Suggested)

| Sprint | Duration | Deliverables |
|---|---|---|
| **S1** | 2 weeks | Tasks 01, 02, 05 operational. First PURSUE changelog generated. |
| **S2** | 2 weeks | Tasks 04, 08 operational. First TLE-based maneuver detection run. |
| **S3** | 2 weeks | Tasks 03, 07 operational. First Chinese stealth digest. RCS library ≥ 30 platforms. |
| **S4** | 2 weeks | Tasks 06, 09, 10 operational. Full pipeline live. First monthly report. |
| **Ongoing** | Weekly | All tasks running. Monthly human review. Quarterly model retrain. |
