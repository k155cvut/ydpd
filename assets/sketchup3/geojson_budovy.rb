# encoding: UTF-8
# -----------------------------------------------------------------------------
# Budovy z GeoJSON – VZOROVÉ ŘEŠENÍ ke cvičení 3 (SketchUp + AI)
#
# Načte GeoJSON s polygony (Polygon i MultiPolygon, včetně otvorů = dvorů)
# a vytáhne je do výšky podle atributu "vyska". Barvu určí atribut "typ".
#
# Souřadnice v S-JTSK (EPSG:5514) jsou velká čísla (stovky tisíc metrů).
# Daleko od počátku ztrácí SketchUp přesnost, proto skript odečte
# lokální počátek (levý dolní roh dat zaokrouhlený na 100 m) a uloží ho
# do modelu jako atribut "k155/pocatek" – použije ho i skript stromy.rb.
#
# Spuštění v konzoli Ruby:
#   load "C:/cesta/k/souboru/geojson_budovy.rb"
# -----------------------------------------------------------------------------
require 'json'

module K155
  module GeojsonBudovy

    TAG = 'Budovy_GeoJSON'.freeze
    VYCHOZI_VYSKA = 10.0
    BARVY = {
      'bytovy'          => [232, 200, 160],
      'administrativa'  => [150, 180, 210],
      'skola'           => [240, 170, 90],
      'obchod'          => [200, 140, 180],
      'garaze'          => [170, 170, 170],
      'rodinny_dum'     => [230, 120, 100]
    }.freeze

    # Seznam polygonů jako [vnější prstenec, otvor, otvor, ...]
    def self.polygony(geometry)
      case geometry && geometry['type']
      when 'Polygon'      then [geometry['coordinates']]
      when 'MultiPolygon' then geometry['coordinates']
      else []
      end
    end

    def self.body(ring, x0, y0)
      pts = ring.map { |c| Geom::Point3d.new((c[0] - x0).m, (c[1] - y0).m, 0) }
      pts.pop if pts.size > 1 && pts.first == pts.last  # GeoJSON prstenec je uzavřený
      pts
    end

    def self.material(model, typ)
      nazev = "K155_#{typ}"
      mat = model.materials[nazev]
      return mat if mat
      mat = model.materials.add(nazev)
      mat.color = Sketchup::Color.new(*(BARVY[typ] || [210, 210, 210]))
      mat
    end

    def self.run
      path = UI.openpanel('Vyberte GeoJSON s budovami', '', 'GeoJSON|*.geojson;*.json||')
      return unless path
      data = JSON.parse(File.read(path, encoding: 'bom|utf-8'))
      features = data['features'] || []

      # lokální počátek = minimum souřadnic zaokrouhlené dolů na 100 m
      xs = features.flat_map { |f| polygony(f['geometry']).flat_map { |p| p.flat_map { |r| r.map { |c| c[0] } } } }
      ys = features.flat_map { |f| polygony(f['geometry']).flat_map { |p| p.flat_map { |r| r.map { |c| c[1] } } } }
      return UI.messagebox('Soubor neobsahuje žádné polygony.') if xs.empty?
      x0 = (xs.min / 100.0).floor * 100
      y0 = (ys.min / 100.0).floor * 100

      model = Sketchup.active_model
      model.start_operation('Budovy z GeoJSON', true)
      model.set_attribute('k155', 'pocatek', [x0, y0])
      tag = model.layers[TAG] || model.layers.add(TAG)
      pocet = 0
      chyby = 0

      features.each do |f|
        props = f['properties'] || {}
        vyska = (props['vyska'] || VYCHOZI_VYSKA).to_f
        polygony(f['geometry']).each do |rings|
          grp = model.active_entities.add_group
          grp.name = props['id'].to_s
          grp.layer = tag
          ents = grp.entities

          face = ents.add_face(body(rings[0], x0, y0))
          unless face
            grp.erase!
            chyby += 1
            next
          end
          # otvory (dvory): nakreslit plochu uvnitř a smazat ji
          rings[1..-1].to_a.each do |hole|
            inner = ents.add_face(body(hole, x0, y0))
            inner.erase! if inner && inner.valid?
          end
          face.reverse! if face.normal.z < 0
          face.pushpull(vyska.m)

          grp.material = material(model, props['typ'].to_s)
          props.each { |k, v| grp.set_attribute('k155', k.to_s, v) }
          pocet += 1
        end
      end

      model.commit_operation
      UI.messagebox("Vytvořeno budov: #{pocet}, přeskočeno: #{chyby}\n" \
                    "Lokální počátek S-JTSK: X0 = #{x0}, Y0 = #{y0}")
    rescue StandardError => e
      model.abort_operation if model
      UI.messagebox("Chyba: #{e.message}")
    end

  end
end

K155::GeojsonBudovy.run
