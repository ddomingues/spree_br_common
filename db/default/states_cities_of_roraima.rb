roraima = Spree::State.find_by! abbr: 'RR'

Spree::City.create!([
    {state: roraima, ibge_code: 1400159, name: "Bonfim"},
    {state: roraima, ibge_code: 1400605, name: "São Luiz"},
    {state: roraima, ibge_code: 1400472, name: "Rorainópolis"},
    {state: roraima, ibge_code: 1400100, name: "Boa Vista"},
    {state: roraima, ibge_code: 1400050, name: "Alto Alegre"},
    {state: roraima, ibge_code: 1400027, name: "Amajari"},
    {state: roraima, ibge_code: 1400456, name: "Pacaraima"},
    {state: roraima, ibge_code: 1400175, name: "Cantá"},
    {state: roraima, ibge_code: 1400407, name: "Normandia"},
    {state: roraima, ibge_code: 1400704, name: "Uiramutã"},
    {state: roraima, ibge_code: 1400282, name: "Iracema"},
    {state: roraima, ibge_code: 1400308, name: "Mucajaí"},
    {state: roraima, ibge_code: 1400233, name: "Caroebe"},
    {state: roraima, ibge_code: 1400506, name: "São João da Baliza"},
    {state: roraima, ibge_code: 1400209, name: "Caracaraí"}
])