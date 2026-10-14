---
icon: material/numeric-6-box
title: Využití LLM pro tvorbu webové mapy. Návrh, ladění a publikace webové mapy.
---
# Prompt Cartography: From Prompt to Web Map

In the previous practical, we learned to act as **map directors**: define the purpose, audience, and guardrails before asking an LLM to create a map.

Today, we will go from a design brief to a **working interactive web map**. Rather than configuring an ArcGIS builder, we will use a coding-capable LLM to create a browser-based application with **HTML, CSS, and JavaScript**.

The challenge is familiar: recreate the **content and cartographic logic** of the natural hazard web map made earlier in ArcGIS Online, then improve it through targeted prompting. We will reuse the **existing NOAA datasets** rather than search for or prepare new data.

???+ note-fg-color "Resources"
    [One-Shot Interactive Web Map template :material-file-code-outline:](https://www.promptcartography.com/prompts/){ .md-button .md-button--primary .button_smaller target="_blank" }
    [Prompt Cartography workflow :material-map-marker-path:](https://www.promptcartography.com/workflow/){ .md-button .md-button--primary .button_smaller target="_blank" }
    [NOAA HazEL :material-database:](https://www.ngdc.noaa.gov/hazel/view/about){ .md-button .md-button--primary .button_smaller target="_blank" }
    [WebMapGPT tools :material-tools:](https://www.webmapgpt.com/){ .md-button .md-button--primary .button_smaller target="_blank" }
    {: .button_array style="justify-content:flex-start;"}

## Learning objectives

By the end of this practical, you should be able to:

- turn a cartographic intent into a structured prompt for an interactive map;
- connect a generated web map to **real ArcGIS Online Feature Layers** through their REST URLs;
- evaluate and refine basemap design, symbolisation, legend, and pop-ups;
- make targeted revisions to an existing application without rebuilding everything;
- run the generated `index.html` locally and understand how it can later be published.

???+ note-fg-color "Suggested pace — 3 hours"
    | Activity | Time |
    |---|---:|
    | Critical discussion | 15 min |
    | Cartographic intent and REST data | 30 min |
    | One-shot prompt and first prototype | 50 min |
    | Break | 10 min |
    | Targeted revisions and testing | 50 min |
    | Run locally and reflect | 25 min |

    **Total: 180 minutes.** GitHub Pages and the optional Year filter can be completed later.

---

# Before we start: AI, criticism, and cartographic responsibility

In his EuroCarto 2026 keynote, **Kenneth Field** reflects on how cartography has repeatedly changed through new production technologies, from manual methods to GIS and the web. He places generative AI in this longer history, while acknowledging the professional concerns surrounding it.

Field and Ian Muehlenhaus have been experimenting with AI-generated maps through the ICA Map Design Commission's **#365DaysOfMaps** project. Their work has faced criticism, including accusations of **professional negligence, unethical practice, and “AI slop.”** Field does not argue that AI is harmless or that cartographic expertise is obsolete. His central position is that **AI is not a cartographer** and can cause harm unless it is directed carefully, deliberately, and critically.

???+ note-fg-color "Kenneth Field — keynote and context"
    [Watch the keynote :material-youtube:](https://www.youtube.com/watch?v=-O0eC5cv6vc){ .md-button .md-button--primary .button_smaller target="_blank" }
    [Official keynote abstract :material-text-box-outline:](https://eurocarto2026.org/keynotes/){ .md-button .md-button--primary .button_smaller target="_blank" }
    [#365DaysOfMaps :material-map:](https://mapdesign.icaci.org/){ .md-button .md-button--primary .button_smaller target="_blank" }
    {: .button_array style="justify-content:flex-start;"}

Discuss these concerns before generating the first map:

| Concern | Question for the cartographer |
|---|---|
| **Accuracy and misleading maps** | Who verifies geographic positions, symbols, sources, and claims? |
| **Authorship and creative work** | How should AI assistance, human decisions, and reused work be acknowledged? |
| **Professional expertise** | Which cartographic decisions must remain under human control? |
| **Environmental and social costs** | When is generative AI justified, and when might another tool be more appropriate? |

!!! question "Discussion — five minutes"
    Is a map acceptable merely because an LLM has produced a working, convincing-looking application?

    Identify **one risk** and **one safeguard** that you think should apply to today's work.

The keynote offers a perspective on technological change, **not a resolution of every ethical concern**. Questions about training data, authorship, labour, and environmental impacts remain relevant and deserve independent assessment.

---

# Our task: recreate a familiar web map

We already know what the map should contain, because we designed it earlier in ArcGIS Online.

!!! abstract "Task — Natural Hazard Events web map"
    Create a working **global interactive point map** with three NOAA HazEL event layers:

    - **Earthquake Events** — orange squares;
    - **Tsunami Events** — blue circles;
    - **Volcano Events** — black upward-pointing triangles.

    Your map must include:

    - a **justified, subdued basemap** with helpful geographic context;
    - the **three real NOAA event layers**;
    - a clear **legend** matching the actual map symbols;
    - informative **pop-ups** showing event date, intensity, and reported human impact;
    - basic pan, zoom, and independent layer visibility controls.

    The result should reproduce the **information content**, not necessarily every pixel, of your earlier ArcGIS Online map.

## Think before prompting

Briefly decide and record:

1. **Audience and purpose:** Who is the map for, and what should users learn from it?
2. **Basemap:** Why do muted terrain, hydrography, and country or major-city labels support this topic? What should be omitted?
3. **Visual hierarchy:** Why represent the three hazard types using both **shape and colour**?
4. **Pop-ups:** Which details belong in a pop-up rather than in the map symbols themselves?

???+ question "Cartographic decision"
    Our original map distinguishes **event types**, not event intensity. Therefore, keep symbol size consistent within the three categories. Magnitude, maximum wave height, and VEI belong in the pop-ups, unless you explicitly decide to change the map's purpose.

---

# Use existing ArcGIS Online data

The layers from the earlier practical are already published as **Hosted Feature Layers**. We can reuse them in a new application without downloading the CSV files again.

## Find the ArcGIS REST URL

1. Sign in to **ArcGIS Online**.
2. Open **Content** and select one of your published Hosted Feature Layers (or a suitable public, read-only View).
3. On the item's **Overview** page, find its **URL** / **View service** / **ArcGIS REST Services Directory** link (the exact label may differ).
4. Open the service and identify the **Feature Layer** within it.
5. Copy the **layer REST endpoint**, normally ending in `/FeatureServer/0`. The final number is the layer ID and must be checked rather than assumed.
6. Test the endpoint in your browser by appending `?f=pjson`. Its metadata should include the actual **field names** and types.

**Do not confuse these two URLs:**

```text
ArcGIS Online item page (for people)
https://www.arcgis.com/home/item.html?id=...

ArcGIS REST Feature Layer (for web applications)
https://.../FeatureServer/0
```

### Verified datasets for this practical

| Layer | Public ArcGIS REST endpoint |
|---|---|
| Earthquake Events | [FeatureServer/0](https://services2.arcgis.com/LlQJoYHf9cwrM7NJ/arcgis/rest/services/earthquakes/FeatureServer/0) |
| Tsunami Events | [FeatureServer/0](https://services2.arcgis.com/LlQJoYHf9cwrM7NJ/arcgis/rest/services/tsunamis/FeatureServer/0) |
| Volcano Events | [FeatureServer/0](https://services2.arcgis.com/LlQJoYHf9cwrM7NJ/arcgis/rest/services/eruptions/FeatureServer/0) |

These services are publicly shared. If you use your **own** layers instead, check that they are accessible to the web application without your ArcGIS Online login. Never place credentials or private tokens in client-side code.

## Know your fields

Use the **internal field names** from the REST service metadata, not only their display labels:

| Information | Earthquakes | Tsunamis | Volcanoes |
|---|---|---|---|
| Title / location | `Location_Name` | `Location_Name` | `Name` (fallback: `Location`) |
| Country | *Not available* | `Country` | `Country` |
| Date | `Year`, `Mo`, `Dy` | `Year`, `Mo`, `Dy` | `Year`, `Mo`, `Dy` |
| Intensity | `Mag` | `Maximum_Water_Height__m_` | `VEI` |
| Human impact | `Deaths`, `Missing`, `Injuries` | `Deaths`, `Missing`, `Injuries` | `Deaths`, `Missing`, `Injuries` |

**Pop-up requirements:** Combine location and country in the title **only when both fields exist**. Compose the date from available parts, without inventing a missing month or day. In the **Human Impact** section, display reported deaths, missing persons, and injuries; distinguish `0` from `null`. If all fields are missing, display **“Human impact data unavailable”** instead of asserting that no one was affected.

???+ warning "Avoid a common data error"
    The services also contain some `Total_*` human-impact fields. For this exercise, use **only** `Deaths`, `Missing`, and `Injuries`; do not add these values together or mix them with `Total_Deaths`, `Total_Missing`, or `Total_Injuries`.

    A Feature Service may limit the number of features returned in one request. Our datasets advertise a **2,000-record query limit** and support pagination. The generated application must load the features correctly rather than quietly show only the first 2,000.

???+ note-fg-color "Alternative: start from raw data"
    The [WebMapGPT tool suite](https://www.webmapgpt.com/) offers specialist mapping assistants and data-preparation guidance, including tools such as a **Dataset Cleaner / Dataset Doctor**. These specialist GPT tools are accessed through **ChatGPT**, not as built-in Claude features.

    If you were starting from a new dataset, you could use such a tool to review field types, missing values, coordinates, and inconsistencies. **We do not need this step today**, because the NOAA data are already prepared and published.

---

# First prototype: One-Shot Interactive Web Map

We will begin with the **One-Shot Interactive Web Map** template from Ian Muehlenhaus's Prompt Cartography library.

1. Open [Prompt Cartography — Prompts](https://www.promptcartography.com/prompts/).
2. Find **One-Shot Interactive Web Map**.
3. Copy the template into a text editor or a new Claude chat.
4. Replace its placeholder sections with your **own cartographic decisions** and the REST URLs above.
5. Keep the template's output requirement: **one complete, runnable HTML file** with HTML, CSS, and JavaScript.
6. Submit the prompt in a **new standard chat** and save the first result without editing it yet.

Use this checklist while filling the template:

| Template section | What to specify |
|---|---|
| **My map idea** | Global distribution of three NOAA natural hazard event types |
| **Audience and purpose** | Explain what users should explore or compare |
| **Geographic area** | World; suitable initial extent |
| **Data** | The three real ArcGIS Feature Layer REST URLs and exact field mappings |
| **Mapped variable / Map type** | Event type; categorical point map |
| **Cartographic design** | Muted basemap, three distinct symbol shapes/colours, clear legend |
| **Interaction** | Pan, zoom, pop-ups, and layer on/off controls |
| **Accuracy and uncertainty** | No invented data; missing values handled correctly; clear source note |
| **Output requirements** | Complete `index.html`; explain how to run it |

???+ note-fg-color "One-shot does not mean one attempt forever"
    A **one-shot prompt** asks the LLM to create the **first complete application** from one specification. It is a useful baseline, not the end of the design process.

    Save the first version as **`index_v1.html`** or keep a copy of the original output. Later revisions should not erase the baseline.

## Test your first result

Open the generated app in Claude's preview / Artifact, if available. Check the map as a cartographer, not just as a software user.

- Are all **three actual datasets** loaded?
- Do the **triangle, square, and circle** match the requested categories and legend?
- Is the basemap appropriately subdued, with terrain and meaningful labels but no distracting roads?
- Do the pop-ups show the correct **location, date, intensity, and human-impact values**?
- Are partial dates and missing human-impact data handled correctly?
- Do layer toggles and navigation work?
- Is there a visible **data attribution and uncertainty note**?

If a layer is empty, do not accept an attractive but incomplete map. Investigate whether the cause is an inaccessible service, an incorrect URL, a field-name error, a loading limit, or a runtime problem.

---

# Improve the map through targeted revision prompts

This is the next part of the Prompt Cartography workflow: **generate → critique → revise → test again**. Muehlenhaus's *Make* stage explicitly includes critique and **targeted revision prompts**.

Unlike the comparison exercise in Practical 5, **continue in the same chat**. We now want the LLM to work with the existing app and preserve what already functions.

## Revision prompt

Inspect the current map and identify **two or three specific problems**. Do not ask vaguely to "make it better".

A good revision prompt can be concise:

```text
Please change the following in the existing web map:

1. [Describe a specific cartographic or functional problem and
   the desired result.]
2. [Describe another concrete change.]
3. [Optional: one more change.]

Keep the existing data sources, field mappings, and all working
features unchanged unless the requested changes require otherwise.

Update the existing application, then briefly explain what changed.
```

For example, you might request a more restrained basemap, a more legible legend, better label hierarchy, or clearer human-impact formatting. **Test each change** rather than accumulating many unverified revisions.

???+ note-fg-color "When something breaks"
    Report **what you expected, what actually happened, and how to reproduce it**. Include the exact error message from the browser console if one appears.

    ```text
    Expected: all three event layers are visible.
    Actual: the Tsunami Events layer remains empty.
    Reproduction: load the page, enable Tsunami Events,
    and zoom to Japan.
    Console error: [paste the exact error, if any].

    Please identify the likely cause and propose a focused fix.
    Preserve the parts of the application that already work.
    ```

## Optional extension — filter by year

If your initial map is already working, add a **Year range control** that filters the three event layers using their numeric `Year` attribute.

Before requesting the code, decide how the control should behave: initial range, inclusive limits, missing-year records, reset, and what happens when no events match. Then write a targeted prompt to implement those decisions.

This is **optional today**; we will explore richer interactions and application behaviour in the next practical.

---

# Run the generated web map locally

A web map can run in your browser from a local **`index.html`** file. The HTML is the application; map tiles and event data may still load from **external online services**.

1. Save or export the generated source code as `index.html`.
2. Place it in its own folder.
3. **Double-click** `index.html` to open it in a web browser.
4. If the browser blocks requests or the application behaves differently under `file://`, serve the folder over local HTTP instead.

Open a terminal in that folder and run:

```bash
python -m http.server 8000
```

On some Windows installations you may need:

```bash
py -m http.server 8000
```

Open [http://localhost:8000](http://localhost:8000) in your browser.

???+ note-fg-color "What localhost means"
    `localhost` refers to **your own computer**. This creates a temporary local web server; it does not publish the map to the internet. It also does **not** host the NOAA datasets: those remain on the ArcGIS Feature Services.

    A local HTTP server may solve `file://` restrictions, but it cannot fix incorrect REST URLs, unavailable services, missing permissions, or server-side CORS restrictions.

---

# Optional: publish on GitHub Pages

Once your map works locally, it can be published as a static website. This can also be completed later.

1. Create a new **public GitHub repository**.
2. Upload `index.html` to the root of the `main` branch.
3. Open **Settings → Pages**.
4. Under **Build and deployment**, choose **Deploy from a branch**.
5. Select **`main`** and **`/ (root)`**, then **Save**.
6. Wait for the Pages build and check the website at:

```text
https://YOUR-USERNAME.github.io/YOUR-REPOSITORY/
```

The first deployment or subsequent updates may take several minutes (GitHub advises allowing **up to 10 minutes**). Consult [GitHub Pages documentation](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site) if the site does not appear.

???+ warning "Public web app = public source"
    GitHub Pages is suitable for a static HTML/CSS/JavaScript web map, but it does not run a Python backend. Never commit credentials, private access tokens, or datasets you are not allowed to share. Before publishing, verify the attribution and usage conditions for basemap tiles and other external services.

---

# Final checklist and reflection

!!! abstract "Expected output"
    A working **interactive web map**, produced with LLM assistance, containing:

    - all three genuine NOAA event layers;
    - the requested categorical point symbols;
    - a **justified basemap** and clear visual hierarchy;
    - a correct **legend**;
    - informative **pop-ups** with date, intensity, and human impact;
    - functional navigation and layer visibility controls;
    - visible source attribution and an honest limitations note.

    **Keep:** the original one-shot prompt, a copy or screenshot of **Web Map v1**, the revision prompts, and the latest `index.html`. A public GitHub Pages link is optional at this stage.

## Reflect

Compare the first version with your revised version:

- Which cartographic choices were already satisfactory in the one-shot result?
- Which aspects required **human critique** and a follow-up prompt?
- Did any revision unintentionally break a previously working component?
- Which claims, data values, or interface behaviours did you verify yourself?
- What remains **your responsibility** before sharing the application publicly?

???+ question "Takeaway"
    A working web map is a **prototype**, not automatic proof of cartographic quality.

    **The LLM can implement and revise the design; the cartographer remains responsible for directing, testing, and accepting it.**