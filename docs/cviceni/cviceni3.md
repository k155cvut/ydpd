---
icon: material/numeric-3-box
title: Cvičení 3
---


# Základy 3D v ArcGIS Pro

Cílem cvičení je osvojit si základní dovednosti **práce s 3D daty v programu ArcGIS Pro**. Důraz je kladen zejména na **vizualizaci dat**, nicméně mnohým výstupům předchází i základní **datové analýzy**. Díky analýzám je možná například i poloautomatická **konverze z 2D do 3D** – tedy doplnění třetího rozměru, a to nejen pouze v rámci doplnění výškových souřadnic, ale i modelování složitějších 3D objektů na základě 2D geometrie.
Ze začátku jsou vysvětleny obecné koncepty práce ve 3D, rozdíly mezi mapou a scénou a specifika dat obsahujících třetí rozměr. Dále je plynule navázáno na dosavadní výuku GIS – začíná se tedy s běžnými typy geometrie (point, line, polygon). A přes jejich varianty obsahující souřadnici Z (pointZ, lineZ, polygonZ) je postoupeno až ke skutečné 3D geometrii typu Multipatch FC a 3D Object FC. Výstupem cvičení je 3D scéna vystavěná z objektů vzniklých všemi různými metodami probranými během cvičení (zarovnání na terén, extruze řízená atributem, procedurální symbologie apod.).

3D GIS data mají oproti 2D mnohé výhody, jejich použití ale není ve všech případech vhodné. V některých případech mohou činit výstup složitějším, což může být ve výsledku kontraproduktivní. U některých výstupů je pak vhodné tyto dva typy dat kombinovat. Například využít 3D data k analýze, jejíž výsledkem je následně vizualizace v 2D mapě. Obecně jsou 3D data velmi dobře využitelná v oblasti vizualizace – tedy reprezentace reálného prostoru. Předlohou takového prostoru může být realita (např. fotogrammetrický model města), fiktivní návrh (např. studie budoucího stavu parcely). Tyto dvě možnosti lze také kombinovat – tedy doplnit obraz reálného světa o atributové informace, což je jedna ze základních myšlenek tzv. digitálního dvojčete.

V programu :simple-arcgis: ArcGIS Pro jsou pro prohlížení obsahu určeny 3 hlavní typy prostoru: **:material-crop-square: mapa**{.underlined}, **:material-cube-outline: lokální scéna**{.underlined} a **:material-sphere: globální scéna**{.underlined}.

- **:material-crop-square: Mapa**{.underlined} zobrazuje 2D prostor (může však zobrazovat symbologii na základě výšky), scéna pak 3D prostor.
- **:material-cube-outline: Lokální scéna**{.underlined} zobrazuje prostor jako kartézskou soustavu souřadnic, je proto vhodná pro použití dat v projektovaném souřadnicovém systému.
- **:material-sphere: Globální scéna**{.underlined} zobrazuje data na povrchu elipsoidu (planety Země), hodí se proto pro zeměpisné souřadnice. Globální scéna má z tohoto důvodu omezení na souřadnicový systém WGS 84.

Oba typy scény umožňují nastavení on-the-fly transformace. Dělení na mapu, lokální a globální scénu platí taktéž pro webové rozhraní platformy **ArcGIS Online**.

