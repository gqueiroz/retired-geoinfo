# Consultas Espaciais


## Carregando Dados


### Preparando o Terminal do Windows


Inclua o caminho dos aplicativos instalados pelo PostgreSQL e PostGIS na variável de ambiente `PATH` para que os aplicativos possam ser chamados na linha de comando do Windows:

```bash
SET PATH=%PATH%;C:\Program Files\PostgreSQL\11\bin
```


### Preparando o Terminal do macOS

Se você tiver instalado a versão 11 do PostgreSQL através da distribuição `Postgres.app` e quiser usar o terminal de comandos, sugerimos incluir o caminho dos aplicativos de linha de comando na sua variável `PATH`:
```bash
export PATH="$PATH:/Applications/Postgres.app//Contents/Versions/11/bin/"
```


### Importando arquivos ESRI Shapefile

Para transformar um arquivo ESRI Shapefile numa sequência de comandos SQL com instruções para criação de uma tabela com coluna geométrica, inserção de linhas (features) e criação do índice espacial, podemos utilizar o comando `shp2pgsql` no terminal de comando do sistema operacional.

Com ajuda do aplicativo `shp2pgsql`, vamos converter o arquivo contendo as Unidades da Federação:
```bash
shp2pgsql -c -g "geom" -s 4674 -i -I -t "2D" -W UTF-8 uf_2018.shp public.uf > uf.sql
```


O comando acima irá gerar um arquivo denominado `uf.sql` contendo as instruções SQL para criação e carga de dados de uma tabela com o nome `uf` no esquema `public`. Para fazer a carga dos dados, utilize o aplicativo de linha de comando `psql`, que irá ler as instruções do arquivo `uf.sql` e irá enviar ao servidor PostgreSQL:
```bash
psql -U postgres -h localhost -p 5432 -d bdgeo -f uf.sql
```


Para carregar os demais dados, utilize os comandos abaixo: 

**1.** Carregando os dados dos municípios brasileiros:
```bash
shp2pgsql -c -g "geom" -s 4674 -i -I -t "2D" -W UTF-8 municipios_2018.shp public.municipios > municipios.sql

psql -U postgres -h localhost -p 5432 -d bdgeo -f municipios.sql
```


**2.** Terras Indígenas:


**3.** Unidades de Conservação:


**4.** Focos de Queimada (2019):


**5.** Focos de Queimada (2017-2018):


**6.** Trechos Rodoviários:


**7.** Pedologia:


**8.** Biomas:
 

## Consultas


### Consultas de Apontamento


**1.** Qual UF encontra-se na localização de longitude `-44.29` e latitude `-18.61`?
```sql
```


### Consultas de Janela ou Intervalo


**1.** Quais UF possuem geometrias com interação com o retângulo de coordenadas: 
- xmin: -54.23
- xmax: -43.89
- ymin: -12.90
- ymax: -21.49
```sql
```


### Consultas de Proximidade


**1.** Quais os municípios num raio de 2 graus da coordenada:
- longitude: -43.59
- Latitude.: -20.32
```sql
```


### Junção Espacial


**1.** Quais as áreas de terras indígenas no Estado do Tocantins?
```sql
```


**2.** Quantos focos de incêndio na vegetação foram detectados em Unidades de Conservação Estaduais do Estado do Tocantins em 2019?
```sql
```


**3.** Quantos focos de incêndio na vegetação foram detectados mensalmente em Unidades de Conservação Estaduais do Estado do Tocantins ao longo de 2017?
```sql
```


**4.** Quantos focos de incêndio ocorreram nas proximidades da rodovia BR-153 no mês de setembro de 2017?
```sql
```


**5.** Quais os municípios vizinhos de Ouro Preto em Minas Gerais?
```sql
```


### Overlay de Mapas

**1.** Quais os tipos de solo do Estado do Tocantins?
```sql
```


**2.** Qual o tipo de solo predominante em Ouro Preto?
```sql
````


**3.** Recuperar os trechos de rodovia no Estado do Tocantins com o tipo de revestimento "Pavimentado"?
```sql
```


**4.** Quantos KM de rodovia existem no Estado do Tocantins com o tipo de revestimento "Pavimentado"?
```sql
```


## Agregação Espacial

Gerar o mapa de Regiões do Brasil a partir do mapa de Unidades Federativas.
```sql
```

Utilizando os dados dos anos de 2017 e 2018 de focos, apresente uma contagem por bioma.
```sql
```


## Consultas Gerais

**1.** Qual a porcentagem de cada bioma em relação à extensão do Brasil?
```sql
```

**2.** Gerar o mapa de regiões do Brasil a partir do mapa de Unidades Federativas.
```sql
```

