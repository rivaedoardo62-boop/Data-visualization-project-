# The Italian Stagnation — A Multi-Lens Visual Investigation

A six-figure interactive newspaper feature investigating Italian
real-wage stagnation in Western European context, built as the final
project for **Data Visualizations 2026** at LUISS Guido Carli.

**Authors (alphabetical):** Daniele Giovanardi · Filippo Nannucci · Edoardo Riva
**Submission date:** 10 May 2026

---

## Live site

The project is published online via GitHub Pages. The live, fully
interactive article is at:

**https://filipponannucci.github.io/Data-visualization-project/**

This is the canonical artefact. The PDFs (paper + AI appendix) and the
notebooks are submission-side documentation; the live site is the
project.

---

## Repository structure

```
Data-visualization-project/
├── README.md                       ← this file
├── DataViz_2026_final.pdf          ← project brief (reference)
├── 02_viz_plan.md                  ← internal design doc
│
├── Task_1.ipynb … Task_6.ipynb     ← one notebook per task (T1–T6)
├── T2_italian_exception.twbx       ← Tableau workbook for T2 (regional choropleth)
├── deploy.sh                       ← syncs site/ → docs/ for GitHub Pages
│
├── data/
│   ├── task_1/                     ← OECD wages, Eurostat HICP
│   ├── task_2/                     ← Eurostat NUTS-2 GDP, EA20 reference
│   ├── task_3/                     ← Eurostat structural business stats
│   ├── task_4/                     ← ISTAT RACLI, HICP deflator
│   ├── task_5/                     ← OECD wages (extended), price list
│   └── task_6/                     ← OECD Taxing Wages
│      (each task folder contains its raw CSV/JSON inputs and a SOURCES.md)
│
├── site/                           ← working copy of the static site
│   ├── index.html                  ← article body + embedded iframes
│   └── viz/                        ← per-task chart outputs
│
├── docs/                           ← published copy (GitHub Pages serves from here)
│
└── paper/
    ├── main.pdf                    ← 5-page paper-style report
    ├── ai_appendix.pdf             ← AI use appendix
    ├── presentation.pptx           ← final 7-slide presentation deck
    ├── presentation.pdf            ← compiled deck
    └── presentation_speech.md      ← English speaker notes
```

---

## How to access the project

**The fastest way** is to open the live URL above in a recent browser
(Chrome, Firefox, Safari). No setup is required: every interactive
chart is embedded, every dataset is bundled, and the JavaScript
calculator runs client-side.

If you prefer to run the site locally, clone the repository and serve
the `site/` folder through any static-file server (for example
`python3 -m http.server` from inside `site/`). The Tableau component
of T2 still requires internet access because it is hosted on Tableau
Public.

---

## How to reproduce the analysis

The Python notebooks regenerate every chart in `site/viz/` from the
raw datasets in `data/`. To re-run them:

```bash
# 1. Create and activate a Python ≥ 3.10 environment
python3 -m venv .venv && source .venv/bin/activate

# 2. Install the dependencies
pip install pandas numpy matplotlib seaborn plotly nbclient nbformat pillow

# 3. Run a notebook (example: T3 Coxcomb)
python3 -c "import nbclient, nbformat; \
    nb = nbformat.read('Task_3.ipynb', as_version=4); \
    nbclient.NotebookClient(nb, timeout=180).execute(); \
    nbformat.write(nb, 'Task_3.ipynb')"

# 4. (After all notebooks have run) sync the working site to GitHub Pages
bash deploy.sh
```

The Tableau workbook (`T2_italian_exception.twbx`) is the source of T2
and can be opened in Tableau Desktop or Tableau Public.

## Tools used

| Layer | Tool |
|---|---|
| Data acquisition + cleaning | Python (pandas) |
| Static figures (T6 white-hat / black-hat) | matplotlib |
| Interactive charts (T1, T3, T4) | Plotly |
| Regional choropleth (T2) | Tableau Public |
| Personal calculator (T5, JavaScript component) | D3.js + vanilla JS |
| Site | Static HTML + CSS, served via GitHub Pages |
| Paper + AI appendix | PDF (compiled deliverables) |

---

## Submission package

The submitted ZIP contains: this repository (notebooks, data, source
code, site, Tableau workbook), the compiled `paper/main.pdf` (5-page
report), the compiled `paper/ai_appendix.pdf` (AI use appendix), and
the public link to the live site (above).
# Data-visualization-project-
