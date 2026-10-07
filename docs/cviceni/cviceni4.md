---
icon: material/numeric-4-box
title: Experience builder
---
# ArcGIS Experience Builder

In this practical, we will use the same NOAA natural hazard data and Web Map from the previous sessions to create a more flexible **map exploration application** in ArcGIS Experience Builder.

Unlike the previous applications, the main purpose will not be to summarise the data or explore them only through time. The application will allow users to **filter, query, select and inspect individual events**.

We will start from a blank layout and gradually connect individual widgets through shared data sources and actions.

## Create a blank experience

1. Open **ArcGIS Experience Builder** and make sure you are working in **Full mode**.
2. Click **Create new**.
3. Select **Blank fullscreen**.
4. Name the experience:

```text
Natural Hazard Explorer
```

5. Save the experience.

???+ note-fg-color "Why Blank fullscreen?"
    We start with a blank fullscreen template because Experience Builder is not only about configuring widgets. It also allows us to design the application layout and define how individual widgets communicate with each other.

    The result of this practical will be a map-centred working application rather than a scrolling page.

## Add the Map widget

1. Open the **Insert widget** panel.
2. Drag the **Map** widget onto the canvas.
3. Resize it so that it fills the entire page.
4. In the Map widget settings, click **Select map**.
5. Choose the Web Map created in the previous practical.

The Web Map should contain:

- `Earthquake Events`,
- `Tsunami Events`,
- `Volcano Events`,
- your custom VTSE basemap.

### Configure the initial map

Keep the initial view inherited from the Web Map and enable only a small set of useful map tools:

- **Zoom**
- **Home**
- **Search**
- **Layers**
- **Scale bar**
- optionally **Fullscreen**

Keep **Enable pop-up** turned on for now so that the pop-ups configured in the previous practical remain available.

???+ note-fg-color "Pop-ups and Feature Info"
    Later in the practical, we will add a **Feature Info** widget. At that point, the selected feature can be displayed permanently in a side panel and the standard map pop-up can optionally be disabled.

### Test the map

Open **Live view** or Preview and verify that:

- all three event layers are visible,
- the custom basemap loads correctly,
- layer visibility can be changed,
- pop-ups work,
- **Home** returns to the expected initial extent.

At this stage, the application should still be intentionally simple:

```text
┌───────────────────────────────────────────────┐
│                                               │
│                                               │
│                    MAP                        │
│                                               │
│                                               │
└───────────────────────────────────────────────┘
```

## Filter widget

The **Filter** widget limits the features visible in a data source according to one or more attribute expressions. Because the filter changes the shared data source, other widgets using the same layer are filtered as well.

We will first create a **cascading filter** for tsunami events.

### Add the Filter widget

1. Add the **Filter** widget to the application.
2. Place it as a narrow panel on the left side of the map.
3. Click **New filter**.
4. Use:

```text
Web Map → Tsunami Events
```

as the data source.
5. Name the filter:

```text
Find tsunami events
```

### Create a cascading filter

Create the first clause:

```text
Country is [value]
```

Configure the value as:

- **Source type:** Unique
- **Ask for values:** On
- **Input style:** Dropdown
- **Label:** `Country`

Add a second clause and connect it to the first one with **AND**:

```text
Location Name is [value]
```

Configure:

- **Source type:** Unique
- **Ask for values:** On
- **Label:** `Location`
- **Values list:** Filter values based on previous expressions

The second list now depends on the first selection:

```text
Country
   ↓
Location Name
```

For example, after selecting `JAPAN`, the Location list contains only locations that occur in Japanese tsunami records.

Add a third clause:

```text
Maximum Water Height (m) is at least [value]
```

Configure:

- **Ask for values:** On
- **Label:** `Minimum wave height (m)`

The resulting filter is:

```text
Country = user selection
    AND
Location Name = user selection
    AND
Maximum Water Height >= user input
```

### Add filter controls

Under **Advanced tools**, enable:

- **Reset all filters**

This allows users to quickly restore the original map state.

### Pan the map to filtered features

Open the **Action** tab of the Filter widget and configure:

