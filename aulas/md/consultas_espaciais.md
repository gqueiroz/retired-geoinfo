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
```bash
shp2pgsql -c -g "geom" -s 4674 -i -I -t "2D" -W UTF-8 terras_indigenas.shp public.terras_indigenas > terras_indigenas.sql

psql -U postgres -h localhost -p 5432 -d bdgeo -f terras_indigenas.sql
```


**3.** Unidades de Conservação:
```bash
shp2pgsql -c -g "geom" -s 4674 -i -I -t "2D" -W UTF-8 unidades_conservacao.shp public.unidades_conservacao > unidades_conservacao.sql

psql -U postgres -h localhost -p 5432 -d bdgeo -f unidades_conservacao.sql
```


**4.** Focos de Queimada (2020):
```bash
shp2pgsql -c -g "geom" -s 4326 -i -I -t "2D" -W UTF-8 focos_2020.shp public.focos_2020 > focos_2020.sql

psql -U postgres -h localhost -p 5432 -d bdgeo -f focos_2020.sql
```

**Obs.:** 
- Veja se o atributo com a data de observação (`datahora`) foi importado com o tipo correto: `TIMESTAMP WITHOUT TIME ZONE`. Caso não tenha sido, use o seguinte comando para acertar o tipo da coluna:
```sql
ALTER TABLE focos_2020 ALTER COLUMN datahora TYPE TIMESTAMP WITHOUT TIME ZONE
    USING datahora::timestamp without time zone;
```

- Aproveite e crie um índice sobre a coluna com a data de observação:
```sql
CREATE INDEX idx_focos_2020_datahora ON focos_2020(datahora);
```

- Faça uma reprojeção das geometrias do foco:
```sql
ALTER TABLE focos_2020 ALTER COLUMN geom TYPE GEOMETRY(POINT, 4674)
    USING ST_Transform(geom, 4674);
```


**5.** Focos de Queimada (2017-2018):
```bash
shp2pgsql -c -g "geom" -s 4326 -i -I -t "2D" -W UTF-8 focos_2017_2018.shp public.focos > focos.sql

psql -U postgres -h localhost -p 5432 -d bdgeo -f focos.sql
```

**Obs.:** 
- Veja se o atributo com a data de observação (`data_obser`) foi importado com o tipo correto: `TIMESTAMP WITHOUT TIME ZONE`. Caso não tenha sido, use o seguinte comando para acertar o tipo da coluna:
```sql
ALTER TABLE focos ALTER COLUMN data_obser TYPE TIMESTAMP WITHOUT TIME ZONE
    USING data_obser::timestamp without time zone;
```

- Aproveite e crie um índice sobre a coluna com a data de observação:
```sql
CREATE INDEX idx_focos_data_obser ON focos(data_obser);
```

- Faça uma reprojeção das geometrias do foco:
```sql
ALTER TABLE focos ALTER COLUMN geom TYPE GEOMETRY(POINT, 4674)
    USING ST_Transform(geom, 4674);
```  


**6.** Trechos Rodoviários:
```bash
shp2pgsql -c -g "geom" -s 4674 -i -I -t "2D" -W UTF-8 rod_trecho_rodoviario_l.shp public.trechos_rodoviarios > trechos_rodoviarios.sql

psql -U postgres -h localhost -p 5432 -d bdgeo -f trechos_rodoviarios.sql
```


**7.** Pedologia:
```bash
shp2pgsql -c -g "geom" -s 4674 -i -I -t "2D" -W UTF-8 pedologia_2017.shp public.pedologia > pedologia.sql

psql -U postgres -h localhost -p 5432 -d bdgeo -f pedologia.sql
```


**8.** Biomas:
```bash
shp2pgsql -c -g "geom" -s 4674 -i -I -t "2D" -W UTF-8 biomas.shp public.biomas > biomas.sql

psql -U postgres -h localhost -p 5432 -d bdgeo -f biomas.sql
```
 

## Consultas


### Consultas de Apontamento


**1.** Qual UF encontra-se na localização de longitude `-44.29` e latitude `-18.61`?
```sql
SELECT *
  FROM uf
 WHERE ST_Contains( geom, ST_GeomFromText( 'POINT(-44.29 -18.61)', 4674 ) );
```


