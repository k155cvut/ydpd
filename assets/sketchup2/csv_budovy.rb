# encoding: UTF-8
# -----------------------------------------------------------------------------
# Budovy z CSV – cvičení 2 (SketchUp, katedra geomatiky FSv ČVUT)
#
# Načte CSV (oddělovač ";") se sloupci:
#   id;x;y;sirka;hloubka;vyska;natoceni
# Souřadnice a rozměry jsou v metrech, natočení ve stupních (proti směru hodin).
# Každou budovu vytvoří jako samostatnou skupinu (kvádr), umístí ji do tagu
# "Budovy_CSV" a výšku uloží jako atribut.
#
# Spuštění v konzoli Ruby (Window → Ruby Console):
#   load "C:/cesta/k/souboru/csv_budovy.rb"
# -----------------------------------------------------------------------------
require 'csv'

module K155
  module CsvBudovy

    TAG = 'Budovy_CSV'.freeze

    # Vytvoří jeden kvádr se středem podstavy v počátku skupiny
    def self.kvadr(entities, sirka, hloubka, vyska)
      hw = sirka / 2.0
      hd = hloubka / 2.0
      body = [[-hw, -hd], [hw, -hd], [hw, hd], [-hw, hd]].map do |px, py|
        Geom::Point3d.new(px.m, py.m, 0)
      end
      face = entities.add_face(body)
      face.reverse! if face.normal.z < 0   # normála musí mířit vzhůru
      face.pushpull(vyska.m)
    end

    def self.run
      path = UI.openpanel('Vyberte CSV s budovami', '', 'CSV soubory|*.csv||')
      return unless path

      model = Sketchup.active_model
      model.start_operation('Budovy z CSV', true)  # jeden krok pro Undo
      tag = model.layers[TAG] || model.layers.add(TAG)
      pocet = 0

      CSV.foreach(path, headers: true, col_sep: ';', encoding: 'bom|utf-8') do |r|
        x, y = r['x'].to_f, r['y'].to_f
        sirka, hloubka, vyska = r['sirka'].to_f, r['hloubka'].to_f, r['vyska'].to_f
        uhel = r['natoceni'].to_f
        next if sirka <= 0 || hloubka <= 0 || vyska <= 0

        grp = model.active_entities.add_group
        grp.name = r['id'].to_s
        grp.layer = tag
        kvadr(grp.entities, sirka, hloubka, vyska)

        # nejdříve otočit kolem počátku, potom posunout na místo
        rot = Geom::Transformation.rotation(ORIGIN, Z_AXIS, uhel.degrees)
        pos = Geom::Transformation.translation(Geom::Vector3d.new(x.m, y.m, 0))
        grp.transform!(pos * rot)

        grp.set_attribute('k155', 'vyska', vyska)
        pocet += 1
      end

      model.commit_operation
      UI.messagebox("Vytvořeno budov: #{pocet}")
    rescue StandardError => e
      model.abort_operation if model
      UI.messagebox("Chyba: #{e.message}")
    end

  end
end

K155::CsvBudovy.run
