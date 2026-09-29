---
icon: material/numeric-3-box
title: Rekapitulace ESRI builderů, jejich porovnání, zaměření na Experience builder a tvorba mapové aplikace.
---

# Advanced pop-ups and application builders

In this practical, we will continue working with the NOAA natural hazard data and the Web Map created in the previous sessions.

Before building applications in **ArcGIS Experience Builder** and **ArcGIS Dashboards**, we will:

- compare the main ArcGIS app-building options,
- improve the information design of our Web Map using advanced pop-ups,
- use **HTML** and **Arcade** to create more meaningful and dynamic pop-up content.

## ArcGIS app-building options

ArcGIS offers several ways to turn maps and data into web applications. The appropriate tool depends on the purpose of the application, the required level of customisation, and whether coding is needed.

The table below is ordered approximately from **no-code** to **high-code**. The order within the no-code group is not a strict ranking; each builder is designed for a different type of application.

| Tool | Coding level | Best suited for | Typical strengths | Main limitation |
| --- | --- | --- | --- | --- |
| **ArcGIS Instant Apps** | **No-code** | Focused, purpose-driven map applications | Very fast deployment, predefined templates, simple configuration | Layout and functionality are largely defined by the selected template |
| **ArcGIS StoryMaps** | **No-code** | Narrative cartography and scrollytelling | Maps, text, media, map tours and immersive storytelling | Not intended as a general-purpose analytical application |
| **ArcGIS Dashboards** | **No-code** | Monitoring, overview and analytical summaries | Maps, indicators, charts, lists and selectors coordinated on one screen | Less flexible page layout than Experience Builder |
| **ArcGIS Experience Builder** | **No-code → low-code** | Flexible, responsive web applications | Custom layouts, pages, widgets, data sources, messages and actions | More configuration and design decisions are required |
| **ArcGIS Maps SDK for JavaScript** | **High-code** | Fully custom web mapping applications | Maximum control over maps, interface, interactions and application logic | Requires JavaScript development |

???+ note-fg-color "Builder or SDK?"
    **Instant Apps, StoryMaps, Dashboards and Experience Builder** are configurable app builders and can all be used without writing code.

    **ArcGIS Maps SDK for JavaScript** is not a builder. It is a development SDK for creating custom web applications in JavaScript.

    Experience Builder sits between both worlds: the standard builder is no-code, while **Experience Builder Developer Edition** can be extended with custom widgets, themes and actions.

???+ note-fg-color "Choosing the right tool"
    A useful first question is not *Which builder is the most powerful?*, but **What should the user be able to do?**

    - communicate a spatial story → **StoryMaps**
    - quickly expose one focused map workflow → **Instant Apps**
    - monitor and compare indicators → **Dashboards**
    - combine several maps, widgets and workflows in a custom interface → **Experience Builder**
    - build functionality that the builders cannot provide → **ArcGIS Maps SDK for JavaScript**

## Advanced pop-ups

A pop-up is part of the **information design of a map**, not merely a table of attributes. A well-designed pop-up should select, structure and format information so that the user can understand the selected feature quickly.

Compare a default attribute list with a configured pop-up:

