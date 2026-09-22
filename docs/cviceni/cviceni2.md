---
icon: material/numeric-2-box
title: Vector Tile Style Editor. Tvorba webové basemapy.
---
# From basemap to web application and story

In this practical, we will continue working with the three NOAA event datasets prepared in the previous session. The goal is to build a complete browser-based cartographic workflow:

**custom basemap → Web Map → Instant App → StoryMap**

The same data will later be reused in Experience Builder and ArcGIS Dashboards.

## Input data

Use the three application Views created in Practical 1:

```text
Earthquake Events – App
Volcano Events – App
Tsunami Events – App
```

## ArcGIS Vector Tile Style Editor

A **basemap** provides geographic context for thematic information. In web cartography, the basemap should support the thematic layers rather than compete with them visually.

ArcGIS Vector Tile Style Editor (VTSE) allows you to create a custom style based on an existing vector basemap. The underlying vector tiles remain the same, while colours, labels and other visual properties can be customised.

[Vector Tile Style Editor :material-palette:](https://vtse.arcgis.com/){ .md-button .md-button--primary .button_smaller }
{: .button_array style="justify-content:flex-start;"}

### Create a custom basemap

Create a custom vector basemap suitable for displaying global natural-hazard events.

Your basemap should:

- provide sufficient geographic context at global and regional scales,
- remain visually subordinate to the thematic event layers,
- use restrained colours,
- keep labels readable but unobtrusive,
- avoid unnecessary visual detail,
- maintain sufficient contrast with all three event layers.

Use **Quick Edit** for broad visual changes and the detailed layer editor when individual feature classes or labels need further refinement.

Save the resulting style to your ArcGIS Online content.

???+ question "Cartographic decision"
    Which basemap elements are essential for interpreting the spatial distribution of natural hazards, and which can be visually suppressed or removed?

## Create a Web Map

Open **Map Viewer** and create a new map containing:

- your custom VTSE basemap,
- `Earthquake Events – App`,
- `Volcano Events – App`,
- `Tsunami Events – App`.

### Configure the thematic layers

Design the three event layers so that they are clearly distinguishable but visually coherent.

Consider using quantitative attributes where appropriate, for example:

- earthquake magnitude,
- volcanic explosivity index (`VEI`),
- a quantitative tsunami attribute such as intensity or maximum run-up.

Configure meaningful **pop-ups** for all three layers. Show only useful attributes and use understandable aliases and number formatting.

???+ note-fg-color "Map before app"
    Configure symbology, pop-ups and the initial map extent in the **Web Map** rather than treating the application builder as the primary place for cartographic design. The Web Map will be reused by multiple applications.

Save the map as:

```text
NOAA Natural Hazard Events
```

## Create an Instant App

We will use an **ArcGIS Instant Apps – Slider** application to explore how the three types of events are distributed through time.

[ArcGIS Instant Apps :material-application:](https://www.arcgis.com/apps/instantgallery/index.html){ .md-button .md-button--primary .button_smaller }
[Slider documentation :material-tune-variant:](https://doc.arcgis.com/en/instant-apps/latest/create-apps/slider.htm){ .md-button .md-button--primary .button_smaller }
{: .button_array style="justify-content:flex-start;"}

### Configure the Slider app

1. Open the `NOAA Natural Hazard Events` Web Map.
2. Create an application using **Instant Apps**.
3. Select the **Slider** template.
4. Configure a **numeric slider** using the numeric year attribute.
5. Apply the slider to all three event layers.
6. Configure the slider so that users can interactively explore changes in the distribution of events through time.
7. Enable only interface elements that support the purpose of the application, such as the legend, layer list or pop-ups.
8. Review the title, description and sharing settings.
9. Publish the application.

Use a title such as:

```text
Natural Hazard Events Through Time
```

???+ note-fg-color "Numeric slider vs. time slider"
    The Slider template can animate data using a **numeric field in one or more layers**. Using the numeric year attribute avoids the need to construct complete date values for historical records where month or day may be unknown.

## Create a StoryMap

The Instant App provides an **exploratory view** of the full dataset. We will now complement it with a **curated narrative** highlighting selected major events.

[ArcGIS StoryMaps :material-book-open-page-variant:](https://storymaps.arcgis.com/){ .md-button .md-button--primary .button_smaller }
{: .button_array style="justify-content:flex-start;"}

Create a StoryMap that combines a short narrative with selected event locations and the interactive Instant App.

### Map Tours

Prepare three short Map Tours:

- **Top 5 Earthquake Events**
- **Top 5 Tsunami Events**
- **Top 5 Volcano Events**

For each category:

1. Choose a meaningful quantitative criterion for selecting the five events.
2. State the criterion clearly in the StoryMap.
3. For each event, include:
   - event name or location,
   - year,
   - the quantitative value used for ranking,
   - a short explanatory text,
   - an appropriate image where available.

???+ question "What does Top 5 mean?"
    A ranking is meaningful only when the criterion is explicit. The most powerful earthquake, the deadliest earthquake and the most damaging earthquake are not necessarily the same event. Choose a criterion that can be justified from the available attributes.

### Embed the Instant App

Below the curated Map Tours, add a short transition explaining that the selected events represent only a small part of the complete dataset.

Embed the published **Natural Hazard Events Through Time** Instant App so that readers can explore the full data interactively.

???+ note-fg-color "Narrative + exploration"
    The StoryMap and Instant App serve different purposes. The Map Tours provide a **curated narrative**, while the embedded Instant App provides an **exploratory interface** to the complete dataset.

## Output

At the end of the practical, you should have the following ArcGIS Online items:

1. a custom **vector basemap style** created in VTSE,
2. a **Web Map** containing the three NOAA event layers,
3. a **Slider Instant App** filtering the three event layers by year,
4. a **StoryMap** containing three Top 5 Map Tours and the embedded Instant App.

!!! abstract "Final workflow"
    **NOAA application Views → custom VTSE basemap → Web Map → Slider Instant App → StoryMap**

    The same Web Map and data will be reused in the next practical when creating an **Experience Builder application** and an **ArcGIS Dashboard**.
