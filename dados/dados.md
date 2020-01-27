# Fonte de Dados Oficiais

Esta seção descreve os dados oficiais disponibilizados pelas instituições governamentais: [INPE](http://www.inpe.br/#), [IBGE](https://ibge.gov.br/#) e [FUNAI](http://www.funai.gov.br/#), que foram adaptados para utilização ao longo do curso de verão em Geoinformática e Geospatial Data Science. Na medida do possível, tentamos manter os links originais das fontes de dados.

## INPE

O Programa Queimadas do Instituto Nacional de Pesquisas Espaciais (INPE) realiza o monitoramento da ocorrência do fogo na vegetação. O acervo de dados de ocorrência encontra-se disponível através do aplicativo [BDQueimadas](http://queimadas.dgi.inpe.br/queimadas/bdqueimadas#).


## IBGE

Maiores informações sobre os arquivos desta seção podem ser encontrados no site de [Geociências](https://www.ibge.gov.br/geociencias/downloads-geociencias.html) ou  [Estatísticas](https://www.ibge.gov.br/estatisticas/sociais/populacao/9103-estimativas-de-populacao.html?edicao=22367&t=resultados) do IBGE. (Acesso: 04 de Janeiro de 2020)


### Divisão Político-Administrativa Brasileira

Os seguintes arquivos no formato [ESRI Shapefile](https://en.wikipedia.org/wiki/Shapefile) contém a divisão político-administrativa brasileira, no ano de referência 2018, escala `1:250.000`, projeção geográfica `LAT/LONG` e sistema geodésico de referência `SIRGAS 2000`:

  - [`br_unidades_da_federacao.zip`](ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2018/Brasil/BR/br_unidades_da_federacao.zip): Unidades da Federação. Contém 27 feições, com geometrias do tipo `MultiPolygon`.

  - [`br_mesorregioes.zip`](ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2018/Brasil/BR/br_mesorregioes.zip): Mesorregiões. Contém 139 feições, com geometrias do tipo `MultiPolygon`.

  - [`br_microrregioes.zip`](ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2018/Brasil/BR/br_microrregioes.zip): Microrregiões. Contém 560 feições, com geometrias do tipo `MultiPolygon`.

  - [`br_municipios.zip`](ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2018/Brasil/BR/br_municipios.zip): Municípios. Contém 5.572 feições, com geometrias do tipo `MultiPolygon`.


A codificação de caracteres utilizada nesses arquivos é a `UTF-8`. O código do sistema de referência espacial no PostGIS equivalente ao empregado para esses dados é o `4674`.


### Base Cartográfica Contínua do Brasil

Os seguintes arquivos no formato [ESRI Shapefile](https://en.wikipedia.org/wiki/Shapefile) contém informações da base cartográfica contínua do Brasil, referentes ao ano de 2019, escala `1:250.000`, projeção geográfica `LAT/LONG` e sistema geodésico de referência `SIRGAS 2000`:

  - [`rod_trecho_rodoviario_l.zip`](ftp://geoftp.ibge.gov.br/cartas_e_mapas/bases_cartograficas_continuas/bc250/versao2019/shapefile/bc250_shapefile_06_11_2019.zip): Trechos rodoviários. Contém 153.177 feições, com geometrias do tipo `LineString`.

  - [`hid_trecho_drenagem_l.zip`](ftp://geoftp.ibge.gov.br/cartas_e_mapas/bases_cartograficas_continuas/bc250/versao2019/shapefile/bc250_shapefile_06_11_2019.zip): Trechos de drenagem. Contém 1.685.980 feições, com geometrias do tipo `LineString`.


A codificação de caracteres utilizada nesses arquivos é a `UTF-8`. Além disso, o código do sistema de referência espacial no PostGIS é o `4674`.

**Fonte:** [IBGE/DGC](https://www.ibge.gov.br/geociencias/downloads-geociencias.html). Base Cartográfica Contínua do Brasil, escala 1:250.000 – BC250:
versão 2019. Rio de Janeiro, 2019. Acesso: 04 de Janeiro de 2020.


### Informações Ambientais

Os dados desta seção utilizam a codificação de caracteres `UTF-8`, projeção georáfica `LAT/LONG` e sistema geodésico de referência `SIRGAS 2000` (código 4674 do PostGIS):

- [`Biomas_250mil.zip`](ftp://geoftp.ibge.gov.br/informacoes_ambientais/estudos_ambientais/biomas/vetores/Biomas_250mil.zip): Biomas do Brasil: Amazônia, Cerrado, Caatinga, Mata Atlântica, Pantanal e Pampa. Contém 06 feições, com geoemetrias do tipo `MultiPolygon`. Os dados encontram-se na escala `1:5.000.000`.

- [`Brasil_geol_area.zip`](ftp://geoftp.ibge.gov.br/informacoes_ambientais/geologia/levantamento_geologico/vetores/escala_250_mil/versao_2017/brasil/Brasil_geol_area.zip): Mapa geológico, versão 2017, escala `1:250.000`. Contém 128.897 feições, com geometrias do tipo `Polygon`.

- [`Brasil_geom_area.zip`](ftp://geoftp.ibge.gov.br/informacoes_ambientais/geomorfologia/vetores/escala_250_mil/versao_2017/brasil/Brasil_geom_area.zip): Mapa geomorfológico, versão 2017, escala `1:250.000`. Contém 120.252 feições, com geometrias do tipo `Polygon`.

- [`Brasil_pedo_area.zip`](ftp://geoftp.ibge.gov.br/informacoes_ambientais/pedologia/vetores/escala_250_mil/versao_2017/brasil/Brasil_pedo_area.zip): Mapa pedológico, versão 2017, escala `1:250.000`. Contém 113.907 feições, com geometrias do tipo `Polygon`.

- [`Brasil_vege_area.zip`](ftp://geoftp.ibge.gov.br/informacoes_ambientais/vegetacao/vetores/escala_250_mil/versao_2017/brasil/Brasil_vege_area.zip): Mapa de vegetação, versão 2017, escala `1:250.000`. Contém 144.608 feições, com geometrias do tipo `Polygon`.


## Informações Estatísticas Municipais

 Estimativas da população: Tabelas de estimativas populacionais para os municípios e para as Unidades da Federação brasileiros em 01.07.2018:

- [`estimativa_TCU_2017_20190919.ods`](ftp://ftp.ibge.gov.br/Estimativas_de_Populacao/Estimativas_2017/estimativa_TCU_2017_20190919.ods): Estimativas de população enviadas ao TCU.

**Fonte:** [IBGE/DESP](https://www.ibge.gov.br/estatisticas/sociais/populacao/9103-estimativas-de-populacao.html?edicao=16985&t=resultados). Acesso: 04 de Janeiro de 2020.

- [`base_de_dados_2010_2017_ods.zip`](https://www.ibge.gov.br/estatisticas/economicas/contas-nacionais/9088-produto-interno-bruto-dos-municipios.html?=&t=downloads): Produto Interno Bruto dos Municípios (base de dados 2010-2017)

**Fonte:** [IBGE/DECN](https://www.ibge.gov.br/estatisticas/economicas/contas-nacionais/9088-produto-interno-bruto-dos-municipios.html?=&t=downloads). Acesso: 04 de Janeiro de 2020.


## FUNAI


### Terras Indígenas

Os seguintes arquivos no formato [ESRI Shapefile](https://en.wikipedia.org/wiki/Shapefile) contém informações da base cartográfica da FUNAI relativa às áreas de [Terras Indígenas](http://www.funai.gov.br/index.php/indios-no-brasil/terras-indigenas). A codificação de caracteres utilizada é `LATIN1`. Utiliza-se a projeção geográfica `LAT/LONG` e sistema geodésico de referência `SIRGAS 2000`:

  - [`ti_sirgas.zip`](http://geoserver.funai.gov.br/geoserver/Funai/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=Funai:ti_sirgas&outputFormat=SHAPE-ZIP): Terras Indígenas: Declarada, Delimitada, Em Estudo, Encaminhada RI, Homologada e Regularizada. Contém 616 feições, com geometrias do tipo `MultiPolygon`.

  - [`ti_estudo.zip`](http://geoserver.funai.gov.br/geoserver/Funai/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=Funai:tis_estudo&outputFormat=SHAPE-ZIP): Terras Indígenas em Estudo (Área em Estudo).


**Fonte:** [Fundação Nacional do Índio](http://www.funai.gov.br/index.php/shape). Acesso: 04 de Janeiro de 2020.


## MMA


### Unidades de Conservação e Biomas

Os dados listados nesta seção encontram-se disponíveis para download no formato [ESRI Shapefile](https://en.wikipedia.org/wiki/Shapefile) a partir do [sitio do MMA](http://mapas.mma.gov.br/i3geo/datadownload.htm):

  - `amazlegal.zip`: Limite da Amazônia Legal. Contém uma única feição, com geometria do tipo `MultiPolygon`. Você pode baixar os arquivos originais a partir dos seguintes links: [`amazlegal.shp`](http://mapas.mma.gov.br/ms_tmp/amazlegal.shp), [`amazlegal.shx`](http://mapas.mma.gov.br/ms_tmp/amazlegal.shx) e [`amazlegal.dbf`](http://mapas.mma.gov.br/ms_tmp/amazlegal.dbf). Este dado encontra-se na projeção georáfica `LAT/LONG` e sistema geodésico de referência `SAD 69` (código 4618 do PostGIS).

  - `bioma.zip`: Biomas do Brasil: Amazônia, Cerrado, Caatinga, Mata Atlântica, Pantanal e Pampa. Contém 06 feições, com geoemetrias do tipo `MultiPolygon`. Os arquivos individuais encontram-se em: [bioma.shp](http://mapas.mma.gov.br/ms_tmp/bioma.shp), [bioma.shx](http://mapas.mma.gov.br/ms_tmp/bioma.shx) e [bioma.dbf](http://mapas.mma.gov.br/ms_tmp/bioma.dbf). Segundo o [sitio do MMA](http://mapas.mma.gov.br/geonetwork/srv/br/metadata.show?id=298), os dados encontram-se na escala `1:5.000.000`, utilizando a codificação de caracteres `LATIN1`, projeção georáfica `LAT/LONG` e sistema geodésico de referência `SAD 69` (código 4618 do PostGIS).

  - `ucstodas.zip`: Unidades de conservação federais, estudais e municipais. Contém 1.934 feições, com geometrias do tipo `MultiPolygon`. Os arquivos originais encontram-se em: [ucstodas.shp](http://mapas.mma.gov.br/ms_tmp/ucstodas.shp), [ucstodas.shx](http://mapas.mma.gov.br/ms_tmp/ucstodas.shx) e [ucstodas.dbf](http://mapas.mma.gov.br/ms_tmp/ucstodas.dbf). Segundo o [sitio do MMA](http://mapas.mma.gov.br/geonetwork/srv/br/metadata.show?id=1250), os dados encontram-se em escalas que variam de `1:5.000` a `1:100.000`, utilizando a codificação de caracteres `LATIN1`, projeção georáfica `LAT/LONG` e sistema geodésico de referência `SAD 69` (código 4618 do PostGIS).
