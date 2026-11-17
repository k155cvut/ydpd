# -----------------------------------------------------------------------------
# Panoramata pro virtuální prohlídku – cvičení 11 (Blender 4.2+ / 5.x)
#
# Pro každý bod ze seznamu BODY:
#   1) najde výšku terénu pod bodem (paprsek shora dolů),
#   2) postaví sférickou kameru 1,6 m nad terén, natočenou středem k severu,
#   3) vyrenderuje panorama 2:1 (equirectangular) do složky VYSTUP.
# Pokud scéna obsahuje georeferenci z BlenderGIS (vlastnosti scény "crs x", "crs y"),
# zadávají se body v souřadnicích S-JTSK (EPSG:5514) a skript je sám
# převede na lokální souřadnice Blenderu.
#
# Spuštění: záložka Scripting → Open → panoramata.py → Run Script
# -----------------------------------------------------------------------------
import bpy, math, os
from mathutils import Vector

# ---- nastavení -------------------------------------------------------------
VYSTUP = "//panoramata"              # // = složka, kde je uložen .blend soubor
SIRKA = 4096                         # šířka panoramatu v px (výška = polovina)
VZORKY = 64                          # počet vzorků Cycles (víc = méně šumu)
VYSKA_OKA = 1.6                      # výška kamery nad terénem v metrech
TEREN = "dmr_cvicny"                 # název objektu terénu (BlenderGIS ho pojmenuje podle souboru DEM)

# id bodu: (x, y) v S-JTSK (EPSG:5514), případně v lokálních souřadnicích scény
BODY = {
    "A": (-745800.0, -1041516.0),
    "B": (-745780.5, -1041541.5),
    "C": (-745736.0, -1041571.5),
}
# ---------------------------------------------------------------------------

sc = bpy.context.scene

# posun georeferencované scény (BlenderGIS ukládá počátek do vlastností scény)
dx = sc.get("crs x", 0.0)
dy = sc.get("crs y", 0.0)
if dx or dy:
    print(f"Georeference BlenderGIS: počátek scény = ({dx:.2f}, {dy:.2f}), CRS = {sc.get('SRID')}")

teren = bpy.data.objects.get(TEREN)
if teren is None:
    raise RuntimeError(f"Objekt terénu '{TEREN}' nebyl nalezen – upravte proměnnou TEREN.")
deps = bpy.context.evaluated_depsgraph_get()

def vyska_terenu(x, y):
    """Vrátí výšku terénu (Z) pod bodem x, y v lokálních souřadnicích."""
    hit, loc, *_ = sc.ray_cast(deps, Vector((x, y, 10000.0)), Vector((0, 0, -1)))
    if not hit:
        raise RuntimeError(f"Bod ({x:.1f}, {y:.1f}) leží mimo terén.")
    return loc.z

# sférická (panoramatická) kamera
cam_data = bpy.data.cameras.get("panorama") or bpy.data.cameras.new("panorama")
cam_data.type = 'PANO'
cam_data.panorama_type = 'EQUIRECTANGULAR'
cam = bpy.data.objects.get("panorama") or bpy.data.objects.new("panorama", cam_data)
if cam.name not in sc.collection.objects:
    sc.collection.objects.link(cam)
sc.camera = cam

# nastavení renderu
sc.render.engine = 'CYCLES'          # panoramatická kamera funguje v Cycles
sc.cycles.samples = VZORKY
sc.cycles.use_denoising = True
sc.render.resolution_x = SIRKA
sc.render.resolution_y = SIRKA // 2
sc.render.resolution_percentage = 100
sc.render.image_settings.file_format = 'JPEG'
sc.render.image_settings.quality = 88

slozka = bpy.path.abspath(VYSTUP)
os.makedirs(slozka, exist_ok=True)

for bod, (x, y) in BODY.items():
    lx, ly = x - dx, y - dy                               # S-JTSK -> lokální
    z = vyska_terenu(lx, ly) + VYSKA_OKA
    cam.location = (lx, ly, z)
    cam.rotation_euler = (math.radians(90), 0, 0)        # střed obrazu = sever (+Y)
    sc.render.filepath = os.path.join(slozka, f"pano_{bod}.jpg")
    print(f"Render {bod}: lokálně ({lx:.1f}, {ly:.1f}, {z:.1f})")
    bpy.ops.render.render(write_still=True)

print("Hotovo – panoramata jsou ve složce", slozka)
