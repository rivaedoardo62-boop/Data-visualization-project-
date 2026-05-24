# Visualisation Plan — final dashboard

This document locks the design choices for the six required visualisations *before* we build them, so that each task's output is consistent with the project requirements set in `DataViz_2026_final.pdf`.

## Research question (locked)

**Internal compass (the question we keep coming back to):**
> Why have wages in Italy been frozen since 1990?

**Research question (paper):**
> While in the rest of Western Europe real wages have grown significantly since 1995, in Italy they have remained essentially flat. Where and when did this divergence emerge, and which structural characteristics of the Italian economy — geographic, dimensional and generational — explain this exception?

**Site title (newspaper):** *L'eccezione italiana — Why we are the only major European country where wages have stopped growing.*

**Audience:** Italian readers of long-form economic journalism (Il Post, lavoce.info, Domani, Il Sole 24 Ore Plus). Numerate adults, not specialists in labour economics.

---

## Project requirements — checklist

From the project specification:

| Requirement | Target |
|---|---|
| Total visual components | ≥ 6 (group of 3 people) |
| Interactive and linked | ≥ 4 |
| Explanatory view for non-expert audience | ≥ 1 |
| Maximum line / bar charts | 1 |
| Creative visualisation | ≥ 1 |
| White-hat and black-hat static pair | 2 (1 of each) |
| Original JavaScript component | ≥ 1 |
| Datasets used | ≥ 2 public sources |
| Python notebook (cleaning + EDA + integration) | 1 |
| Static webpage (GitHub Pages) | 1 |
| Paper-style report (max 5 pages) | 1 |
| AI use appendix (max 2 pages) | 1 |

---

## Final viz inventory

Six visual components map to five analytical tasks plus the white-hat / black-hat pair:

