
# Vizualizace 3D modelů pomocí moderních technologií {: .page_title}

Tento povinně-volitelný předmět představuje možnosti vizualizace trojrozměrných modelů pomocí moderních technologií.

Postupně se představí několik různých způsobů zpracování a vizualizace 3D prostorových dat, a to fotogrammetrických, GIS či kartografických. První část předmětu se soustředí na představení herního enginu Unreal Engine, ve kterém lze vizualizovat fotogrammetrická data v prostředí virtuální reality. Následuje ukázka práce s 3D GIS daty v ArcGIS Pro a ArcGIS Online. Tyto znalosti budou rozvíjeny základy procedurálního modelování s využitím softwaru City Engine. Dále budou představeny možnosti 3D tisku prostorových GIS dat. Závěrem semestru se pak přesuneme k vizualizaci geodat v rozšířené realitě, a to jak ve webovém prohlížeči, tak s využitím dedikované mobilní aplikace vyvinuté pomocí herního enginu Unity.


<h2 style="text-align:center;">Naučíte se</h2>
<!-- styl je zde pridany HTML tagem (ne pomoci '##'), aby se text neobjevil v tabulce obsahu vlevo na strance -->

<div class="grid cards grid_icon_info smaller_padding" markdown> <!-- specificky format gridu (trida "grid_icon_info") na miru uvodni strance predmetu -->

-   :simple-unrealengine:{ .xl }

    pracovat s __Unreal Engine__

-   :fontawesome-solid-vr-cardboard:{ .xl }

    zobrazit data ve __virtuální realitě__

-   :fontawesome-solid-photo-film:{ .xl }

    pokročilou tvorbu a editaci __fotogrammetrických__ modelů

-   :simple-materialdesignicons:{ .xl }

    psát __CGA__ kód a generovat __procedurální__ krajinu nebo města

-   :material-printer-3d-nozzle:{ .xl }

    připravit prostorová data pro __3D tisk__


-   :simple-unity:{ .xl }

    vytvořit __mobilní aplikaci__ pomocí herního enginu __Unity__

-   :simple-arcgis:{ .xl }

    pracovat s __3D GIS__ daty v ArcGIS Pro a ArcGIS Online

-   :material-augmented-reality:{ .xl }

    vizualizovat prostorová data v prostředí __rozšířené reality__


</div>

