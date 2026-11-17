# encoding: UTF-8
# -----------------------------------------------------------------------------
# Výsadba stromů z CSV – VZOROVÉ ŘEŠENÍ ke cvičení 3 (SketchUp + AI)
#
# CSV (oddělovač ";"):  id;x;y;vyska;koruna   (S-JTSK, metry)
# Strom je jedna komponenta (kmen + kuželová koruna) o výšce 1 m a průměru
# koruny 1 m. Každá instance se zvětší podle atributů "vyska" a "koruna".
# Použije lokální počátek uložený skriptem geojson_budovy.rb, jinak ho
# spočítá stejně (minimum souřadnic zaokrouhlené dolů na 100 m).
#
# Spuštění v konzoli Ruby:
#   load "C:/cesta/k/souboru/stromy.rb"
# -----------------------------------------------------------------------------
require 'csv'

module K155
  module Stromy

    NAZEV = 'K155_Strom'.freeze
    TAG = 'Stromy'.freeze
    SEGMENTY = 12

    # Definice komponenty: výška 1 m, průměr koruny 1 m, počátek v patě kmene
    def self.definice(model)
      defn = model.definitions[NAZEV]
      return defn if defn
      defn = model.definitions.add(NAZEV)
      ents = defn.entities

      # kmen – válec
      kruh = ents.add_circle(ORIGIN, Z_AXIS, 0.04.m, SEGMENTY)
      kmen = ents.add_face(kruh)
      kmen.reverse! if kmen.normal.z < 0
      kmen.pushpull(0.25.m)

      # koruna – kužel (podstava ve výšce 0,25 m, vrchol v 1 m)
      zaklad = (0...SEGMENTY).map do |i|
        a = 2 * Math::PI * i / SEGMENTY
        Geom::Point3d.new((0.5 * Math.cos(a)).m, (0.5 * Math.sin(a)).m, 0.25.m)
      end
      vrchol = Geom::Point3d.new(0, 0, 1.m)
      podstava = ents.add_face(zaklad)
      podstava.reverse! if podstava && podstava.normal.z > 0   # podstava míří dolů
      SEGMENTY.times do |i|
        plast = ents.add_face(zaklad[i], zaklad[(i + 1) % SEGMENTY], vrchol)
        stred = plast.bounds.center
        ven = Geom::Vector3d.new(stred.x, stred.y, 0)
        plast.reverse! if plast.normal.dot(ven) < 0              # plášť míří ven
      end

      zelena = model.materials['K155_koruna'] || model.materials.add('K155_koruna')
      zelena.color = Sketchup::Color.new(90, 150, 70)
      hneda = model.materials['K155_kmen'] || model.materials.add('K155_kmen')
      hneda.color = Sketchup::Color.new(110, 80, 50)
      ents.grep(Sketchup::Face).each do |f|
        f.material = f.bounds.min.z >= 0.25.m - 0.001 ? zelena : hneda
      end
      defn
    end

    def self.run
      path = UI.openpanel('Vyberte CSV se stromy', '', 'CSV soubory|*.csv||')
      return unless path
      radky = CSV.read(path, headers: true, col_sep: ';', encoding: 'bom|utf-8')

      model = Sketchup.active_model
      pocatek = model.get_attribute('k155', 'pocatek')
      unless pocatek
        pocatek = [(radky.map { |r| r['x'].to_f }.min / 100.0).floor * 100,
                   (radky.map { |r| r['y'].to_f }.min / 100.0).floor * 100]
      end
      x0, y0 = pocatek

      model.start_operation('Stromy z CSV', true)
      defn = definice(model)
      tag = model.layers[TAG] || model.layers.add(TAG)
      pocet = 0

      radky.each do |r|
        vyska = r['vyska'].to_f
        koruna = r['koruna'].to_f
        next if vyska <= 0 || koruna <= 0
        bod = Geom::Point3d.new((r['x'].to_f - x0).m, (r['y'].to_f - y0).m, 0)
        tr = Geom::Transformation.translation(bod) *
             Geom::Transformation.scaling(ORIGIN, koruna, koruna, vyska)
        inst = model.active_entities.add_instance(defn, tr)
        inst.layer = tag
        inst.set_attribute('k155', 'id', r['id'].to_s)
        pocet += 1
      end

      model.commit_operation
      UI.messagebox("Vysazeno stromů: #{pocet}")
    rescue StandardError => e
      model.abort_operation if model
      UI.messagebox("Chyba: #{e.message}")
    end

  end
end

K155::Stromy.run