![](https://pro.arcgis.com/en/pro-app/latest/help/mapping/map-authoring/GUID-C919C6C3-45AE-46EC-862D-024066AC55B7-web.png){ .no-filter }
![](https://pro.arcgis.com/en/pro-app/latest/help/mapping/map-authoring/GUID-C1BD50ED-F744-4387-9C8A-6E3FCB3EB2D3-web.png){ .no-filter }
![](https://pro.arcgis.com/en/pro-app/latest/help/mapping/map-authoring/GUID-9FA7B348-A8BE-46D5-A645-9CE4FF35D678-web.png){ .no-filter }
{: .process_container}

<figcaption markdown>Hlavní rozdíly mezi mapou, lokální scénou a globální scénou</figcaption>

Základní nástroje pro prohlížení scény v ArcGIS Pro:

**Explore Tool**{.underlined} – **prostřední tlačítko myši** = orbit scény, **levé tlačítko myši** = horizontální posun po povrchu, **pravé tlačítko myši** = přiblížení/oddálení scény (zoom)

**Select Tool**{.underlined} – **prostřední tlačítko myši** = horizontální posun po povrchu, **levé tlačítko myši** = vytvoří výběr prvků

**tlačítko C**{.underlined} – dočasně přepne na nástroj **Explore Tool**

Navigace ve webové 3D scéně ArcGIS Online je odlišná od desktopové verze ArcGIS.

**Shrnutí datových typů v souvislosti s 3D geometrií:**

<div class="table_small_padding table_centered" markdown>
| typ geometrie                       | vztah ke 3D                                |
| ----------------------------------- | ------------------------------------------ |
| point, line, polygon                | neobsahuje Z souřadnici                    |
| pointZ, lineZ, polygonZ, multipatch | obsahuje Z souřadnici                      |
| Scene Layer (I3S)                   | 3D geometrie včetně cache (určeno pro web) |
</div>

Při analýzách je možné ovlivnit záznam Z souřadnic v nastavení **Environments** – položka „**Z Values**“. Při vytváření nové feature class je nutné zaškrtnout možnost „Z Values“.

## Analytické a editační nástroje

**Manuální úprava Z souřadnic**

Nástroj editace „**Edit Vertices**“

**Hromadná úprava Z souřadnic**

- [Feature To 3D By Attribute (3D Analyst)](https://pro.arcgis.com/en/pro-app/latest/tool-reference/3d-analyst/feature-to-3d-by-attribute.htm){ .md-button .md-button--primary .button_smaller .external_link_icon target="\_blank"}
- [Adjust 3D Z (Data Management)](https://pro.arcgis.com/en/pro-app/3.3/tool-reference/data-management/adjust-3d-z.htm){ .md-button .md-button--primary .button_smaller .external_link_icon target="\_blank"}

**Přidání Z souřadnic na základě atributu či povrchu** (automatizovaný převod 2D do 3D)

- [Feature To 3D By Attribute (3D Analyst)](https://pro.arcgis.com/en/pro-app/latest/tool-reference/3d-analyst/feature-to-3d-by-attribute.htm){ .md-button .md-button--primary .button_smaller .external_link_icon target="\_blank"}
- [Update Feature Z (3D Analyst)](https://pro.arcgis.com/en/pro-app/latest/tool-reference/3d-analyst/update-feature-z.htm){ .md-button .md-button--primary .button_smaller .external_link_icon target="\_blank"}
- [Interpolate Shape (3D Analyst)](https://pro.arcgis.com/en/pro-app/latest/tool-reference/3d-analyst/interpolate-shape.htm){ .md-button .md-button--primary .button_smaller .external_link_icon target="\_blank"}

![](https://pro.arcgis.com/en/pro-app/latest/tool-reference/3d-analyst/GUID-395A1FD0-3BB6-4247-B8E5-0AADBE6B2633-web.gif){ .no-filter }
{: .process_container}

<figcaption markdown>Princip nástroje Interpolate Shape</figcaption>

**Převod 3D symbologie do Multipatch Feature Class**

- [Layer 3D To Feature Class (3D Analyst)](https://pro.arcgis.com/en/pro-app/latest/tool-reference/3d-analyst/layer-3d-to-feature-class.htm){ .md-button .md-button--primary .button_smaller .external_link_icon target="\_blank"}

## Umístění geometrie ve scéně (výška)

Ve vlastnostech vrstvy scény (karta Elevation) je možné vybrat tato nastavení:

- **On the ground**{.underlined} – využita bude výška z povrchu označeného jako Ground
- **At an absolute height**{.underlined} – využit bude buď atribut nebo přímo Z souřadnice zapsané v prvku
- **Relative to the ground**{.underlined} – Z souřadnice se přičte k výšce povrchu
- **Relative to the scene**{.underlined} – Z souřadnice se přičte k výšce nejvyššího objektu scény (vztahuje se na veškerou 3D geometrii)

U každé z možností lze nastavit ještě hodnotu **offset**.

Vrstvě „Ground“ lze nastavit hodnotu „**Vertical Exaggeration**“ (neboli „*Z Factor*“). Touto hodnotou jsou vynásobeny všechny výšky ve scéně. Toto nastavení se používá při potřebě **vizuálně zvýraznit výškové rozdíly**. Nemá ale žádný vliv na analýzy.

Terénu lze také nastavit **barvu** a **průhlednost** (možnost „Surface Color“) nebo povolit **navigaci pod povrchem** („Navigate Underground“).

## 3D symbologie

Kromě přidávání Z souřadnice vertexům prvků lze také přidávat 3D symbologii. Specifika této symbologie závisí na typu geometrie.

Bodové geometrii lze přiřazovat základní 3D tvary nebo i libovolný 3D model, který bude umístěn na pozici každého bodu.

Liniovou geometrii lze reprezentovat profily o různém tvaru a velikosti – například Tube, Strip, Wall či Rectangle.

Polygonům lze nastavovat extruzi, a to buď na základě výrazu nebo atributu.

![](https://webapps-cdn.esri.com/CDN/support-site/technical-articles-images/000016699/00N39000003LL2C-0EM390000019ftT.png){ .no-filter }
![](https://learn.arcgis.com/en/projects/improve-3d-thematic-symbology/GUID-6EEC4448-84C0-423D-BE13-00090EB209A8-web.png){ .no-filter }
![](https://doc.arcgis.com/en/3d/workflows/visualization/GUID-01B6DBA2-31DB-4F32-9238-EACD018B2CEE-web.png){ .no-filter }
{: .process_container}

![](https://doc.arcgis.com/en/3d/workflows/visualization/GUID-DA1C8995-52EC-437C-A6A6-A4B90AA06D5F-web.png){ .no-filter }
![](https://developers.arcgis.com/javascript/latest/assets/img/apiref/symbols/symbols-3d-path.png){ .no-filter }
![](https://developers.arcgis.com/javascript/latest/static/130ef1cee05caa777ae180aa0cd58756/e05eb/street-lamp.png){ .no-filter }
{: .process_container}

## Import 3D formátů

ArcGIS Pro má nativní podporu pro čtení těchto neGISovských 3D formátů: CAD kresba (DWG), BIM model (IFC, RVT)

Následující formáty pak lze importovat pomocí nástroje „**Import 3D Objects (Data Management)**“:

- COLLADA (.dae)
- Drawing (.dwg)
- Autodesk Filmbox (.fbx)
- Graphics Library Transmission (.glb)
- JSON Graphics Library Transmission (.gltf)
- Industry Foundation Class (.ifc)
- Wavefront Object (.obj)
- Universal Scene Description (.usdc)
- Compressed Universal Scene Description (.usdz)

Do formátu DWG lze také exportovat, a to pomocí nástroje „**Export To CAD (Conversion)**“

## Export do webové scény

Pro export do webové scény ArcGIS Online je nutné 3D data konvertovat do formátu **I3S**, neboli Scene Layer. Tento typ vrstvy pak lze přes ArcGIS Pro uploadovat do prostředí ArcGIS Online a následně zobrazit v 3D scéně.

![](https://www.esri.com/arcgis-blog/wp-content/uploads/2022/06/OSM-3D-layers.gif)
{ align=center }

![](https://www.esri.com/arcgis-blog/wp-content/uploads/2022/06/snow_7.gif)
{ align=center }
