# encoding: UTF-8
# -----------------------------------------------------------------------------
# Dům z komponent
#
# Stěny a sedlová střecha jsou skupiny, okna a dveře komponenty.
# Rozměry změníme v konstantách níže a skript spustíme znovu.
#
# Spuštění v Ruby konzoli:
#   load "C:/cesta/k/souboru/domek.rb"
# -----------------------------------------------------------------------------

module YDPD
  module Domek

    # ---- parametry domku (metry) ----
    SIRKA   = 8.0   # délka podél osy X (přední fasáda)
    HLOUBKA = 6.0   # délka podél osy Y
    VYSKA   = 3.0   # výška stěn
    STRECHA = 2.5   # výška hřebene nad stěnami
    PRESAH  = 0.4   # přesah střechy na všech stranách
    OKNA    = 3     # počet oken na přední fasádě
    PARAPET = 1.0   # výška spodní hrany okna nad zemí

    # Materiál – když už v modelu je, použije se znovu
    def self.material(model, nazev, r, g, b, alpha = 1.0)
      mat = model.materials[nazev] || model.materials.add(nazev)
      mat.color = Sketchup::Color.new(r, g, b)
      mat.alpha = alpha
      mat
    end

    # Tag (dříve vrstva) – když už v modelu je, použije se znovu
    def self.tag(model, nazev)
      model.layers[nazev] || model.layers.add(nazev)
    end

    # Stěny: kvádr SIRKA × HLOUBKA × VYSKA jako skupina
    def self.steny(model)
      g = model.active_entities.add_group
      f = g.entities.add_face([0, 0, 0], [SIRKA.m, 0, 0],
                              [SIRKA.m, HLOUBKA.m, 0], [0, HLOUBKA.m, 0])
      f.reverse! if f.normal.z < 0          # líc nahoru, aby Push/Pull táhl vzhůru
      f.pushpull(VYSKA.m)
      g.name = 'Steny'
      g.material = material(model, 'Omitka', 235, 228, 210)
      g.layer = tag(model, 'Budova')
      g
    end

    # Sedlová střecha: trojúhelník (štít) vytažený podél osy X, hřeben rovnoběžný s X
    def self.strecha(model)
      g = model.active_entities.add_group
      x0 = -PRESAH
      f = g.entities.add_face([x0.m, -PRESAH.m, VYSKA.m],
                              [x0.m, (HLOUBKA + PRESAH).m, VYSKA.m],
                              [x0.m, (HLOUBKA / 2).m, (VYSKA + STRECHA).m])
      f.reverse! if f.normal.x < 0          # líc ve směru +X
      f.pushpull((SIRKA + 2 * PRESAH).m)
      g.name = 'Strecha'
      g.material = material(model, 'Taska', 150, 60, 45)
      g.layer = tag(model, 'Budova')
      g
    end

    # Komponenta okna: rám s vnitřním sklem, vytvořená v rovině XZ (líc ke -Y)
    def self.okno(model, sirka = 1.0, vyska = 1.2, ramek = 0.08)
      defn = model.definitions['YDPD_Okno']
      return defn if defn
      defn = model.definitions.add('YDPD_Okno')
      e = defn.entities
      ram = e.add_face([0, 0, 0], [sirka.m, 0, 0], [sirka.m, 0, vyska.m], [0, 0, vyska.m])
      sklo = e.add_face([ramek.m, 0, ramek.m], [(sirka - ramek).m, 0, ramek.m],
                        [(sirka - ramek).m, 0, (vyska - ramek).m], [ramek.m, 0, (vyska - ramek).m])
      ram.reverse! if ram.normal.y > 0      # rám míří ven z fasády (-Y)
      ram.pushpull(ramek.m)
      mat_ram = material(model, 'Ramy', 90, 60, 40)
      e.grep(Sketchup::Face).each { |f| f.material = mat_ram unless f == sklo }
      sklo.material = material(model, 'Sklo', 150, 190, 220, 0.4)
      defn
    end

    # Komponenta dveří: deska 5 cm v rovině XZ (líc ke -Y)
    def self.dvere(model, sirka = 1.0, vyska = 2.1)
      defn = model.definitions['YDPD_Dvere']
      return defn if defn
      defn = model.definitions.add('YDPD_Dvere')
      e = defn.entities
      f = e.add_face([0, 0, 0], [sirka.m, 0, 0], [sirka.m, 0, vyska.m], [0, 0, vyska.m])
      f.reverse! if f.normal.y > 0
      f.pushpull(0.05.m)
      mat = material(model, 'Drevo', 120, 80, 50)
      e.grep(Sketchup::Face).each { |fc| fc.material = mat }
      defn
    end

    def self.run
      model = Sketchup.active_model
      model.start_operation('Domek z komponent', true)   # celý skript = jeden krok Undo

      steny(model)
      strecha(model)

      # okna rovnoměrně na přední fasádě (y = 0)
      d_okno = okno(model)
      tag_okna = tag(model, 'Okna')
      OKNA.times do |i|
        stred = SIRKA * (i + 0.5) / OKNA
        poloha = Geom::Transformation.translation([(stred - 0.5).m, 0, PARAPET.m])
        inst = model.active_entities.add_instance(d_okno, poloha)
        inst.layer = tag_okna
      end

      # dveře na pravém boku (x = SIRKA): otočení o 90° kolem osy Z, pak posun
      d_dvere = dvere(model)
      otoceni = Geom::Transformation.rotation(ORIGIN, Z_AXIS, 90.degrees)
      posun = Geom::Transformation.translation([SIRKA.m, (HLOUBKA / 2 - 0.5).m, 0])
      inst = model.active_entities.add_instance(d_dvere, posun * otoceni)
      inst.layer = tag_okna

      model.commit_operation
      puts "Domek hotový – počet oken: #{OKNA}, dveře: 1."
    rescue StandardError => e
      model.abort_operation if model
      UI.messagebox("Chyba: #{e.message}")
    end

  end
end

YDPD::Domek.run
