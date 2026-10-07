---
icon: material/numeric-5-box
title: Úvod do prompt cartography. Markdown, strukturování promptů, experiment.
---

In this practical, we will explore **prompt cartography** as a structured way of directing map design through natural language.

The aim is not simply to ask an AI system to *make a map*. Instead, we will compare casual prompting with a more deliberate, iterative workflow in which the cartographer explicitly defines purpose, audience, constraints, critique and revision.

???+ note-fg-color "Resources"
    [Prompt Cartography :material-book-open-page-variant:](https://www.taylorfrancis.com/books/mono/10.1201/9781003797920/prompt-cartography-ian-muehlenhaus){ .md-button .md-button--primary .button_smaller target="_blank" }
    [Prompt Cartography website :material-web:](https://www.promptcartography.com/){ .md-button .md-button--primary .button_smaller target="_blank" }
    [ISSonVIS lecture – Ian Muehlenhaus :material-youtube:](https://www.youtube.com/watch?v=kDxgGgRsjdc&list=PLuQM074GC1ZD-yfYYNQLL3XGQOfhSlqK3&index=15){ .md-button .md-button--primary .button_smaller target="_blank" }
    [ICA Map Design Commission – 365 Day Map Challenge :material-map:](https://mapdesign.icaci.org/){ .md-button .md-button--primary .button_smaller target="_blank" }
    {: .button_array style="justify-content:flex-start;"}

---

# Blind prompt challenge

Before any introduction to prompt cartography, create a static map using an LLM.

The first task is intentionally underspecified.

!!! abstract "Task 1 – One-shot map"
    Create a **static map about earthquakes in the Pacific** using an LLM.

    You may write the prompt in any way you consider appropriate.

    **Rules:**

    - use one prompt only,
    - do not revise or improve the prompt,
    - do not ask the model to correct the result,
    - save both the original prompt and the first map.

    After the map is generated, write one sentence answering:

    > **What did the model decide for me?**

[<span>ArcGIS Survey123</span><br>Upload your result](https://arcg.is/14CbWW1){ .md-button .md-button--primary .server_name .external_link_icon_small target="_blank"}
{: .button_array}

Do not evaluate the result only by asking whether the map looks attractive. Look for decisions that were never explicitly specified in your prompt, for example:

- intended audience,
- purpose of the map,
- geographic extent,
- map projection,
- data source,
- time period,
- classification,
- visual hierarchy,
- colour scheme,
- symbolisation,
- labels and annotations,
- legend content,
- what was emphasised or omitted.


## Example – what did the model decide?

The following example was generated from a deliberately vague one-line prompt.

**Prompt**

```text
Create a static map about earthquakes in the Pacific.
```

**Result**

![](../assets/cviceni5/pacific_earthquakes_map.png){ .no-filter width=900px}
{align=center}

The model also explained the output as a map of the **Pacific Ring of Fire**, showing major plate boundaries and a selection of some of the largest earthquakes on record. It described the map as a simplified equirectangular representation and explicitly noted that **Alaska had been shifted slightly south to fit inside the frame**.

???+ warning "Cartographic critique – what was never specified?"
    The one-line prompt did not define most of the important cartographic decisions. The model made them instead.

    **Purpose and rhetoric**

    - It interpreted the task as an explanatory map of the **Ring of Fire**.
    - It decided that the map should explain *why* the Pacific is highly earthquake-prone.
    - The prompt never requested this explanatory narrative.

    **Data and selection**

    - It selected only a small number of major historical earthquakes.
    - No complete dataset, source, temporal range or reproducible selection criterion was requested.
    - The result therefore looks authoritative even though the provenance and completeness of the event selection are unclear.

    **Cartographic design**

    - Magnitude was represented by symbol size.
    - Plate boundaries, subduction zones and the East Pacific Rise were added as contextual information.
    - The model chose the geographic extent, projection, colour palette, visual hierarchy, labels and annotations.
    - Coastlines and tectonic boundaries were strongly generalised.

    **Geographic integrity**

    - The accompanying explanation states that **Alaska was shifted slightly south to fit the composition**.
    - This is a major design intervention that is not communicated inside the map itself.
    - It raises an important question: is the output still functioning as a geographic map, or partly as a schematic illustration?

    **Verification**

    - The map does not provide a visible source, citation or methodology.
    - Several claims and locations may appear plausible simply because the graphic is visually coherent.
    - Before publication, the data, positions, magnitudes, historical claims and geographic transformations would all need to be checked.

!!! question "What is the lesson?"
    The main problem is not that the model made decisions.

    Mapmaking always requires decisions.

    The problem is that **important cartographic decisions were delegated without being made explicit, justified or verified**.

    > **Plausible does not mean correct.**

## Compare the first results

Compare several maps produced by the class.

Discuss:

- Which cartographic decisions were explicitly specified by the student?
- Which decisions were apparently made by the model?
- Is the purpose of the map clear?
- Who appears to be the intended audience?
- Can the data and their provenance be verified?
- Which parts of the map look plausible but may still be misleading?
- What would you need to check before publishing the map?

???+ question "Key question"
    If the cartographer does not specify an important design decision, **who makes that decision?**

---

# Presentation

<br>
<br>
<br>
<br>

---

# Step 2 — Purpose and audience first

The first map showed what happens when the model has to infer most of the cartographic intent.

Now keep the **same topic**, but explicitly define only two things:

- **who the map is for**, and
- **what the map should help them understand**.

Do not specify the projection, colours, symbol sizes or detailed layout yet.

???+ note-fg-color "Comparison vs. revision"
    For the first three prompt versions, start a **new chat each time**.

    This keeps the comparison cleaner: the model sees only the current prompt and cannot rely on the previous map or conversation history.

    > **Comparison → new chat**  
    > **Revision → same chat**

    Later, when we deliberately revise an existing design, staying in the same chat becomes useful.

## Prompt 2 — add audience and purpose

Open a **new chat** and use:

```text
I want to create a static map about earthquakes in the Pacific
for a general audience with no specialist knowledge of seismology.

The purpose of the map is to show where the strongest recorded
earthquakes occurred and help readers compare their magnitude and date.

Recommend a map concept, the key information to include,
and what readers should remember after seeing it.
```

The aim is not to describe the previous map more precisely.

The first model output had already chosen its own explanatory purpose around the **Ring of Fire and tectonic plates**. Here, we deliberately direct the same broad topic toward a different communicative goal: **comparing major earthquake events**.

## Example output

![](../assets/cviceni5/pacific_earthquakes_prompt2.svg){ .no-filter width=1000px}
{align=center}

Compared with the casual prompt, the output is now much more clearly organised around the stated purpose:

- earthquake events are ranked,
- magnitude is visually emphasised,
- dates are shown,
- the design is aimed at a non-specialist audience,
- tectonic context becomes secondary rather than the main subject.

However, the model still makes additional decisions that were not explicitly requested.

???+ question "What to notice"
    Compare Prompt 1 and Prompt 2.

    - Did the answer become more selective?
    - Is the intended audience easier to identify?
    - Is the main message clearer?
    - Which decisions did the model still make on its own?
    - Did it introduce any claims, classifications or design choices that would need justification or verification?

For example, inspect the wording **“The 10 strongest earthquakes ever recorded around the Pacific Ocean”**, the split between **“Long ago”** and **“Recent”**, the data citation, the symbol scaling and the density of labels.

These observations will become the basis for the next step.

---

# Step 3 — Add guardrails

Keep the **topic, audience and purpose unchanged**.

In the next version, we will add a small number of explicit constraints — **guardrails** — and observe which of them changes the result most.

As before, use a **new chat** so that the only methodological change is the wording of the prompt.

---

# Step 4 — Synthesize as a Prompt Director

The final step is individual.

After comparing the three versions, summarize what you have learned from them and write your own **Prompt Director Brief**.

Do not simply copy the wording of Prompt 2 or Prompt 3. Use the previous outputs as evidence: decide which assumptions were useful, which decisions should remain under your control, and which constraints are important enough to state explicitly.

```text
Prompt Director Brief

Topic:

Audience:

Purpose:

What users should remember:

What the map should emphasize:

What the map should omit or downplay:

Guardrails:

One risk or uncertainty:

One thing I would check before trusting the output:
```

???+ note-fg-color "Work independently"
    Your brief should reflect **your own cartographic judgment**.

    There is no single correct version. Two cartographers may direct the same topic differently because they choose a different audience, purpose, emphasis or set of guardrails.

    If you do not finish the brief during the class, complete it independently before documenting the exercise in the StoryMap.

## From experiments to a design brief

Before finalizing your brief, look back at all three experiments:

```text
Prompt 1
Casual request
      ↓
What did the model assume?

Prompt 2
Audience + purpose
      ↓
What changed when the communicative intent became explicit?

Prompt 3
Audience + purpose + guardrails
      ↓
Which constraints changed the result most?
```

Use these observations to decide what belongs in your Director Brief.

Ask yourself:

- What should **I** decide before the model starts designing?
- Which decisions can reasonably be left open for the model to propose?
- Which assumptions in the previous outputs were useful?
- Which assumptions were misleading, arbitrary or difficult to verify?
- Which guardrails are necessary for this particular map?
- What would I need to verify before I could publish the result?

!!! question "Final reflection"
    Complete the sentence:

    > **As the map director, I am responsible for ...**

---

# Document the experiment in StoryMaps

The outputs from this practical will be documented in an **ArcGIS StoryMap**.

The StoryMap should make the development of the prompt visible, not only present the final map.

A suggested structure is:

### 1. Introduction

Briefly state the topic and the aim of the experiment.

Include the original casual prompt:

```text
Create a static map about earthquakes in the Pacific.
```

### 2. Prompt 1 vs. Prompt 2 — Swipe

Use a **Swipe** element to compare the first two map outputs.

- **Left:** Map 1 — casual prompt
- **Right:** Map 2 — audience + purpose

Add the two prompts as accompanying text and briefly explain what changed.

The aim of the Swipe is to make the effect of adding **audience and purpose** immediately visible.

### 3. Prompt 3 — Guardrails

Present the third map together with the guardrails added to the prompt.

Briefly identify:

- which guardrail had the strongest visible effect,
- which constraints the model respected,
- which constraints it ignored or interpreted unexpectedly.

### 4. Prompt Director Brief

Add your final Prompt Director Brief as text.

This is the synthesis of the exercise: it should show how your understanding of the task changed after comparing the three outputs.

### 5. Reflection

Finish with a short reflection answering:

> **What did the model decide for me at the beginning, and what would I now decide myself before prompting?**

???+ note-fg-color "What to keep"
    Keep the original prompts and outputs exactly as they were generated.

    Do not retrospectively improve Prompt 1 or Prompt 2 before placing them in the StoryMap. Their value lies in showing the progression of the experiment.

## Final deliverables

Your StoryMap should contain:

```text
Prompt 1 + Map 1

Prompt 2 + Map 2
→ compared using Swipe

Prompt 3 + Map 3
→ guardrails and short evaluation

Prompt Director Brief

Final reflection
```

The goal is not to present a sequence of increasingly attractive maps.

The goal is to make the **cartographic decision-making process visible**.