```text
Data filtering changes
        ↓
Map → Pan to
```

Using **Pan to** preserves the user's current map scale and only moves the map towards the filtered features.

???+ note-fg-color "Pan to vs. Zoom to"
    `Zoom to` changes both the map position and scale so that the filtered features fit into the view.

    `Pan to` keeps the current scale and only changes the map position. For an exploratory application, this can provide a more stable user experience.

### Test the filter

Open Live view and try, for example:

```text
Country → JAPAN
Location → select one of the available locations
Minimum wave height → 5
```

The map should show only tsunami events that satisfy all active expressions and pan towards the resulting features.

## Group filter across multiple event layers

A **Group Filter** applies the same user-defined value to compatible fields in several data sources. This is useful when different layers share attributes with the same meaning.

The three NOAA event layers all contain the numeric attributes:

- `Deaths`
- `Missing`
- `Injuries`

We will use them to create one common **Human impact threshold**.

### Create the Group Filter

1. In the existing Filter widget, open the menu next to **New filter**.
2. Choose **New group**.
3. Add all three data sources:

   - `Earthquake Events`
   - `Tsunami Events`
   - `Volcano Events`

4. Name the group:

```text
Human impact threshold
```

5. Choose a numeric field such as `Deaths` as the **Main field**.
6. Under **All fields**, add the following fields from each connected layer:

```text
Deaths
Missing
Injuries
```

All fields in a Group Filter must use the same field type as the Main field.

### Use OR logic within each layer

For each event layer, connect the three fields with **OR**:

```text
Deaths
   OR
Missing
   OR
Injuries
```

Set the operator to:

```text
is at least
```

Enable **Ask for values** and use a label such as:

```text
Minimum reported impact
```

For example, entering:

```text
100
```

returns events for which at least one of the three attributes is 100 or greater:

```text
Deaths >= 100
OR
Missing >= 100
OR
Injuries >= 100
```

The same input value is applied simultaneously to the corresponding fields in all three event layers.

???+ note-fg-color "Why OR?"
    `Missing` and some other casualty attributes are sparsely populated in the NOAA datasets.

    Using **AND** would require an event to meet the threshold in all three fields at the same time. Using **OR** returns an event when at least one reported human-impact measure reaches the selected threshold.

    An empty value does not behave like zero; it simply does not satisfy the numeric condition.

### Pan to the filtered results

Use the same interaction as for the previous filter:

```text
Data filtering changes
        ↓
Map → Pan to
```

The map keeps the user's current scale while moving towards the filtered features.

### Test the Group Filter

Try several threshold values, for example:

```text
100
1000
10000
```

Observe how the same user input filters **Earthquake Events, Tsunami Events and Volcano Events simultaneously**.


## Query widget

The **Query** widget retrieves records that satisfy one or more attribute or spatial conditions.

Unlike the Filter widget, Query creates a **separate output data source** containing the query results. This result set can then be used by other widgets such as Map, List or Table.

### Attribute query: strong earthquakes

1. Add the **Query** widget to the application.
2. Place it in the left panel below the Filter widget.
3. Click **New query**.
4. Use:

```text
Web Map → Earthquake Events
```

as the data source.
5. Name the query:

```text
Strong earthquakes
```

### Configure the attribute filter

Create two expressions connected with **AND**:

```text
Mag is at least [user value]
AND
Year is at least [user value]
```

Enable **Ask for values** for both expressions and use labels such as:

```text
Minimum magnitude
From year
```

For example:

```text
Magnitude ≥ 7
Year ≥ 2000
```

returns strong earthquakes recorded from the selected year onwards.

### Configure the results

Under **Results**, configure the result card so that each record is easy to identify.

For example, use:

- `Location Name` as the heading,
- `Year`,
- `Country`,
- `Mag`,
- optionally `Focal Depth (km)` and `Deaths`.

Use:

```text
Select mode → Single
```

### Show query results on the map

Open the **Action** tab and configure:

```text
Records created
      ↓
Map → Show on map
```

When the query runs, the returned records are displayed as a separate result set in the map.