### Consultas de Janela ou Intervalo


**1.** Quais UF possuem geometrias com interação com o retângulo de coordenadas: 
- xmin: -54.23
- xmax: -43.89
- ymin: -12.90
- ymax: -21.49
```sql
SELECT *
  FROM uf
 WHERE ST_Intersects(
           geom,
           ST_MakeEnvelope( -54.23, -12.90, -43.89, -21.49, 4674 )
       );
```

Veja também:
```sql
SELECT *
  FROM uf
 WHERE geom && ST_MakeEnvelope( -54.23, -12.90, -43.89, -21.49, 4674 );
```


### Consultas de Proximidade


**1.** Quais os municípios num raio de 2 graus da coordenada:
- longitude: -43.59
- Latitude.: -20.32
```sql
SELECT *
  FROM municipios
 WHERE ST_DWithin(
           geom,
           ST_GeomFromText('POINT(-43.59 -20.32)', 4674),
           2.0
       );
```


### Junção Espacial


**1.** Quais as áreas de terras indígenas no Estado do Tocantins?
```sql
SELECT ti.*
  FROM uf, 
       terras_indigenas AS ti
 WHERE ST_Intersects(uf.geom, ti.geom)
   AND uf.nome = 'TOCANTINS';
```


**2.** Quantos focos de incêndio na vegetação foram detectados em Unidades de Conservação Estaduais do Estado do Tocantins em 2020?

Solução 1:
```sql
     SELECT ucs.nome AS nome,
             COUNT(*) AS total_focos
        FROM focos_2020,
             unidades_conservacao AS ucs,
             uf
       WHERE uf.nome = 'TOCANTINS'
         AND ST_Intersects(uf.geom, ucs.geom)
         AND ucs.jurisdicao = 'Estadual'
         AND ST_Contains(ucs.geom, focos_2020.geom)
    GROUP BY ucs.id, 
             ucs.nome
    ORDER BY total_focos DESC;
```


**3.** Quantos focos de incêndio na vegetação foram detectados mensalmente em Unidades de Conservação Estaduais do Estado do Tocantins ao longo de 2017?

Solução 1:
```sql
      SELECT Extract(month from focos.data_obser) AS mes,
             ucs.nome AS nome,
             COUNT(*) AS total_focos
        FROM focos,
             unidades_conservacao AS ucs,
             uf
       WHERE uf.nome = 'TOCANTINS'
         AND ST_Intersects(uf.geom, ucs.geom)
         AND ucs.jurisdicao = 'Estadual'
         AND ST_Contains(ucs.geom, focos.geom)
         AND Extract(year from focos.data_obser) = 2017
    GROUP BY mes,
             ucs.id, 
             ucs.nome
    ORDER BY mes ASC, total_focos DESC, nome ASC;
```


Solução 2:
```sql
WITH tocantins AS (
    SELECT * FROM uf WHERE nome = 'TOCANTINS'
),
    ucs AS (
    SELECT unidades_conservacao.* 
      FROM unidades_conservacao,
           tocantins
     WHERE unidades_conservacao.jurisdicao = 'Estadual'
       AND ST_Intersects(tocantins.geom, unidades_conservacao.geom)
)
  SELECT Extract(month from focos.data_obser) AS mes,
         ucs.nome AS nome,
         COUNT(*) AS total_focos
    FROM focos,
         ucs
   WHERE ST_Contains(ucs.geom, focos.geom)
     AND Extract(year from focos.data_obser) = 2017
GROUP BY mes,
         ucs.id, 
         ucs.nome
ORDER BY mes ASC, total_focos DESC, nome ASC;
```


**4.** Quantos focos de incêndio ocorreram nas proximidades da rodovia BR-153 no mês de setembro de 2017?
```sql
SELECT COUNT(*) as total_focos FROM
(
SELECT DISTINCT focos.id
  FROM focos,
       trechos_rodoviarios AS trechos
 WHERE ST_DWithin(trechos.geom, focos.geom, 1000.0 / 111000.0)
   AND codtrechor = 'BR-153'
   AND focos.data_obser >= '2017-09-01'
   AND focos.data_obser < '2017-10-01'
) as focos_sel;
```


