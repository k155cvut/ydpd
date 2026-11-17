---
icon: material/flag-checkered
title: Semestrální práce
---

V&nbsp;semestrální práci **detailně vymodelujete vybranou budovu** ve SketchUpu, zasadíte ji do terénu s&nbsp;nejbližším okolím a&nbsp;vytvoříte **webovou aplikaci s&nbsp;virtuální prohlídkou** modelu. Práce propojuje vše, co jste se v&nbsp;bloku 3D modelování naučili.

## 1. Výběr budovy

- Budovu si vyberte **podle vlastního uvážení**. Ideálně jde o&nbsp;**historickou stavbu** - např. kostel, menší zámek nebo hrad.
- Zjistěte, jaké jsou k&nbsp;budově **podklady**: fotografie, mapy (katastrální mapa, historické mapy, ortofoto) a&nbsp;plány (půdorysy, řezy, pohledy).
- Výběr **konzultujte s&nbsp;vyučujícím** – pošlete název a&nbsp;polohu budovy a&nbsp;seznam nalezených podkladů. S&nbsp;modelováním začněte až po schválení.

## 2. Model budovy

Budovu vymodelujte ve **SketchUpu** podle podkladů a&nbsp;dodržujte zásady z&nbsp;cvičení:

- Části budovy jako **skupiny**, opakované prvky (okna, dveře, sloupy) jako **komponenty**.
- Přehledná struktura – pojmenované skupiny a&nbsp;komponenty, případně **tagy**.
- Správné **měřítko** a&nbsp;**normály** ploch, čistá geometrie (Solid Inspector², CleanUp³).
- **Textury** co nejlépe odpovídající skutečnému vzhledu stavby.

## 3. Terén a&nbsp;okolí

- Budovu zasaďte do **terénu** (Add Location, vrstevnice nebo Qgis2threejs).
- Doplňte **nejbližší okolí** – okolní budovy jako jednoduché bloky, cesty, zdi.
- Přidejte **vegetaci** (stromy, keře).
- Hotovou scénu **vyexportujte do webového formátu** (glTF/GLB) a&nbsp;zkontrolujte její velikost a&nbsp;zobrazení.

## 4. Webová aplikace

- Vytvořte webovou stránku s&nbsp;**virtuální prohlídkou** modelu. JavaScriptovou knihovnu zvolte dle osobní preference – např. **model-viewer**, **Three.js**, **Babylon.js** nebo **Photo Sphere Viewer** (panoramata z&nbsp;vyrenderované scény).
- Součástí webu bude:
    - **popis budovy** a&nbsp;její **historie**,
    - **podklady k&nbsp;modelování** – použité fotografie, mapy a&nbsp;plány se zdroji.
- Web zveřejněte na **Netlify**, **GitHub Pages** nebo podobné platformě.

## Odevzdání

Termín: __31.12.2026__{.outlined}.

Až bude práce hotová, pošlete e-mail na _frantisek.muzik@fsv.cvut.cz_{.outlined}. Do e-mailu uveďte:

- **odkaz na zveřejněný web**,
- **odkaz na zdrojové soubory** (repozitář nebo sdílená složka),
- **model ve SketchUpu** (.skp) – jako přílohu nebo odkaz ke stažení.

!!! note "&nbsp;<span style="color:#448aff">Užitečné odkazy</span>"
    - model-viewer: <https://modelviewer.dev/>

    - Three.js: <https://threejs.org/>

    - Babylon.js: <https://www.babylonjs.com/>

    - Photo Sphere Viewer: <https://photo-sphere-viewer.js.org/>

    - Netlify: <https://www.netlify.com/>

    - GitHub Pages: <https://pages.github.com/>