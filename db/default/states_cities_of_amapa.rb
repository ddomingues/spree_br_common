amapa = Spree::State.find_by! abbr: 'AP'

Spree::City.create!([
  {state: amapa, ibge_code: 1600279, name: "Laranjal do Jari"},
  {state: amapa, ibge_code: 1600154, name: "Pedra Branca do Amapari"},
  {state: amapa, ibge_code: 1600709, name: "Tartarugalzinho"},
  {state: amapa, ibge_code: 1600212, name: "Cutias"},
  {state: amapa, ibge_code: 1600238, name: "Ferreira Gomes"},
  {state: amapa, ibge_code: 1600253, name: "Itaubal"},
  {state: amapa, ibge_code: 1600303, name: "Macapá"},
  {state: amapa, ibge_code: 1600535, name: "Porto Grande"},
  {state: amapa, ibge_code: 1600600, name: "Santana"},
  {state: amapa, ibge_code: 1600402, name: "Mazagão"},
  {state: amapa, ibge_code: 1600808, name: "Vitória do Jari"},
  {state: amapa, ibge_code: 1600501, name: "Oiapoque"},
  {state: amapa, ibge_code: 1600105, name: "Amapá"},
  {state: amapa, ibge_code: 1600550, name: "Pracuúba"},
  {state: amapa, ibge_code: 1600055, name: "Serra do Navio"},
  {state: amapa, ibge_code: 1600204, name: "Calçoene"}
])