**5.** Quais os municípios vizinhos de Ouro Preto em Minas Gerais?
```sql
SELECT m2.nome AS vizinho, m2.geom AS geom
  FROM municipios AS m1, 
       municipios AS m2
 WHERE ST_Touches(m1.geom, m2.geom)
   AND m1.nome = 'OURO PRETO'
   AND m2.nome != 'OURO PRETO';
```


### Overlay de Mapas

**1.** Quais os tipos de solo do Estado do Tocantins?
```sql
SELECT pedologia.gid AS gid,
       pedologia.ordem AS ordem,
       ST_Intersection(pedologia.geom, uf.geom) AS geom
  FROM pedologia,
       uf
 WHERE ST_Intersects(uf.geom, pedologia.geom)
   AND uf.nome = 'TOCANTINS';
```


**2.** Qual o tipo de solo predominante em Ouro Preto?
```sql
SELECT ordem,
       SUM( ST_Area( geom::geography ) / 10000.0 ) AS area
  FROM
(       
  SELECT p.ordem as ordem,
         ST_Intersection( m.geom, p.geom ) AS geom         
    FROM municipios AS m,
         pedologia AS p
   WHERE ST_Intersects(m.geom, p.geom)
     AND m.nome = 'OURO PRETO'
) AS solos     
GROUP BY ordem
ORDER BY area DESC LIMIT 1;
````


**3.** Recuperar os trechos de rodovia no Estado do Tocantins com o tipo de revestimento "Pavimentado"?
```sql
SELECT trechos.gid,
       codtrechor,
       ST_Intersection(uf.geom, trechos.geom) AS geom
  FROM uf,
       trechos_rodoviarios AS trechos
 WHERE ST_Intersects(uf.geom, trechos.geom)
   AND trechos.revestimen = 'Pavimentado'
   AND uf.nome = 'TOCANTINS';
```


**4.** Quantos KM de rodovia existem no Estado do Tocantins com o tipo de revestimento "Pavimentado"?
```sql
SELECT SUM(
           ST_Length(
                ST_Intersection(uf.geom, trechos.geom)::geography
           ) / 1000.0
       )
  FROM uf,
       trechos_rodoviarios AS trechos
 WHERE ST_Intersects(uf.geom, trechos.geom)
   AND trechos.revestimen = 'Pavimentado'
   AND uf.nome = 'TOCANTINS';

```


## Agregação Espacial

Gerar o mapa de Regiões do Brasil a partir do mapa de Unidades Federativas.
```sql
CREATE TABLE uf_gerado AS
      SELECT uf.regiao_sig AS sigla,
             ST_Union(uf.geom) AS geom
        FROM uf 
    GROUP BY regiao_sig;
```

Utilizando os dados dos anos de 2017 e 2018 de focos, apresente uma contagem por bioma.
```sql
CREATE TABLE biomas_subdividido AS
   SELECT gid,
          bioma,
          ST_SubDivide(geom, 40) as geom
     FROM biomas;
     

CREATE INDEX spidx_biomas_subdividido_geom ON biomas_subdividido USING GIST(geom);
          

  SELECT biomas.bioma AS bioma,
         COUNT(*) AS total_focos
    FROM focos,
         biomas_subdividido AS biomas
   WHERE ST_Contains(biomas.geom, focos.geom)
GROUP BY biomas.bioma;
```


## Consultas Gerais

**1.** Qual a porcentagem de cada bioma em relação à extensão do Brasil?
```sql
WITH area_brasil AS
    ( SELECT SUM(ST_Area(geom::geography)) AS area
        FROM biomas )
  SELECT biomas.bioma,
         ST_Area(geom::geography) / area_brasil.area * 100.0 AS "area(%)"
    FROM biomas,
         area_brasil
ORDER BY 2;
```

**2.** Gerar o mapa de regiões do Brasil a partir do mapa de Unidades Federativas.
```sql
CREATE TABLE regioes AS
    SELECT ROW_NUMBER () OVER (PARTITION BY regiao_sig) as gid,
           regiao AS nome,
           regiao_sig AS sigla,
           ST_Union(geom) as geom
      FROM uf
  GROUP BY regiao_sig,
           regiao;
```

