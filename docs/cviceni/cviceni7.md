---
icon: material/numeric-7-box
title: Využití LLM pro tvorbu webové mapové aplikace.
---

# Prompt Cartography: Direct Your Own Map Experience

In the previous practical, you created an interactive web map using **real NOAA natural hazard data** and an LLM. You have already worked with **ArcGIS Dashboards and Experience Builder** and know how different controls can help people explore geographic data.

Your final challenge is to extend your existing application with **two meaningful functionalities of your own choice**. The goal is **not to add as many widgets as possible**, but to make the map more useful, understandable, or engaging for its intended audience.

???+ note-fg-color "Resources"
    [Prompt Cartography – Labs :material-map-marker-path:](https://www.promptcartography.com/labs/){ .md-button .md-button--primary .button_smaller target="_blank" }
    [Practical 6 – From Prompt to Web Map :material-map:](../cviceni6/){ .md-button .md-button--primary .button_smaller target="_blank" }
    [GitHub Pages documentation :material-github:](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site){ .md-button .md-button--primary .button_smaller target="_blank" }
    {: .button_array style="justify-content:flex-start;"}

!!! abstract "Your challenge"
    Extend your existing NOAA web map with **two functionalities**:

    - **A — Familiar:** Recreate or adapt one useful interaction you previously implemented in **ArcGIS Dashboards or Experience Builder**.
    - **B — New:** Design an interaction you have **not implemented before**. It may be analytical, exploratory, visual, or narrative; it does *not* have to be impossible to build in ArcGIS.

    **First define the user need and expected behaviour. Only then ask the LLM to write code.**

---

# Step 1: Think like a user

Before prompting an LLM, imagine someone using your web map. Answer these three questions briefly:

1. **Who** is using the map?
2. **What** would they like to find out or accomplish?
3. **What is currently missing** from the application?

Use your answers to choose functionalities **A** and **B**. Both should address an identifiable user need, rather than simply make the application more complicated.

???+ note-fg-color "Ideas — for inspiration only"
    | A — Familiar functionality | B — New functionality |
    |---|---|
    | Filter by magnitude, VEI, or wave height | 3D symbols representing event intensity |
    | Dynamic event-count indicators | Guided globe tour between selected events |
    | Proximity / spatial selection | Switch between flat symbols and 3D bars |
    | Search for an event or location | Navigate overlapping events within one pop-up |
    | Chart linked to a map selection | Interactive comparison of two selected events |

    These are **examples, not required features**. You can propose something entirely different.

---

# Step 2: Direct the behaviour

Think of the interaction **before** its implementation. Complete this short *Interactive Behavior Blueprint* for both functionalities:

| Question | Function A | Function B |
|---|---|---|
| What user need does it address? | | |
| What action triggers it? | | |
| What should happen in the map? | | |
| What happens if no matching events exist? | | |

You may ask the LLM to **critique or clarify** your proposal, but **do not generate code until you have decided how the interactions should behave**.

???+ note-fg-color "Example — spatial selection"
    | Question | Example answer |
    |---|---|
    | **User need** | Find recorded hazard events within 500 km of a selected location. |
    | **Trigger** | Click on the map after activating the selection tool. |
    | **Response** | Draw a circle and update event counts. |
    | **Empty state** | Display “No matching events”. |
    | **Existing controls** | Respect the active Year filter and layer visibility. |

    The aim is to specify **what should happen and why**, not to describe how to program it. This is inspired by the interactive-behaviour approach in Ian Muehlenhaus's Prompt Cartography Labs.

---

# Step 3: Implement and iterate

Continue developing your existing web map in the **same LLM conversation**, if possible, so the model can build on the application you already created.

1. Implement **Function A** using a structured prompt based on your blueprint.
2. Test it in the application before making further changes.
3. Implement **Function B** and test it as well.
4. Use targeted revision prompts to correct specific problems instead of asking the model to rebuild everything.

Keep the original NOAA Feature Service connections, map symbols, pop-ups, and existing controls working **unless you intentionally decide to change them**.

A revision prompt can be simple:

```text
Please change the following in the existing web application:

- [Describe the problem or requested change.]
- [Describe the expected behaviour.]

Preserve the existing data sources and working functionality.
Explain what you changed and how I can test it.
```

You may use any coding-capable LLM available to you.

---

# Step 4: Test and reflect

Test both functionalities **from the perspective of an actual user**:

- Do they behave as expected?
- Do they interact correctly with the existing Year filter, layer visibility, and other controls?
- Do they handle missing data and empty results?
- Do they improve the application, or merely make it more complicated?

Finish with a short reflection:

!!! question "The key question"
    **Which of your two functionalities adds more value to the user, and why?**

    Consider both *cartographic usefulness* and *technical reliability*. A feature that looks impressive is not necessarily a useful feature.

---

# Step 5: Publish and document

## Publish your application using GitHub Pages

1. Create a **GitHub repository**, or reuse the repository containing your web map.
2. Upload the final **`index.html`** to the root of the **`main`** branch.
3. Open **Settings → Pages** in your repository.
4. Under **Build and deployment**, select **Deploy from a branch**, choose **`main`** and **`/ (root)`**, then click **Save**.
5. Wait for GitHub Pages to deploy your application (this may take several minutes).
6. Open the published website and **verify** that the map, NOAA data, and both new functionalities work.

Your application will normally be available at:

```text
https://YOUR-USERNAME.github.io/YOUR-REPOSITORY/
```

???+ warning "Before publishing"
    GitHub Pages hosts your public HTML, CSS, and JavaScript. **Never publish private credentials or secret API tokens.** If your basemap needs a public client-side token, use only the necessary permissions and restrict allowed URLs where supported.

    Also check source attributions and verify that your external data services remain accessible in the published application.

???+ abstract "AI transparency"
    Add a visible **AI-ASSISTED** label to your published web application, preferably near the title or in the footer.
    Include a short statement explaining how generative AI contributed to its development and clarify that the geographic data come from NOAA, not from an AI model.
    You may use the [EU icons for labelling AI-generated content](https://digital-strategy.ec.europa.eu/en/policies/eu-icons-labelling-ai-generated-content) as inspiration.
    The purpose is to communicate the role of AI transparently while maintaining **human responsibility for cartographic decisions, accuracy, and interpretation**.
    The aim is to specify **what should happen and why**, not to describe how to program it. This is inspired by the interactive-behaviour approach in Ian Muehlenhaus's Prompt Cartography Labs.

## Embed your application in ArcGIS StoryMaps

Continue working in your **StoryMap from the previous practicals**.

1. Add a new section titled **Practical 7**.
2. Insert an **Embed** block and paste your published **GitHub Pages URL**.
3. Briefly document:
    - the purpose of your two functionalities;
    - your *Interactive Behavior Blueprint*;
    - the main implementation prompts;
    - what worked, what required revision, and what you learned.

---

???+ question "Final takeaway"
    **A technically functional map is not necessarily a good map.**

    You remain responsible for deciding what the application should do, critically evaluating the LLM's output, and ensuring that the result communicates geographic information appropriately.