<div class="gallery_container" markdown>
![](https://dev.epicgames.com/community/api/learning/image/182adf38-1d2d-4ae8-af7a-fe435a08649f?resizing_type=fit){: .no-filter }
![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHoVA4sqB8tfISS6vEFdD52JOjhyuG-gwEug&s){: .no-filter }
![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq8luRFuqJlHFOMrLaXhF8MEcgdvjHrGNqwQ&s){: .no-filter }
![](https://www.esri.com/content/dam/esrisites/en-us/arcgis/products/city-engine/assets/overview-tls-urban-planning.jpg){: .no-filter }
![](https://www.arcdata.cz/content/dam/distributor-share/arcdata-cz/arcgis/arcgis-cityengine/city-engine-tabcontent-5-steps-4-add-details.jpg){: .no-filter }
![](https://reko3d.com/wp-content/uploads/2023/09/AR-plane-city-1920x1024.jpg){: .no-filter }
![](https://images.ctfassets.net/26961o1141cc/4BIQBpSBwswwxyqEFdCrCy/1ab81641cd6118bfccd464929cf3781f/Plan_1.PNG?w=1626&h=914&fm=webp&q=100){: .no-filter }

</div>


## Přednášky {: style="margin-bottom:0;"}

![](https://geomatics.fsv.cvut.cz/wp-content/uploads/2022/01/03-edit_export@0.5x-12.jpg){: .off-glb .no-filter style="height: 1.5em; vertical-align: -.4em; clip-path: circle();"}
__[Ing. Karel Pavelka, Ph.D.](https://geomatics.fsv.cvut.cz/employees/karel-pavelka-ml/) [:fontawesome-solid-square-envelope:](mailto:karel.pavelka@cvut.cz "karel.pavelka@cvut.cz"){style="color:var(--md-default-fg-color);"}__{style="padding-right:1rem;"}
{style="display:inline; white-space: nowrap; line-height:2;"}
<!-- kvuli zobrazovani na mobilu -->

![](https://geomatics.fsv.cvut.cz/wp-content/uploads/2022/01/03-edit_export@0.3x.jpg){: .off-glb .no-filter style="height: 1.5em; vertical-align: -.4em; clip-path: circle();"}
__[Ing. Vojtěch Cehák](https://geomatics.fsv.cvut.cz/employees/vojtech-cehak/) [:fontawesome-solid-square-envelope:](mailto:vojtech.cehak@fsv.cvut.cz "vojtech.cehak@fsv.cvut.cz"){style="color:var(--md-default-fg-color);"}__{style="padding-right:1rem;"}
{style="display:inline; white-space: nowrap; line-height:2;"}
<!-- kvuli zobrazovani na mobilu -->

![](https://geomatics.fsv.cvut.cz/wp-content/uploads/2022/01/03-edit_export@0.5x-15.jpg){: .off-glb .no-filter style="height: 1.5em; vertical-align: -.4em; clip-path: circle();"}
__[Ing. Michal Janovský, PhD.](https://geomatics.fsv.cvut.cz/employees/michal-janovsky/) [:fontawesome-solid-square-envelope:](mailto:michal.janovsky@fsv.cvut.cz "michal.janovsky@fsv.cvut.cz"){style="color:var(--md-default-fg-color);"}__{style="padding-right:1rem;"}
{style="display:inline; white-space: nowrap; line-height:2;"}
<!-- kvuli zobrazovani na mobilu -->

![](https://geomatics.fsv.cvut.cz/wp-content/uploads/2022/01/03-edit_export@0.75x-4.jpg){: .off-glb .no-filter style="height: 1.5em; vertical-align: -.4em; clip-path: circle();"}
__[Ing. František Mužík](https://geomatics.fsv.cvut.cz/employees/frantisek-muzik/) [:fontawesome-solid-square-envelope:](mailto:frantisek.muzik@fsv.cvut.cz "frantisek.muzik@fsv.cvut.cz"){style="color:var(--md-default-fg-color);"}__{style="padding-right:1rem;"}
{style="display:inline; white-space: nowrap; line-height:2;"}
<!-- kvuli zobrazovani na mobilu -->






jsou spíše formou workshopu a bezprostředně předcházejí cvičením, s nimiž se mnohdy prolínají
{: style="opacity:50%;margin-top:0;"}

1. Představení možností vizualizace 3D prostorových dat moderními technologiemi. Základy 3D tisku. 
2. 3D tisk prostorových dat. Ukázka pokročilejších možností 3D tisku včetně vícebarevného tisku.
3. Práce s 3D GIS daty v ArcGIS Pro. Publikace a správa trojrozměrných dat na ArcGIS Online.
4. Seznámení s procedurálním modelováním. Základy City Engine a psaní CGA kódu.
5. Základy Unreal Engine. Seznámení s uživatelským prostředím.
6. Představení virtuální reality. Příprava 3D modelů pro virtuální realitu.
7. Pokročilé editace fotogtammetrických modelů. Moderní metody ve fotogrammetrii.
8. Vizualizace 3D dat ve virtuální realitě.
9. Pokročilejší vizualizace v UE.
10. Představení rozšířené reality. WebXR, webové JS knihovny.
11. Využití herního enginu Unity. Tvorba mobilní aplikace pro Android v Unity.



## Harmonogram {: style="margin-bottom:0;"}
Harmonogram je platný pro zimní semestr 2025/26.
{: style="opacity:50%;margin-top:0;"}

| Datum       | Téma                                                                 |
|-------------|----------------------------------------------------------------------|
| 23.9.2025   | Základy 3D tisku                                                     |
| 30.9.2025   | 3D tisk prostorových dat (projekt AMUSE – virtuální muzeum)          |
| 7.10.2025   | Úvod do 3D GIS                                                       |
| 14.10.2025  | Úvod do procedurálního modelování                                    |
| 21.10.2025  | Práce s rastry, procedurální generování vegetace v Unreal Enginu (UE)|
| 4.11.2025   | Příprava 3D modelů pro virtuální realitu                             |
| 11.11.2025  | Tvorba virtuálního muzea v UE                                        |
| 18.11.2025  | Pokročilé práce v UE                                                 |
| 25.11.2025  | Pokročilé práce v UE                                                 |
| 2.12.2025   | Webová rozšířená realita                                             |
| 9.12.2025   | Tvorba mobilní aplikace v Unity                                      |
| 16.12.2025  | Zkouška – 1. termín                                                  |


<!--
[![](./assets/index/schedule.svg#only-light){.off-glb .no-filter}](https://kos.cvut.cz/schedule/course/1551GIS/semester/B232){target="_blank"}
[![](./assets/index/schedule_dark.svg#only-dark){.off-glb .no-filter}](https://kos.cvut.cz/schedule/course/1551GIS/semester/B232){target="_blank"}

---

[Stránka předmětu v :custom-kos-logo-img-BW:{.middle style="margin-left:3px;"} :custom-kos-logo-BW:{.xl .middle}](https://kos.cvut.cz/course-syllabus/1551GIS/B232){ .md-button .md-button--primary target="_blank"}
{align=center}

-->