| # | Task | Title | Type | Tool | Ecosystem | Interactive | Linked to | Role |
|---|---|---|---|---|---|---|---|---|
| 1 | T1 | Italy vs European peers — real wages, 1995–2024 | Line chart (the project's *only* allowed line chart) | Plotly | **Python** | Yes — preset period buttons, hover tooltip, end-of-line `% change` labels, gap band | T2, T5 | Establishes the fact + serves as **explanatory view for non-experts** |
| 2 | T2 | Paired choropleth — Italian regions vs European peer regions | Choropleth pair + connecting lines | **Tableau Public *or* Power BI** *(decision pending)* | **Tableau / Power BI** | Yes — click on Italian region filters #5 | T1, T5 | **Creative visualisation** (the dual-map design is the unconventional element) |
| 3 | T3 | Italian *nanismo* — firm size and productivity | Coxcomb / Florence Nightingale polar chart (4 country quadrants touching each other, inner cream ring with ISO-3 country labels, 5 stacked annular bands per country from Micro at the centre to V. Large at the rim; band thickness = share of national employment, colour = productivity in k€/worker) | Plotly | **Python** | Yes — Sunburst-style drill-down: click any country to expand it to 360° (full circle of concentric rings), click again to reset to the 4-quadrant view; hover for tooltip | none | Structural diagnosis |
| 4 | T4 | Italy is frozen — but for everyone? Real hourly wages by age band, 2014–2023 | Pictogram (coin stacks) | matplotlib + Plotly (interactive overlay) | **Python** | Yes — toggle to show/hide the 30–49 mid-career band | none | **Internal generational dimension** (Italy-only) |
| 5 | T5 | *What if Italy had grown like Germany?* | Personal calculator widget | **D3.js (original component)** | **JavaScript** | Yes — user input form | T1 | Climax of the narrative + satisfies the JS requirement |
| 6 | T6 | White-hat / black-hat ethics pair on Italian tax wedge | Two static bar charts (same dataset, opposite framing) | matplotlib | **Python** | No | none | Ethics requirement (per project specification §4: *"two static visualizations of your dataset, each representing a different perspective: white hat and black hat"*). Source dataset: OECD Taxing Wages, single childless workers 100–167% AW, 18 European OECD countries 2000–2024. |

**Quota verification:**
- 6 visual components ✓
- 4 interactive + linked: #1, #2, #3, #4 (or #5) ✓
- 1 creative: #2 (paired choropleth) ✓
- 1 explanatory non-expert: #1 ✓
- 1 line chart only: #1 (the only one) ✓
- 2 static white-hat / black-hat: #6 ✓
- 1 original JavaScript component: #5 ✓
- **Three ecosystems ✓ — Python (#1, #3, #4, #6), Tableau or Power BI (#2), JavaScript (#5).** This satisfies §4.1 of the project specification ("Use at least three of the following ecosystems: Python, Tableau, Power BI, and JavaScript").

---

## Tool stack

| Layer | Tool | Rationale |
|---|---|---|
| Data acquisition + cleaning | Python (pandas) | Single-language pipeline; reproducibility; matches the consegna requirement for a Python notebook. |
| Static visualisations (white/black-hat, EDA) | matplotlib + seaborn | Tight control of design; suitable for newspaper aesthetic. |
| Interactive visualisations on the site | Plotly (Python) + **Tableau Public *or* Power BI** for the choropleth | Plotly for D3-quality charts embeddable as HTML; the choropleth uses Tableau or Power BI both because their mapping engines are faster and richer than Plotly's, and because their inclusion satisfies the §4.1 requirement of using at least three different ecosystems. **Decision between Tableau Public and Power BI is pending.** |
| Original JS component | D3.js (vanilla JS fallback) | Required by the consegna; D3 gives full design control for the calculator widget. |
| Site | Static HTML + CSS + JS, served via **GitHub Pages** at `https://filipponannucci.github.io/Data-visualization-project/`. | The static-HTML site (`site/`) is the source of truth; `deploy.sh` syncs `site/` → `docs/` so GitHub Pages republishes from the `docs/` folder on push. |
| Documentation | Markdown in repo (this file, SOURCES.md, paper.md) | Plain-text, version-controlled, auditable. |

**Decision (resolved).** Static HTML on GitHub Pages, no WordPress. The project specification's wording — *"Develop a WordPress webpage to present the project, embedding or linking the visualizations"* — is interpreted to require a webpage that presents the project and links/embeds the visualisations; the choice of CMS is treated as a means, not an end. GitHub Pages publishes from the `docs/` folder kept in sync with `site/` via `deploy.sh`. The page satisfies every editorial requirement of the brief (introduction, dataset+task description, interactive visualisations, conclusion) without forcing the interactive Plotly/D3/Tableau artefacts to be rebuilt inside WordPress's editor.

---

## Design language

The site is conceived as an interactive Italian newspaper article ("*L'eccezione italiana*"), not a dashboard. All visualisations share a coherent aesthetic that reinforces this metaphor.

- **Typography.** A serif typeface for headlines and body copy (Playfair Display or Bodoni for titles; EB Garamond for body); a sans-serif for chart UI (Inter). No more than three families across the entire site.
- **Palette.** Newspaper neutrals (off-white background, ink-black text, mid-grey rules and gridlines) with a single editorial accent — `#c44536` (deep red, evocative of Italian press headlines) — used to highlight Italy in every chart. International peers are muted grey. No multi-colour categorical palettes.
- **Chart style.** Sparing use of axes (no top/right spines), light grid lines, end-of-line labels in place of legends where possible. Annotations rendered in the body-text font, italic and grey.
- **Density.** Each chart should be readable on a single screen without scrolling, with a one-sentence caption that states the headline finding.

---

## Linking logic

Four of the six visualisations are interactive and form a linked system. The link structure is centred on **country** (for T1 ↔ T2 ↔ T5) and on **year** (for T1 ↔ T2):

```
            Country selection
              ↓        ↑
    T1 (Italy vs peers)  ←→  T5 (calculator: user salary in alternative country trajectories)
              ↓
    T2 (paired regional map: highlighted region depends on country)
```

T3 (firm size) and T4 (cohorts) are independent: they answer self-contained sub-questions and do not need to receive filters from the other charts.

---

---

## Detailed design — Viz #1 (T1)

### Goal

In five seconds the reader should see (i) that Italy is flat while peers grow, (ii) that the divergence opens after 2008–2011, and (iii) feel invited to interact (toggle a country, drag the slider).

### Decisions

- **Type**: single-axis indexed line chart (1995 = 100). This is the project's *only* allowed line chart. The dual-axis wage-vs-productivity comparison is *not* used here — the Italian wedge is small and would weaken the headline message. Productivity stays in the EDA notebook for documentation.
- **Default state on landing**: Italy (accent red, 2.5 pt), Germany / France / Spain / United Kingdom / Sweden (muted grey, 1.5 pt), OECD-Total (dark grey dashed, as background benchmark). End-of-line country labels replace a traditional legend.
- **Annotations**: vertical dashed marks at 2008 (Global Financial Crisis) and 2011 (Sovereign-debt crisis). Click on the annotation opens a small card with the macro context for that year.
- **Interactions**:
  - *Hover on a line*: tooltip with country, year, indexed value, cumulative % change vs 1995.
  - *Click on a line*: highlight that line (accent), fade the others.
  - *Country toggles row above the chart*: turn each country on/off.
  - *Year-range slider below the chart*: zoom on a sub-period; Y-axis rescales accordingly.
- **Linking out**: clicking a country line sets that country as the comparison reference in Viz #5 (the *What if Italy grew like X?* calculator).

### Visual language (binding)

| Element | Style |
|---|---|
| Title | Playfair Display, 22 pt, weight 700 |
| Subtitle / italic caption | EB Garamond italic, 14 pt, grey `#666` |
| Axis labels and tick labels | Inter regular, 11 pt, grey `#444` |
| Tooltip | Inter, 12 pt, white on dark navy `#1a3a5c` |
| End-of-line country labels | Inter, 11 pt, country colour |
| Italy line | `#c44536` (editorial red), 2.5 pt |
| Peer lines | `#888888`, 1.5 pt |
| OECD reference | `#444444`, dashed |
| Background | `#fafafa` |
| Horizontal grid | `#e0e0e0`, no vertical grid |
| Top / right spines | hidden |

### Title and copy

- Title: *Italy: alone in Europe.*
- Subtitle: *Real wages, indexed to 1995 = 100 — the gap with peers opened after 2008.*
- Footer: *Source: OECD Average Annual Wages (constant USD PPP). Hover any line for country-year values.*

### Layout

```
┌────────────────────────────────────────────────────────┐
│  Italy: alone in Europe                                │
│  Real wages, indexed to 1995 = 100…                    │
├────────────────────────────────────────────────────────┤
│                                                        │
│  [country toggles]   IT  DE  FR  ES  UK  SE   OECD     │
│                                                        │
│  ┌──────────────────────────────────────────────────┐  │
│  │           [Plotly line chart]                    │  │
│  └──────────────────────────────────────────────────┘  │
│                                                        │
│  [year-range slider 1995 ──────●──── 2024]             │
│                                                        │
│  Source: OECD Average Annual Wages…                    │
└────────────────────────────────────────────────────────┘
```

### Tool

Plotly (Python). Exported as a standalone HTML file embeddable in the newspaper site.

### Out of scope for #1 (logged for *Rejected Alternatives*)

- *Dual-axis chart with productivity*: rejected because the Italian wedge is too small to anchor the headline; dual-axis is also a discouraged pattern.
- *Auto-playing animation across years*: rejected because it removes user control; the slider is preferred.
- *Comparison in absolute USD*: rejected because indexed values are clearer for a non-expert audience.

---

## Detailed design — Viz #4 (T4)

### Goal

In five seconds the reader should see (i) that the macro-level freeze established in T1 holds for *every* age band when measured inside Italy with consistent methodology, (ii) that, contrary to a popular intuition, the 50+ band has lost more real-wage ground than the 15–29 band over the decade 2014–2023, and (iii) that the decline is concentrated in the post-2021 inflation wave that collective bargaining has not absorbed.

### Core question (final, locked)

> *Italian real wages have been flat in aggregate since the 1990s (T1). When the freeze is broken down by age band, did all groups stagnate equally, or did some lose more than others?*

### Decisions

- **Type**: pictogram with coin stacks. One coin = €1 of real gross hourly wage in 2023 euros (HICP-deflated).
- **Snapshots**: 3 years — **2014, 2021, 2023**. The choice is deliberate. Inside the 2014–2023 window the decline is *not* spread evenly: real wages were essentially stable from 2014 through 2021, then collapsed in two years as cumulative HICP inflation 2021→2023 (+15 %) was not absorbed by collective-bargaining adjustments. Picking 2018 as the middle snapshot would understate this — 2018 wages are essentially identical to 2014. Picking **2021** instead surfaces the actual editorial finding: *seven years of stability, two years of cliff*.
- **Static version (newspaper / paper)**: paired stacks of **15–29** (accent red `#c44536`) and **50+** (ink black `#1a1a1a`) inside each year group. Layout A — three year-groups side-by-side, two stacks within each group. A € symbol sits on the top coin of each stack as the "money" cue, not on every coin (avoids clutter at 11–15 coins per stack).
- **Interactive version (site)**: same three years, but with the **30–49** mid-career band (mid grey `#8a8a8a`) shown alongside. A **year-by-year animation** reveals the snapshots in chronological order — first the 2014 baseline, then 2021 (visually identical to 2014), then 2023 with decline annotations (Δ % vs 2014) appearing next to each band's stack: −9.4 % / −10.8 % / −12.8 %.
- **Italy-only.** The European peer comparison is already established in T1; reproducing it here would be redundant and would force a methodological mismatch.
- **No splicing.** An earlier draft attempted to extend the series back to 2006 by chain-linking with Eurostat earn_ses_pub2a, but the Eurostat universe (firms ≥ 10 employees) creates a 7–15 % level mismatch with ISTAT for the 30–49 and 50+ bands due to firm-size composition. Backcasting was therefore abandoned in favour of a single-source 2014–2023 window.
- **Annotations**: in the static version, a curved arrow over the stacks of each band, drawn from 2014 stack-top to 2023 stack-top, labelled with the % real change ("−9.4% real, 2014→2023" for 15–29; "−12.8% real, 2014→2023" for 50+). In the interactive version, the same percentages appear as text labels above the 2023 stacks in the final animation frame.
- **Interactions** (interactive version):
  - *Hover on a coin*: tooltip with year, age band, real wage, % change vs 2014.
  - *▶ Watch the decade*: auto-plays the three-frame animation (2014 → +2021 → +2023 with decline annotations). Each frame holds for ~1.7 s.
  - *⏮ Restart* / *⏭ Skip to end*: navigate directly.
  - *Slider* (3 stops): manual stepping through the three frames.

### Visual language

Inherits the binding from #1 — newspaper neutrals, accent red `#c44536` for the young-wage stack, ink black `#1a1a1a` for the senior stack, mid grey `#8a8a8a` for the optional 30–49 stack in the interactive version. Off-white background, no axes, no spines.

### Title and copy (final)

- **Title**: *Italy is frozen — but for everyone?*
- **Subtitle**: *Real hourly wages of Italian dependent workers, 2014–2023.*
- **Sub-subtitle**: *Both age bands lost ground in real terms — and senior workers lost more than the young.*
- **Footer**: *One coin = €1 of gross hourly wage in real 2023 euros (HICP-deflated). Source: ISTAT RACLI 2014–2023, dependent workers, all firm sizes.*

### Tool

matplotlib for the static newspaper version; Plotly for the interactive embedded in the site.

### Out of scope for #4 (logged for *Rejected Alternatives*)

- *Eurostat earn_ses_pub2a backcasting (2006, 2010)*: tested and rejected. Cross-check on the 2014/2018/2022 overlap shows the Y_LT30 band agrees within ±1.6 % (splice-able), but the Y30–49 and Y_GE50 bands differ by 7 % and 12–15 % respectively because Eurostat excludes firms < 10 employees, where senior workers earn substantially less. Splicing the senior series would have introduced a level break exactly where the chart's headline claim sits.
- *INPS Osservatorio Lavoratori Dipendenti e Indipendenti (5-year age bands, annual income, 2014–2024)*: would have been a quality upgrade — finer 5-year bands (25–29, 30–34, …) and annual rather than hourly wages — but published only as 11 separate yearly PDF reports (no bulk download or open-data API). Estimated 2–4 hours of scraping; rejected as out of project deadline budget.
- *Banca d'Italia SHIW (1977–2022, biennial)*: rejected because aggregate tables are at household-equivalised level (same problem as the rejected `ilc_di03`), and individual microdata require an academic application.
- *Eurostat IT-SILC PY010G (individual gross earnings)*: not published as standalone aggregate at age × year cross-tab; available only via microdata request.
- *European peer benchmark inside T4*: rejected because it would duplicate T1's job and no European dataset offers annual age-broken wages with ISTAT-comparable methodology.
- *Birth-cohort tracking ("born 1965 vs born 1985")*: rejected — would have required a 30-year microdata panel; SHIW could have supported it but only with a microdata application.

### Honest finding (worth flagging in the paper)

The original working hypothesis for T4 was an *asymmetric freeze* — average flat, young falling, senior steady. The data do not support it. Over 2014–2023 every age band lost real-wage ground (15–29: −9.4 %, 30–49: −10.8 %, 50+: −12.8 %), with the 50+ band losing the most. The decline is concentrated in 2021–2023: HICP cumulative inflation 2021→2023 was +15 %; collective bargaining absorbed only a fraction of it, so the real-wage hit is mostly a recent post-COVID inflation event, not a long-term trend.

---

## Detailed design — Viz #6 (T6): white-hat / black-hat ethics pair

### Goal

Demonstrate, on a politically charged dataset (the OECD tax wedge for Italian and European workers), how the same numbers support incompatible interpretations depending on the editorial choices the visualisation makes. T6 is the project's reflexive moment, satisfying §4 of the project specification: *"two static visualizations of your dataset, each representing a different perspective: white hat and black hat."*

### Reference framework

Following the rubric of MIT 6.859 (*Interactive Data Visualization*, Pfister, Spring 2021):

- **White-hat** — clear and easy to interpret for the intended audience; data transformations explicitly communicated; sources and potential biases stated.
- **Black-hat** — manipulation in at least two of: visual encoding, data transformation, titles/labels. *Subtlety counts:* an excellent black-hat passes a casual-reader test; manipulation lives in data choices, not in screaming visual cues.

### Dataset

OECD `OECD.CTP.TPS,DSD_TAX_PIT@DF_PIT_AVMR,1.0` — *Personal income tax (PIT) and social security contributions (SSC) — average rates on gross wage earnings*. Single, no children, 18 European OECD countries × 25 years (2000–2024) × 4 income levels (67/100/133/167 % AW) × 4 measures (PIT, EE_SSC, ER_SSC, PIT+EE_SSC). Detailed sourcing in `data/task_6/SOURCES.md`.

### White-hat design (locked)

- **Type**: horizontal bar chart, all 18 European OECD countries, sorted ascending by burden, Italy highlighted in the project's accent red (`#c44536`), peers in mid grey (`#888888`).
- **Metric**: PIT + employee SSC at 100 % of average wage — the canonical OECD comparison point and the rate the worker actually loses on their payslip.
- **Reference line**: European median, marked with a dashed grey vertical line.
- **Title**: *"Italy's tax wedge in European context"* — descriptive and neutral.
- **Subtitle**: *"Personal income tax and employee social security contributions, single worker at 100 % of average wage, 2024."*
- **Source caption**: full, with a one-line methodological note (rates as % of gross wage; excludes employer SSC and cash-benefit rebates).

### Black-hat design (locked) — four manipulation levers

The black-hat is built from the *same* dataset by applying four subtle editorial slants in concert. All four are documented honestly in the paper, none of them is a falsification, and the chart looks like a serious newspaper piece on first inspection — but the message it communicates is incompatible with the data's actual content.

| Lever | White-hat choice | Black-hat choice | Effect |
|---|---|---|---|
| Comparators | All 18 European OECD members | 12 selected countries: Italy + UK + Switzerland + Ireland + Netherlands + Iceland + Luxembourg + Denmark + Germany + Finland + Spain + Portugal | Looks like a credible 12-country European overview but silently excludes France (78%), Belgium (74%), Sweden (65%) and Austria (61%) — the four countries that beat or rival Italy on this manipulated metric and would break the narrative |
| Income level | 100 % of average wage *(canonical OECD baseline)* | 167 % of average wage *(the highest-taxed bracket)* | Inflates Italy's tax burden because of the progressive structure |
| Numerator + denominator | OECD canonical: (PIT + EE_SSC + ER_SSC) ÷ (gross wage + ER_SSC) | Numerator unchanged; denominator switched to *gross wage* alone | Italy goes from 47.0 % (canonical) to 71 % using the same numerator with a different denominator. The chart's axis label still says "Tax wedge", silently substituting one denominator for another |
| Title and source caption | Descriptive, methodologically explicit | *"Italy's true tax burden on workers"* + *"Source: own elaboration on OECD Taxing Wages data, 2024"* | Title reads as quality newsroom journalism rather than tabloid; the word *"true"* is the rhetorical hinge, implying alternative figures the reader has seen elsewhere are misleading. The phrase *"own elaboration"* in the source line legitimises any data transformation we made |

### Outputs

- `site/viz/t6_whitehat.png` — honest cross-country tax-wedge bar chart.
- `site/viz/t6_blackhat.png` — manipulated version of the same data.
- `site/viz/t6_ethics_pair.png` — side-by-side combined figure for the paper's ethics-reflection section.

### Tool

matplotlib only — both figures use identical palette, typography, and chart structure to the rest of the project (newspaper aesthetic, accent red `#c44536`, EB Garamond / Playfair Display family). The black-hat must look like a sibling of the white-hat to satisfy the *subtlety* criterion.

### Out of scope for #6 (logged for *Rejected Alternatives*)

- *Marginal-rate dataset*: visible in the OECD search but rejected because marginal-rate brackets are bracket-dependent and not directly comparable across countries with different bracket structures. The average-rate dataset is methodologically cleaner.
- *Eurostat tax-revenue-as-%-of-GDP*: a valid macro tax-pressure measure but at country level rather than worker level. Less suitable for the *"Lo Stato ruba lo stipendio"* framing, which is inherently about the individual payslip.
- *Time-series version*: Italy's tax wedge has been roughly flat since 2000, so a time-series chart does not produce a useful black-hat slant. The cross-section comparison with cherry-picked low-tax peers is more rhetorically forceful.
- *Italian-specific ISTAT data*: would have allowed regional or sectoral disaggregation but does not produce the cross-country comparison axis on which the white-hat / black-hat exercise turns.

---

## Out of scope (explicitly rejected)

Decisions logged here so the *Rejected Alternatives* section of the paper can reference them.

- *Sectoral wage decomposition* (NACE-level): would duplicate T3's diagnosis without adding visual variety; not enough time to do justice to a fourth interactive chart.
- *Gender pay gap analysis*: meaningful sub-question but dilutes the central argument; mentioned in paper limitations, not visualised.
- *Brain drain / migration flows*: data quality across European registers is uneven; visual treatment would need significantly more time.
- *Sankey diagram of wage distribution*: considered for the creative slot but discarded in favour of the paired choropleth, which is more directly tied to the research question's geographic dimension.
- *Dual-axis chart for wage and productivity*: explicitly avoided as a misleading design pattern. The single-scale indexed line chart used in #1 is the correct alternative.