![](https://www.esri.com/arcgis-blog/app/uploads/2024/03/pute-2.png){ width=900px}
{align=center}

*Example from Esri ArcGIS Blog: a default pop-up compared with a configured information display.*

The general workflow follows the same logic as the Esri tutorial:

1. configure fields,
2. create a meaningful title,
3. organise pop-up content,
4. add charts or formatted text,
5. use **HTML** for greater control over layout,
6. use **Arcade** when the information must be calculated, reformatted or displayed conditionally.

???+ note-fg-color "Resources"
    [Pop-ups: the essentials :material-open-in-new:](https://www.esri.com/arcgis-blog/products/arcgis-online/mapping/configure-pop-ups-basics){ .md-button .md-button--primary .button_smaller target="_blank" }
    [Pop-ups: Arcade essentials :material-open-in-new:](https://www.esri.com/arcgis-blog/products/arcgis-online/mapping/pop-ups-arcade-essentials){ .md-button .md-button--primary .button_smaller target="_blank" }
    [Arcade – Popup profile :material-code-braces:](https://developers.arcgis.com/arcade/profiles/popup/){ .md-button .md-button--primary .button_smaller target="_blank" }
    {: .button_array style="justify-content:flex-start;"}

### Configure fields

You already know how to enable pop-ups and display a field list. Before adding more advanced content, review the fields in each event layer and improve their presentation:

- hide fields that are unnecessary for the user, such as coordinates if they provide no additional information,
- use readable **display names / aliases**,
- set appropriate number formatting,
- order the fields logically rather than following the source-table order.

For the NOAA datasets, for example:

- earthquake magnitude → **1 decimal place**,
- tsunami maximum water height → **1 decimal place**,
- VEI → **0 decimal places**,
- deaths, missing persons and injuries → **0 decimal places** with thousands separators where appropriate.

???+ warning "A chart needs numeric fields"
    Pop-up charts can only use numeric attributes. If a field such as `Deaths`, `Missing` or `Injuries` was imported as text, correct the data schema before using it in charts or analytical applications.

### Create a meaningful pop-up title

The title should identify the feature immediately. It can combine static text and one or more fields.

For **Tsunami Events**, build a title from:

**Location Name + Maximum Water Height + `m`**

For example:

> **TOHOKU, JAPAN — 38.9 m**

Use the **Fields** selector in the title editor rather than typing field tokens manually.

???+ note-fg-color "Think about missing values"
    A simple title works well when all required attributes are available. But what happens when `Maximum Water Height (m)` is empty?

    Later we will use **Arcade** to display the height only when a value exists.

### Organise pop-up content

A pop-up can contain several independent content elements. The most useful for our datasets are:

- **Fields list** – selected attributes in a structured table,
- **Text** – a combination of static text and field values,
- **Chart** – a graphical comparison of numeric fields,
- **Arcade** – dynamically generated content.

For `Tsunami Events`, add a **bar chart** called **Human impact** using:

- `Deaths`
- `Missing`
- `Injuries`

This is more informative than listing the three values separately because they represent comparable quantities measured in persons.

???+ note-fg-color "Use charts selectively"
    A pop-up chart should compare values that are meaningful together. Avoid combining attributes only because they are numeric. For example, earthquake magnitude, number of deaths and financial damage use different units and should not be shown as if they formed a single comparable scale.

## HTML in pop-ups

The **Text** content element includes an HTML source editor. HTML can be used to structure information more precisely than the default field list.

For example, create a compact summary table for `Tsunami Events`:

```html
<table style="width:100%; border-collapse:collapse;">
  <tr>
    <td><strong>Year</strong></td>
    <td>{Year}</td>
  </tr>
  <tr>
    <td><strong>Country</strong></td>
    <td>{Country}</td>
  </tr>
  <tr>
    <td><strong>Deaths</strong></td>
    <td>{Deaths}</td>
  </tr>
  <tr>
    <td><strong>Missing</strong></td>
    <td>{Missing}</td>
  </tr>
  <tr>
    <td><strong>Injuries</strong></td>
    <td>{Injuries}</td>
  </tr>
</table>
```

To add attributes whose original names contain spaces or special characters, use the **Fields** tool in the editor. ArcGIS will insert the correct internal field token.

HTML is useful for:

- organising attributes into tables,
- adding visual hierarchy,
- emphasising important values,
- combining explanatory text and attributes,
- adding links and other supported web content.

???+ warning "Do not overdesign the pop-up"
    HTML gives more control, but the goal is still information hierarchy and readability. A pop-up should remain compact and usable on smaller screens.

## Arcade in pop-ups

[__Arcade__](https://developers.arcgis.com/arcade/){.color_def .underlined_dotted .external_link_icon target="_blank"} is an expression language used across ArcGIS. In pop-ups it is especially useful when a value needs to be **calculated, reformatted, interpreted or displayed conditionally** without modifying the source data.

Arcade can be used in two main ways:

1. **Attribute expression** – returns a text or numeric value that can be used like another field.
2. **Arcade content element** – returns an entire formatted pop-up block.

### Arcade attribute expression: format an incomplete event date

The NOAA datasets store `Year`, `Mo` and `Dy` in separate fields, and month or day may be missing. Instead of displaying three separate values, create one human-readable date.

Open **Pop-ups → Attribute expressions → Add expression** and enter:

```arcade
var y = $feature.Year;
var m = $feature.Mo;
var d = $feature.Dy;

if (IsEmpty(m)) {
    return Text(y);
}

if (IsEmpty(d)) {
    return Text(y) + "-" + Text(m, "00");
}

return Text(y) + "-" + Text(m, "00") + "-" + Text(d, "00");
```

Depending on the available attributes, the expression can return:

```text
2011-03-11
1755-11
-1610
```

Give the expression a meaningful name such as:

```text
Event date
```

The expression can then be inserted into a Text element like a normal field.

### Arcade attribute expression: improve the tsunami title

We can now improve the earlier tsunami title so that the water height is shown only when it is available.

Use the exact field names suggested by the Arcade editor for your layer:

```arcade
var place = $feature.Location_Name;
var height = $feature.Maximum_Water_Height_m;

if (IsEmpty(height)) {
    return place;
}

return place + " — " + Text(height, "0.0") + " m";
```

???+ note-fg-color "Field names in Arcade"
    The internal field names in your Hosted Feature Layer may differ from the display aliases shown in the map.

    Use **Profile variables → `$feature`** or the editor autocomplete to insert the correct field names instead of guessing them.

The resulting expression can be used as a dynamic title or inside another text element.

## Arcade content element

An Arcade **content element** can generate a complete block of pop-up content. This is useful when the structure itself should change according to the available data.

For example, create a **Human impact** element that displays only casualty attributes for which NOAA contains a value:

```arcade
var items = [];

if (!IsEmpty($feature.Deaths)) {
    Push(items, "<strong>Deaths:</strong> " + Text($feature.Deaths, "#,###"));
}

if (!IsEmpty($feature.Missing)) {
    Push(items, "<strong>Missing:</strong> " + Text($feature.Missing, "#,###"));
}

if (!IsEmpty($feature.Injuries)) {
    Push(items, "<strong>Injuries:</strong> " + Text($feature.Injuries, "#,###"));
}

var content = "";

if (Count(items) == 0) {
    content = "No casualty values are reported for this event in the database.";
} else {
    content = Concatenate(items, "<br>");
}

return {
    type: "text",
    text: "<div><strong>Human impact</strong><br>" + content + "</div>"
};
```

This differs from simply replacing null values with zero. The expression preserves the distinction between:

- **0** – a reported value of zero,
- **null / empty** – no value is available in the database.

???+ note-fg-color "Attribute expression vs. Arcade element"
    Use an **attribute expression** when you need one calculated value that can be inserted elsewhere in the pop-up.

    Use an **Arcade content element** when you want Arcade to generate an entire section of the pop-up, including conditional content and HTML formatting.

## Pop-ups in applications

Pop-up configurations saved with a Web Map are reused by ArcGIS applications such as Instant Apps, StoryMaps, Dashboards and Experience Builder.

The essential configuration usually persists, but individual applications may render pop-up content slightly differently. Always test the final pop-up in the application for which the Web Map is intended.

!!! abstract "Pop-up task"
    Improve the pop-ups of the three NOAA event layers in your Web Map.

    Your final map should demonstrate:

    - meaningful titles,
    - carefully selected and formatted fields,
    - at least one pop-up chart,
    - at least one HTML-formatted Text element,
    - at least one Arcade attribute expression,
    - at least one Arcade content element.

    You do not need to configure all three layers identically. Choose the pop-up design according to the attributes and purpose of each dataset.
