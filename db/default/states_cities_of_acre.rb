acre = Spree::State.find_by! abbr: 'AC'

Spree::City.create!([
    {state:acre, ibge_code:1200054, name: 'Assis Brasil'},
    {state:acre, ibge_code:1200252, name: 'Epitaciolândia'},
    {state:acre, ibge_code:1200344, name: 'Manoel Urbano'},
    {state:acre, ibge_code:1200179, name: 'Capixaba'},
    {state:acre, ibge_code:1200807, name: 'Porto Acre'},
    {state:acre, ibge_code:1200708, name: 'Xapuri'},
    {state:acre, ibge_code:1200203, name: 'Cruzeiro do Sul'},
    {state:acre, ibge_code:1200336, name: 'Mâncio Lima'},
    {state:acre, ibge_code:1200351, name: 'Marechal Thaumaturgo'},
    {state:acre, ibge_code:1200393, name: 'Porto Walter'},
    {state:acre, ibge_code:1200427, name: 'Rodrigues Alves'},
    {state:acre, ibge_code:1200328, name: 'Jordão'},
    {state:acre, ibge_code:1200609, name: 'Tarauacá'},
    {state:acre, ibge_code:1200435, name: 'Santa Rosa do Purus'},
    {state:acre, ibge_code:1200500, name: 'Sena Madureira'},
    {state:acre, ibge_code:1200013, name: 'Acrelândia'},
    {state:acre, ibge_code:1200138, name: 'Bujari'},
    {state:acre, ibge_code:1200385, name: 'Plácido de Castro'},
    {state:acre, ibge_code:1200401, name: 'Rio Branco'},
    {state:acre, ibge_code:1200450, name: 'Senador Guiomard'},
    {state:acre, ibge_code:1200104, name: 'Brasiléia'},
    {state:acre, ibge_code:1200302, name: 'Feijó'}
])
