# The Italian Stagnation — Presentation speech (English)

Speaker notes for the 10-minute talk. One block per slide. Three speakers, ~1 minute per non-demo slide and 3 minutes for the live demo.

**Order of speakers:**  Edoardo (slides 1–3) → Daniele (slide 4 + first half of the live demo) → Filippo (second half of the demo + slides 6–7).

---

## Slide 1 — Title

_Speaker: **Edoardo** — 30 seconds_

Good morning. Our project is a visual investigation of Italian wage stagnation, built as an interactive newspaper feature rather than a dashboard. Three of us are presenting today: I open with the motivation and the data; Daniele takes over with the design choices and starts the live walk-through of the site; Filippo closes with the JavaScript component and our limitations.

---

## Slide 2 — Motivation

_Speaker: **Edoardo** — 1 minute_

We started from a cultural fact. "In Italia gli stipendi sono fermi" — "in Italy wages don't move" — is something you hear everywhere in Italian public conversation, from family dinners to talk shows. It's a claim repeated constantly, but almost never put next to comparable European numbers.

So we built the project around that question: is it actually true, and if it is, what are the magnitudes? The answer turns out to be stark. Across Western Europe in the last three decades, real wages grew between roughly 5% and 60%. In Italy, just 3%. The gap is enormous.

The question we set out to investigate is therefore: why is Italy the exception, and what does it cost the individual worker? Everything in the project is built around that.

---

## Slide 3 — Data

_Speaker: **Edoardo** — 1 minute_

Our data: seven public datasets from three statistical agencies — OECD, Eurostat, and ISTAT. Every dataset was downloaded by hand from the providers' web portals with explicit filter selections. No APIs, no scraping. We did exploratory data analysis on every dataset before committing to a chart form, and in some cases we changed our initial hypothesis once we'd actually seen the numbers.

These seven datasets are the analytical pillars of the whole project. I'll now hand over to Daniele to explain how we decided to present them.

---

## Slide 4 — Design logic

_Speaker: **Daniele** — 1 minute_

The design choice for the project. I'll start from the principle that drives everything: "an article you read, not a dashboard you query." An interactive newspaper feature, not an analytical interface.

Three concrete decisions follow from that principle.

**One — form follows function.** Each chart's form is chosen for what it has to communicate fastest. T1 is a line chart for the 30-year trajectory; T2 is a map for regional comparison; T3 is a Coxcomb (Florence Nightingale style) to cross employment share with productivity in a single view; T4 is a coin pictogram to make a 15% real-wage drop emotionally legible.

**Two — editorial wrapping.** Every chart is framed by prose. A setup paragraph that asks the question, the chart, then a findings paragraph that interprets it. The article reads sequentially or you can jump in.

**Three — the cross-link, T1 to T5.** Clicking on a country line in the macro chart auto-fills the personal calculator further down the page and scrolls to it. The aggregate fact becomes a personal one. The brief requires that at least four visualisations be "interactive and linked"; this is the strongest of those links.

Now let's go to the site.

---

## Slide 5 — Live demo (the site)

_Speaker: **Daniele + Filippo** — 3 minutes total_

Daniele leads the first three charts; Filippo continues with the last three. The slide on screen is just a launchpad — the demo happens in the browser.

**— DANIELE — 1m 30s —**

Open the demo. Briefly introduce the editorial structure: intro, deck, six figures interleaved with prose.

**1. T1 (~30 sec)** — line chart of Italy versus peers. Hover on Italy for the story (peak around 2010, returns near 1995 levels). Try the Pre/Post-2008 slider filter. Click on Germany to foreshadow the cross-link to the personal calculator.

**2. T2 (~30 sec)** — NUTS-2 choropleth. Hover on Lombardia (−26 percentage points versus the EA20 reference). Hover on Bolzano (the green outlier, the only Italian region at parity). Underline: 20 of 21 regions below the European average. The slowest-growing region isn't in the south — it's Umbria.

**3. T3 (~30 sec)** — the firm-size Coxcomb. Click an Italian sector to drill down into the 360° view. Use the country checkboxes to filter. Underline: 42% of the Italian workforce is in micro-firms (Germany 19%), and Italian micro-firms produce €28k versus €45k in German equivalents.

**HANDOVER.** Daniele says: "Filippo will take you through the second half of the walk-through."

**— FILIPPO — 1m 30s —**

**4. T4 (~30 sec)** — age pictogram. Press "Watch the decade" for the animation across 2014, 2021, 2023. Underline: −12.8% for over-50s, against the popular intuition.

**5. T6 (~30 sec)** — the white-hat / black-hat pair. Same chart, same data source. The Italian number jumps from 47% to 71% by changing four editorial levers and nothing else.

**6. T5 (~30 sec)** — the calculator. Move the year slider, change the country (Sweden), change the unit (Vespas, pizzas). Tease that the next slide explains the JavaScript component behind it.

Hard time-cap: 3 minutes total.

---

## Slide 6 — JavaScript component

_Speaker: **Filippo** — 1 minute_

The JavaScript component required by the brief is the personal calculator I just showed live at the end of the demo. It's vanilla JavaScript with D3.js for the trajectory chart.

**Left card — what it does.** Three reader inputs: the start year (a slider), the comparator country (18 European OECD members), and an optional override salary (defaults to the ISTAT median). It computes the year-by-year cumulative real-wage gap and renders it three ways: as a euro figure, as an SVG trajectory, and as concrete units — Vespas, pizzas, months of Milan rent.

**Right card — the cross-link.** This is what satisfies the brief's "interactive and linked" requirement. When the reader clicks a country line in T1, that chart sends a postMessage to the parent page; the parent forwards it to T5, the calculator updates the comparator, re-runs, and the page scrolls. The aggregate fact becomes immediately personal.

---

## Slide 7 — In closing

_Speaker: **Filippo** — 1 minute_

I'll close on one finding and one caveat.

**The finding (left card).** Three decades of essentially flat Italian real wages. Indexing 1995 to 100 — the same baseline as Figure 1 on the site — Italy in 2024 sits at 103. Spain is at 105. Germany 122. France 127. The OECD average is at 131. Sweden is at 162. Italy's position is solitary: no peer is below +5%.

**The caveat (right card, marked in red).** We document correlations, not causes. The explanations that fill Italian public debate — geopolitics after the 1990s, political and administrative instability, the COVID pandemic, the 2022 energy shock, demographic ageing — are absent from our analysis. Not because they don't matter, but because our project is a visual investigation, not a causal model.

The data-side limitations (aggregates rather than microdata, heterogeneous coverage windows, the Western-European peer set, the single-year T3 snapshot, T6's sensitivity to denominator choice) are all documented in §6 of the paper.

Thank you. Questions?
