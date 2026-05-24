# Task T3 — The Italian "nanismo"

**Question:** *Are Italian firms too small to be productive — and is this what's holding wages down?*

This task tests whether Italy's economic structure, dominated by very small firms, contributes mechanically to its low aggregate productivity (and therefore to its slow wage growth, see T1).

---

# Dataset T3.1 — Eurostat Structural Business Statistics by size class

## Source

- **Provider:** Eurostat — Statistical Office of the European Union
- **Database:** `sbs_sc_sca_r2` — *Annual enterprise statistics by size class for special aggregates of NACE Rev. 2 activities (2005-2020)*
- **Indicator page:** https://ec.europa.eu/eurostat/databrowser/view/sbs_sc_sca_r2/default/table?lang=en
- **Date of download:** [INSERT DOWNLOAD DATE]
- **License:** Eurostat Reuse Policy — CC BY 4.0
- **Method of download:** Eurostat REST API (JSON-stat 2.0 format), parsed into pandas. Script reproducible from the project notebook (`Task_3.ipynb`, section 2).

## Filters applied via the REST API

The full request URL (decoded for readability):

```
https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/sbs_sc_sca_r2
  ?nace_r2=B-N_S95_X_K
  &time=2020
  &geo=IT&geo=DE&geo=FR&geo=ES
  &indic_sb=V11110&indic_sb=V16110&indic_sb=V91110&indic_sb=V92100
  &size_emp=0-9&size_emp=10-19&size_emp=20-49&size_emp=50-249&size_emp=GE250&size_emp=TOTAL
  &format=JSON
```

| Dimension | Value | Meaning |
|---|---|---|
| `nace_r2` | `B-N_S95_X_K` | Industry, construction and services excluding financial / insurance and activities of households as employers — the standard "non-financial business economy" aggregate |
| `time` | `2020` | Latest available year in the legacy SBS dataset |
| `geo` | IT, DE, FR, ES | Italy + three Western European peers |
| `indic_sb` | V11110, V16110, V91110, V92100 | Indicators (see below) |
| `size_emp` | `0-9`, `10-19`, `20-49`, `50-249`, `GE250`, `TOTAL` | Five size classes plus total |

## Indicator codes downloaded

| Code | Indicator | Unit |
|---|---|---|
| `V11110` | Number of enterprises | count |
| `V16110` | Persons employed | count |
| `V91110` | **Apparent labour productivity** (gross value added at factor cost / persons employed) | thousand euro per person |
| `V92100` | Persons employed per enterprise | persons |

## Why these choices

- **NACE B-N_S95_X_K**: the Eurostat-standard "non-financial business economy" aggregate. Excluding financial/insurance and household services makes results comparable across countries with different sectoral compositions.
- **2020 latest available**: `sbs_sc_sca_r2` is the legacy SBS dataset and stops in 2020. Eurostat is still migrating the post-2020 data to the new EBS framework, and a replacement size-class breakdown is not yet uniformly available across countries. 2020 includes COVID effects but firm structure is slow-moving — a 2020 snapshot is representative of the underlying structural composition of firms.
- **Four-country panel**: same as T1 and T2 to keep cross-task narratives consistent.
- **All five size classes plus TOTAL**: the full firm-size distribution, plus the country-level total for normalisation.
- **V91110 (apparent labour productivity)** is preferred over computing productivity ourselves from value added and persons employed: Eurostat's calculation is consistent across countries and corrects for known classification quirks.

## What we *do not* have (and why)

We attempted to add **wages and salaries by size class** (V13320, V13310, V91230) to enrich the analysis with a direct wage-vs-size dimension. **None of these variables are published by size class** in `sbs_sc_sca_r2` for our country panel — Eurostat suppresses the breakdown for confidentiality reasons in many cases.

The wage angle is therefore handled in the paper via cross-reference to T1 (real-wage stagnation), not as a fourth dimension in the T3 chart.

## Number of observations

| | Obtained |
|---|---|
| Total cells | 144 (theoretical: 4 indicators × 6 size classes × 4 countries × 1 year) |
| Non-missing cells | 96 (= 24 per indicator) |
| Coverage rate | 100 % for the 4 indicators we obtained |

The "missing" cells correspond to indicators we requested but were not published (V13320 wages, V16130 employees, etc.). These are documented above as a known dataset gap.

## Sanity check (key headline numbers from the cleaned file)

| Country | % employment in micro (0-9) | Productivity in micro (k€/person) | Country average productivity |
|---|---|---|---|
| Italy | **42 %** | 27.6 | 46.4 |
| France | 23 % | 46.1 | 59.7 |
| Germany | 19 % | 44.6 | 61.8 |
| Spain | 35 % | 25.5 | 39.7 |

Two facts stand out:

1. Italy has the highest share of employment concentrated in micro-firms among the four countries.
2. Italian micro-firms (0-9 employees) are significantly less productive than German micro-firms — €27.6 k vs €44.6 k of value added per person, a 38 % gap. The gap *narrows* sharply for larger firms.

## Saved files

- `data/task_3/sbs_size_class_eurostat_2020_raw.csv` — raw long-format dump from the Eurostat API (96 rows, all original codes preserved for traceability).
- `data/task_3/sbs_size_class_eurostat_2020_tidy.csv` — wide-format tidy file used for analysis (24 rows: one per country × size class, columns for each indicator with readable names).

## Known limitations

- **2020 only**: a single year of data. The structural composition of firms is slow-moving so this is acceptable, but the analysis cannot show changes over time the way T1 and T2 can. A multi-year extension is possible by re-querying the same dataset with a wider `time` parameter.
- **NACE B-N_S95_X_K excludes financial activities (K)**: chosen for cross-country comparability, but means the analysis does not capture the role of small banks or insurance brokers in Italy.
- **No wage data by size class**: documented above. The paper's wage commentary is anchored in T1, not in a wage column inside this dataset.
- **2020 includes COVID**: while structure changes slowly, the productivity values for some sectors may be slightly distorted by lockdown effects. We flag this in the paper rather than smooth it away — it is the most recent reliable data point.
- **Eurostat revisions**: the dataset is subject to retrospective revisions when national statistical offices update their submissions. Cite the download date for reproducibility.
