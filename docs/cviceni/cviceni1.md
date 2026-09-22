---
icon: material/numeric-1-box
title: Organizace předmětu, příprava dat a publikace do prostředí ArcGIS Online, správa a efektivní použití (Views).
---

# ArcGIS Online: data, maps and applications

## ArcGIS Online

[__ArcGIS Online__](https://www.arcgis.com/){.color_def .underlined_dotted .external_link_icon target="_blank"} is a cloud-based GIS platform for storing, managing, visualising, analysing and sharing geospatial data.

In a typical web GIS workflow, individual components build on each other:

**data → web layer → web map → application**

- **Data** are the source geographic and attribute information.
- A **web layer** makes the geographic data available through ArcGIS Online and can be reused in multiple maps and applications.
- A **web map** combines one or more web layers with their symbology, pop-ups, filters and other map settings.
- A **web application** uses a web map or web layers and adds a user interface and tools designed for a particular purpose.

![](../assets/cviceni1/AGOL_workflow.svg){ .no-filter width=800px}
{align=center}

???+ note-fg-color "Why separate data, maps and applications?"
    One dataset can be reused in several web maps, and one web map can be used in several applications. Changes to a shared data source can therefore propagate to multiple outputs without creating unnecessary copies of the data.

## ArcGIS Online content

Items stored in ArcGIS Online can represent different parts of a web GIS project. During this practical, we will mainly work with:

- **Hosted Feature Layers** – vector data hosted in ArcGIS Online,
- **Hosted Feature Layer Views** – alternative interfaces to an existing Hosted Feature Layer,
- **Web Maps** – map compositions combining layers, symbology and map configuration,
- **Applications** – user-facing interfaces built on top of web maps and web layers.

The aim of this practical is to prepare and publish datasets so that they can be **managed efficiently and reused in subsequent web maps and applications**.

???+ note-fg-color "Browser-based workflow"
    This practical uses a fully browser-based workflow and does not require ArcGIS Pro. ArcGIS Online is, however, a proprietary cloud GIS platform and publishing hosted layers requires an organisational account with appropriate privileges.

## Preparing NOAA event data

We will use three datasets from the [__NOAA Natural Hazards database__](https://www.ngdc.noaa.gov/hazel/view/hazards/){.color_def .underlined_dotted .external_link_icon target="_blank"}:

- **Earthquake Events**
- **Volcano Events**
- **Tsunami Events**

[Earthquake Events :material-earth:](https://www.ngdc.noaa.gov/hazel/view/hazards/earthquake/event-data/){ .md-button .md-button--primary .button_smaller }
[Volcano Events :material-volcano:](https://www.ngdc.noaa.gov/hazel/view/hazards/volcano/event-search/){ .md-button .md-button--primary .button_smaller }
[Tsunami Events :material-waves:](https://www.ngdc.noaa.gov/hazel/view/hazards/tsunami/event-search/){ .md-button .md-button--primary .button_smaller }
{: .button_array style="justify-content:flex-start;"}

Open each search interface, leave the search filters empty, run the search and download the resulting dataset as a tab-separated text file (`.tsv`).

### Import the TSV files into Excel

Do **not** open the downloaded TSV files by double-clicking or drag-and-drop. Instead:

1. Open Excel and select **Data → From Text/CSV**.
2. Select the downloaded `.tsv` file.
3. Check that the delimiter is **Tab** and the encoding is **UTF-8**.
4. Use **Transform Data** and review the detected field types.
5. Remove the first data row containing the export search parameters.
6. Remove the empty `Search Parameters` column.
7. Keep missing values empty – **do not replace them with zeros**.
8. Export the cleaned table as **CSV UTF-8**.

???+ warning "Check automatic data conversion"
    Spreadsheet software may automatically interpret decimal values such as `7.3` as dates. Always import the TSV file using **Data → From Text/CSV** and verify the detected data types before loading the table.

???+ warning "Missing value ≠ zero"
    An empty value means that the information is unknown or unavailable. A value of `0` means that the phenomenon was measured and its value was zero. Replacing missing values with zeros would therefore change the meaning of the data.

Use simple filenames, for example:

```text
Earthquake_Events.csv
Volcano_Events.csv
Tsunami_Events.csv
```

## Publishing data to ArcGIS Online

ArcGIS Online can publish spatial data directly from common file formats without using desktop GIS software. We will publish the three cleaned CSV files as point Hosted Feature Layers using their latitude and longitude attributes.

Sign in to [__ArcGIS Online__](https://www.arcgis.com/){.color_def .underlined_dotted .external_link_icon target="_blank"} using your organisational account.

Create a folder named `Practical_01` in **Content → My content** and publish all three CSV files as separate Hosted Feature Layers.

For each dataset:

1. Click **New item → Your device** and select the corresponding CSV file.
2. Choose **Add file and create a hosted layer or table**.
3. Review the detected fields and their data types.
4. For location information, select **Latitude and longitude**.
5. Check that the appropriate latitude and longitude fields are used.
6. Review numeric fields such as year, magnitude, VEI, casualties and damage.
7. Add an appropriate title and tags.
8. Save the item into the `Practical_01` folder.

Use the following titles:

```text
Earthquake Events
Volcano Events
Tsunami Events
```

???+ note-fg-color "CSV field types"
    CSV files do not store an explicit field schema. ArcGIS Online therefore estimates field types from the data. Always verify the detected types before publishing, especially for sparse numeric attributes containing many empty values.

### What has been created?

After publishing all three datasets, inspect **My content**. For each uploaded CSV, ArcGIS Online creates a source file item and a Hosted Feature Layer.

Open the Hosted Feature Layer item and inspect:

- **Overview** – item description, tags, credits and sharing,
- **Data** – attribute table and fields,
- **Visualization** – default representation,
- **Settings** – editing, export and other layer capabilities.

## Hosted Feature Layer Views

A **Hosted Feature Layer View** provides a separate interface to an existing Hosted Feature Layer without creating another copy of the data. Views can expose only selected features or fields and can have their own sharing and editing settings.

???+ note-fg-color "Example: Why use a Hosted Feature Layer View?"
    Imagine that a municipality maintains one authoritative layer of public trees.

    The **source Hosted Feature Layer** contains the complete dataset and is editable by municipal staff. Editing can be controlled both for the whole layer and for individual fields.

    A botanist, however, only needs to update the attribute `tree_health`. Instead of giving access to the complete source layer, the municipality creates a separate **Hosted Feature Layer View**:

    - only `ID` and `tree_health` are exposed,
    - `ID` is read-only,
    - `tree_health` is editable,
    - geometry editing is disabled,
    - the view is shared only with the botanist or a dedicated user group.

    The source layer remains the authoritative dataset, while the botanist edits the same underlying records through a restricted interface.

    Another read-only view can be created for the public, containing only selected non-sensitive attributes.

    **Per-field editing can be configured on both the source Hosted Feature Layer and its Views. Views become especially useful when different user groups need different access to fields, features or editing capabilities.**

    In other words: **one authoritative dataset, multiple controlled interfaces.**

### Create an application view

Create a View from `Earthquake Events` and name it:

```text
Earthquake Events – App
```

Configure the View as a **read-only application interface**. Preserve qualitative and quantitative attributes that may later be useful for:

- map symbology,
- filtering,
- pop-ups,
- grouping,
- indicators,
- charts and dashboards.

Exclude only fields that are clearly technical, redundant or irrelevant for later visualisation and analysis.

???+ note-fg-color "View vs. map filter"
    A filter in a Web Map controls what is shown in that particular map. A View controls how the underlying data are exposed and shared. Use Views when different applications or user groups need different access to the same authoritative dataset.

### Create views for the remaining datasets

Repeat the workflow for the other two source layers and create:

```text
Volcano Events – App
Tsunami Events – App
```

Both Views should:

- remain **read-only**,
- preserve attributes useful for later analysis,
- omit only clearly unnecessary technical fields,
- be stored in the `Practical_01` folder.

!!! question "Check the result"
    Your ArcGIS Online content should now contain three source Hosted Feature Layers and three corresponding application Views. Why might it be preferable to connect future public applications to the Views rather than directly to the source layers?