This demonstrates an important difference between Query and Filter:

```text
Filter → modifies the current view of an existing data source
Query  → creates a new output data source containing the results
```

### Pan to the selected result

Add another action:

```text
Record selection changes
      ↓
Map → Pan to
```

Selecting an earthquake in the Query results moves the map towards that event while preserving the current map scale.

### Test the query

Try:

```text
Minimum magnitude → 7
From year → 2000
```

Verify that:

- a result list is created,
- the returned features appear in the map,
- selecting one record pans the map towards it.

### Spatial query: eruptions in a selected area

Create a second query using the volcanic eruption layer.

1. In the Query widget, click **New query**.
2. Use:

```text
Web Map → Volcano Events
```

as the data source.
3. Name the query:

```text
Eruptions
```

This query will combine a **spatial filter** with an **attribute filter**.

### Configure the spatial filter

Enable **Spatial filter** and allow the user to define the query area interactively in the map.

Use drawing tools such as:

- **Rectangle**
- **Polygon**

Use the spatial relationship:

```text
Intersects
```

The query will return eruption events located inside the geometry drawn by the user.

### Add the VEI attribute filter

Add an attribute expression:

```text
VEI is [user value]
```

Configure the value as:

- **Source type:** Unique
- **Ask for values:** On
- **Input style:** Dropdown
- **Label:** `VEI`

The complete query therefore combines two conditions:

```text
Selected spatial area
        AND
VEI = selected value
```

For example:

> Find all eruption events with **VEI 5** inside a polygon drawn around Southeast Asia.

### Configure the results

Use a result card that includes useful eruption attributes, for example:

- event or volcano name,
- `Country`,
- `Year`,
- `VEI`,
- `Deaths`,
- optionally elevation or volcano type.

Use:

```text
Select mode → Multiple
```

because the purpose of the query is to explore a set of eruption events within the selected area.

### Show results on the map

Configure:

```text
Records created
      ↓
Map → Show on map
```

and:

```text
Record selection changes
      ↓
Map → Pan to
```

The query results become a separate output data source and are displayed in the map.

???+ note-fg-color "Four filtering workflows"
    At this point, the application demonstrates four different ways of limiting or retrieving data:

    **Tsunami Filter**
    : Cascading attribute filter using `Country`, `Location Name` and `Maximum Water Height`.

    **Human Impact Threshold**
    : Group Filter applied simultaneously to `Deaths`, `Missing` and `Injuries` across all three event layers.

    **Earthquakes Query**
    : Attribute query combining `Year` and `Magnitude`.

    **Eruptions Query**
    : Spatial query combined with a categorical `VEI` filter.

## Near Me widget

The **Near Me** widget performs distance-based spatial analysis around a location selected by the user.

In this application, the user will click anywhere in the map, define a search distance and find nearby:

- earthquake events,
- tsunami events,
- volcanic eruption events.

This introduces a different type of interaction than the previous filters and queries: instead of filtering by attributes or a manually drawn polygon, the application performs a **proximity analysis around a selected location**.

### Add the Near Me widget

1. Add the **Near Me** widget to the application.
2. Connect it to the existing **Map** widget.
3. Use:

```text
Search method → Specify a location
```

4. Allow the user to define the location using a **Point**.
5. Set a default search distance such as:

```text
500 km
```

6. Enable **Distance settings** so that the search radius can be changed interactively.

The basic workflow is:

```text
click location
      ↓
search distance
      ↓
find nearby events
```

### Configure analysis layers

If the widget displays:

```text
Analysis is not configured for features in this map.
```

no analysis has yet been assigned to the map layers.

Open the **Analysis** section and add three analyses.

### Earthquake Events

Configure:

- **Layer:** `Earthquake Events`
- **Analysis type:** `Proximity`
- **Label:** `Earthquakes`
- **Display field:** a suitable event or location name

### Tsunami Events

Configure:

- **Layer:** `Tsunami Events`
- **Analysis type:** `Proximity`
- **Label:** `Tsunamis`
- **Display field:** `Location Name`

### Volcano Events

Configure:

