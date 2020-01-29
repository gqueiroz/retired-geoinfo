# Dados Curso

Este documento descreve os dados utilizados nas aulas de bancos de dados geográficos e geo web services do curso de verão em Geoinformática e Geospatial Data Science. Curso realizado no Instituto Nacional de Pesquisas Espaciais (INPE) em Janeiro de 2020.


O conjunto de dados descrito neste documento consiste em dados estatísticos e espaciais do tipo vetorial adaptados de bases de dados governamentais. Para obter os dados preparados para as atividades em aula, acesse o endereço fornecido em seu e-mail.


As bases de dados oficiais encontram-se disponíveis em portais Web das seguintes instituições governamentais: [INPE](http://www.inpe.br/#), [IBGE](https://ibge.gov.br/#) e [FUNAI](http://www.funai.gov.br/#). Para mais informações sobre os dados oficiais acesse: [Fonte de Dados](./dados.md).

### Focos de Incêndio

Os seguintes conjuntos de dados encontram-se disponíveis na página do curso, codificados em UTF-8, projeção geográfica `LAT/LONG` e sistema geodésico de referência `WGS84` :

  - `focos_2020.zip`: Ocorrências de fogo na vegetação entre o dia 01 de janeiro e 25 de janeiro de 2020. Versão extraída diretamente do BDQueimadas, com 38.793 feiçoes, com geometrias do tipo `Point`.


### Divisão Político-Administrativa Brasileira

Os seguintes arquivos no formato [ESRI Shapefile](https://en.wikipedia.org/wiki/Shapefile) contém a divisão político-administrativa brasileira, no ano de referência 2018, escala `1:250.000`, projeção geográfica `LAT/LONG` e sistema geodésico de referência `SIRGAS 2000`:

  - `uf_2018.zip`: Unidades da Federação. Contém 27 feições, com geometrias do tipo `MultiPolygon`.

  - `municipios_2018.zip`: Municípios. Contém 5.572 feições, com geometrias do tipo `MultiPolygon`.


A codificação de caracteres utilizada nesses arquivos é a `UTF-8`. O código do sistema de referência espacial no PostGIS equivalente ao empregado para esses dados é o `4674`.

### Base Cartográfica Contínua do Brasil

Os seguintes arquivos no formato [ESRI Shapefile](https://en.wikipedia.org/wiki/Shapefile) contém informações da base cartográfica contínua do Brasil, referentes ao ano de 2019, escala `1:250.000`, projeção geográfica `LAT/LONG` e sistema geodésico de referência `SIRGAS 2000`:

  - `rod_trecho_rodoviario_l.zip`: Trechos rodoviários. Contém 153.177 feições, com geometrias do tipo `LineString`.

  - `hid_trecho_drenagem_l.zip`: Trechos de drenagem. Contém 1.685.980 feições, com geometrias do tipo `LineString`.


A codificação de caracteres utilizada nesses arquivos é a `UTF-8`. Além disso, o código do sistema de referência espacial no PostGIS é o `4674`.


### Informações Ambientais

Os dados desta seção utilizam a codificação de caracteres `UTF-8`, projeção georáfica `LAT/LONG` e sistema geodésico de referência `SIRGAS 2000` (código 4674 do PostGIS):

- `biomas.zip`: Biomas do Brasil: Amazônia, Cerrado, Caatinga, Mata Atlântica, Pantanal e Pampa. Contém 06 feições, com geoemetrias do tipo `MultiPolygon`. Os dados encontram-se na escala `1:5.000.000`.

- `pedologia_2017.zip`: Mapa pedológico, versão 2017, escala `1:250.000`. Contém 113.907 feições, com geometrias do tipo `Polygon`.


### Terras Indígenas

A codificação de caracteres utilizada é `UTF-8`. Utiliza-se a projeção geográfica `LAT/LONG` e sistema geodésico de referência `SIRGAS 2000`:

  - `terras_indigenas.zip`: Terras Indígenas: Declarada, Delimitada, Em Estudo, Encaminhada RI, Homologada e Regularizada. Contém 616 feições, com geometrias do tipo `MultiPolygon`.