- **Layer:** `Volcano Events`
- **Analysis type:** `Proximity`
- **Label:** `Eruptions`
- **Display field:** a suitable volcano or event name

The Near Me configuration should now follow this logic:

```text
Near Me
│
├── Earthquakes → Proximity
├── Tsunamis    → Proximity
└── Eruptions   → Proximity
```

Each Proximity analysis returns all features located within the selected distance.

### Configure the results

In the Results settings, enable useful result information such as:

- analysis icons,
- map symbols,
- approximate distance.

You can also enable:

```text
Filter layers to only show results
```

so that the map temporarily displays only the events returned by the Near Me analysis.

### Test the analysis

Try several locations and search distances, for example:

```text
Japan → 500 km
Indonesia → 500 km
Iceland → 300 km
Southern Italy → 300 km
West Coast of North America → 1000 km
```

Compare how the number and combination of event types changes between locations.

### Add a Summary analysis

Near Me can also **summarise numeric attributes** of the features found within the search area. This is more than a list of nearby events: it creates a small spatially defined statistical overview.

Add another analysis:

- **Layer:** `Earthquake Events`
- **Analysis type:** `Summary`
- **Label:** `Earthquake summary`

Under **Add Summary**, configure several statistics, for example:

```text
COUNT → number of earthquake events
AVERAGE → Mag
MAX → Mag
SUM → Deaths
```

The result answers questions such as:

> How many earthquake events are recorded within 500 km of this location?

> What is their average and maximum magnitude?

> What is the total reported number of deaths?

The Near Me workflow can therefore combine detailed and aggregated results:

```text
Selected location + search distance
              │
              ├── Proximity → individual nearby events
              └── Summary   → statistics for nearby events
```

???+ note-fg-color "Summary statistics"
    Summary analysis can calculate `COUNT`, `SUM`, `AVERAGE`, `MIN` and `MAX` over numeric fields.

    Missing values remain missing and should not be interpreted as zero. For example, `SUM(Deaths)` summarises the reported numeric values available in the selected result set.

???+ note-fg-color "Near Me output"
    Near Me creates output data sources for the analysis results.

    These result sets can later be connected to other widgets, such as a Table, if a more detailed workflow is needed.

## Add Data widget

Experience Builder can also be extended with the **Add Data** widget. It allows users to add additional contextual datasets to the running application, for example from ArcGIS content, a URL or a supported local file.

This can turn a predefined application into a more flexible **working web GIS client**, because users can temporarily combine the prepared NOAA event layers with other contextual data.

For this practical, the widget is optional and does not need to be configured in detail.

???+ note-fg-color "Possible extension"
    Try adding a contextual layer such as tectonic plate boundaries, administrative boundaries or another publicly available dataset and compare it with the natural hazard events.

## What have we built?

The final Experience Builder application demonstrates several different ways of interacting with the same spatial data:

```text
Web Map
   │
   ├── Filter
   │     └── cascading tsunami filter
   │
   ├── Group Filter
   │     └── human impact threshold across all event layers
   │
   ├── Query
   │     ├── attribute query → earthquakes
   │     └── spatial + attribute query → eruptions
   │
   └── Near Me
         ├── Proximity → nearby events
         └── Summary → statistics for nearby earthquakes
```

The important distinction is that the widgets do not all solve the same problem:

- **Filter** changes the currently available features in an existing data source.
- **Group Filter** applies one user-defined condition across several compatible layers.
- **Query** creates a separate result set based on attribute or spatial conditions.
- **Near Me** performs distance-based spatial analysis around a selected location.
- **Add Data** can extend the application with additional contextual datasets.

!!! abstract "Final application"
    Your **Natural Hazard Explorer** should contain:

    - the NOAA Web Map with the custom VTSE basemap,
    - a cascading tsunami Filter,
    - a Human Impact Group Filter across all three event layers,
    - an earthquake attribute Query,
    - an eruption spatial + VEI Query,
    - a Near Me proximity analysis for all three event types,
    - an earthquake Summary analysis in Near Me.

    Test the application in Live view and verify that the individual widgets interact with the map and data as expected.