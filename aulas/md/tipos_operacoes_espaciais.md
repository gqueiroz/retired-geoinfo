# Tipos Geométricos e Operações Espaciais


## Carregando a Extensão PostGIS


**1.** Para criar um novo banco de dados no PostgreSQL:
```sql
CREATE DATABASE bdgeo TEMPLATE template1;
```


**2.** Para carregar a extensão PostGIS no banco de dados criado:
```sql
CREATE EXTENSION postgis;
``` 


**3.** Para saber as configurações da sua extensão PostGIS, utilize a função `postgis_full_version`:
```sql
SELECT postgis_full_version();
```


## PostGIS Geometry

### Well-Known Text (WKT)

**1.** Exemplo da representação geométrica para um ponto de coordenadas `x = 1` e `y = 8`:

```sql
SELECT ST_GeomFromText('POINT(1 8)');
```


**2.** Representação de uma linha definida a partir de três vértices:
```sql
SELECT ST_GeomFromText('LINESTRING(1 5, 3 6, 4 5)');
```


**3.** Representação de um polígono simples com um anel externo e um anel interno:
```sql
SELECT ST_GeomFromText('POLYGON( (1 1, 2 3, 5 4, 5 1, 1 1),
                                 (3 2, 4 3, 4 2, 3 2) )');
```


**4.** Representação de uma coleção de pontos:
```sql
SELECT ST_GeomFromText('MULTIPOINT(1 8, 3 7, 4 9, 2 9)');
```


**5.** Representação de uma coleção de linhas:
```sql
SELECT ST_GeomFromText('MULTILINESTRING( (1 2, 3 3, 4 2),
                                         (4 3, 6 2) )');
```


**6.** Representação de uma coleção de polígonos:
```sql
SELECT ST_GeomFromText('MULTIPOLYGON( ( (1 4, 2 6, 4 5, 3 4, 1 4) ),
                                      ( (1 1, 2 3, 5 4, 5 1, 1 1),
                                        (3 2, 4 3, 4 2, 3 2) ) )');
```


### Operadores Métricos

**1.** Qual a área do polígono abaixo?

```sql
SELECT ST_Area(
           'POLYGON( (1 1, 2 3, 5 4, 5 1, 1 1),
                     (3 2, 4 3, 4 2, 3 2) )' 
       );
```


**2.** Qual o perímetro do polígono abaixo?

```sql
SELECT ST_Perimeter(
           ST_GeomFromText(
               'POLYGON( (1 1, 2 3, 5 4, 5 1, 1 1),
                         (3 2, 4 3, 4 2, 3 2) )' 
           )
       );
```


**3.** Qual o comprimento da linha mostrada na figura abaixo?

```sql
SELECT ST_Length( 'LINESTRING( 1 2, 3 3, 4 2 )' );
```


**4.** Qual a distância entre as geometrias A e B?

```sql
SELECT ST_Distance(
           'LINESTRING( 1 5, 3 6, 4 5 )',
           'POLYGON( (1 1, 2 3, 5 4, 5 1, 1 1),
                     (3 2, 4 3, 4 2, 3 2) )'
       );
```


### Operadores Conjunto

### `ST_Intersection`: computando a geometria de intersecção entre outras duas geometrias

**Caso 1:**
```sql
SELECT ST_AsText(
           ST_Intersection(
               ST_GeomFromText( 'POLYGON( (2 2, 2 4, 5 4, 5 2, 2 2) )' ),
               ST_GeomFromText( 'POLYGON( (4 1, 4 3, 7 3, 7 1, 4 1) )' )
           )
       );
```


A mesma consulta poderia ser construída da seguinte forma:
```sql
WITH red AS (
         SELECT ST_GeomFromText(
                  'POLYGON( (2 2, 2 4, 5 4, 5 2, 2 2) )') as geom
), blue AS (
         SELECT ST_GeomFromText(
                  'POLYGON( (4 1, 4 3, 7 3, 7 1, 4 1) )') as geom
)
SELECT ST_Intersection((SELECT * FROM red), (SELECT * FROM blue));
```


Ou:
```sql
WITH my_geometries(red, blue) AS (
         values( ST_GeomFromText( 'POLYGON( (2 2, 2 4, 5 4, 5 2, 2 2) )' ),
                 ST_GeomFromText( 'POLYGON( (4 1, 4 3, 7 3, 7 1, 4 1) )' ) )
)
SELECT ST_Intersection(red, blue)
  FROM my_geometries;

```


**Caso 2:**
```sql
SELECT ST_AsText(
           ST_Intersection(
               ST_GeomFromText( 'POLYGON( (2 5, 2 7, 5 7, 5 5, 2 5) )' ),
               ST_GeomFromText( 'POLYGON( (5 5, 5 7, 8 7, 8 5, 5 5) )' )
           )
       );
```


**Caso 3:**
```sql
SELECT ST_AsText(
           ST_Intersection(
               ST_GeomFromText( 'POLYGON( (9 2, 9 4, 11 4, 11 2, 9 2) )' ),
               ST_GeomFromText( 'POLYGON( (12 1, 12 3, 15 3, 15 1, 12 1) )' )
           )
       );
```


### `ST_Union`: Computando a geometria formada pela união de outras duas geometrias

**Caso 1:**
```sql
SELECT ST_AsText(
           ST_Union(
               ST_GeomFromText( 'POLYGON( (2 2, 2 4, 5 4, 5 2, 2 2) )' ),
               ST_GeomFromText( 'POLYGON( (4 1, 4 3, 7 3, 7 1, 4 1) )' )
           )
       );
```


**Caso 2:**
```sql
SELECT ST_AsText(
           ST_Union(
               ST_GeomFromText( 'POLYGON( (2 5, 2 7, 5 7, 5 5, 2 5) )' ),
               ST_GeomFromText( 'POLYGON( (5 5, 5 7, 8 7, 8 5, 5 5) )' )
           )
       );
```


**Caso 3:**
```sql
SELECT ST_AsText(
           ST_Union(
               ST_GeomFromText( 'POLYGON( (9 2, 9 4, 11 4, 11 2, 9 2) )' ),
               ST_GeomFromText( 'POLYGON( (12 1, 12 3, 15 3, 15 1, 12 1) )' )
           )
       );
```


### `ST_Difference`: Computando a geometria formada pela diferença entre a geometria A e a geometria B

**Caso 1:**
```sql
SELECT ST_AsText(
           ST_Difference(
               ST_GeomFromText( 'POLYGON( (2 2, 2 4, 5 4, 5 2, 2 2) )' ),
               ST_GeomFromText( 'POLYGON( (4 1, 4 3, 7 3, 7 1, 4 1) )' )
           )
       );
```


**Caso 2:**
```sql
SELECT ST_AsText(
           ST_Difference(
               ST_GeomFromText( 'POLYGON( (2 5, 2 7, 5 7, 5 5, 2 5) )' ),
               ST_GeomFromText( 'POLYGON( (5 5, 5 7, 8 7, 8 5, 5 5) )' )
           )
       );
```


**Caso 3:**
```sql
SELECT ST_AsText(
           ST_Difference(
               ST_GeomFromText( 'POLYGON( (9 2, 9 4, 11 4, 11 2, 9 2) )' ),
               ST_GeomFromText( 'POLYGON( (12 1, 12 3, 15 3, 15 1, 12 1) )' )
           )
       );
```


### `ST_SymDifference`: Computando a geometria formada pela diferença simétrica entre duas geometrias

**Caso 1:**
```sql
SELECT ST_AsText(
           ST_SymDifference(
               ST_GeomFromText( 'POLYGON( (2 2, 2 4, 5 4, 5 2, 2 2) )' ),
               ST_GeomFromText( 'POLYGON( (4 1, 4 3, 7 3, 7 1, 4 1) )' )
           )
       );
```


**Caso 2:**
```sql
SELECT ST_AsText(
           ST_SymDifference(
               ST_GeomFromText( 'POLYGON( (2 5, 2 7, 5 7, 5 5, 2 5) )' ),
               ST_GeomFromText( 'POLYGON( (5 5, 5 7, 8 7, 8 5, 5 5) )' )
           )
       );
```


**Caso 3:**
```sql
SELECT ST_AsText(
           ST_SymDifference(
               ST_GeomFromText( 'POLYGON( (9 2, 9 4, 11 4, 11 2, 9 2) )' ),
               ST_GeomFromText( 'POLYGON( (12 1, 12 3, 15 3, 15 1, 12 1) )' )
           )
       );
```


### Operações Geração Geometrias

**1.** Retângulo envolvente da geometria:
```sql
SELECT ST_Envelope( ST_GeomFromText(
           'POLYGON( (1 1, 2 3, 5 4, 5 1, 1 1),
                     (3 2, 4 3, 4 2, 3 2) )' 
       ));
```


**2.** Retângulo envolvente da geometria:
```sql
SELECT ST_Extent(
           'POLYGON( (1 1, 2 3, 5 4, 5 1, 1 1),
                     (3 2, 4 3, 4 2, 3 2) )' 
       );
```


**3.** Área de influência ou buffer:
```sql
SELECT ST_AsText(
           ST_Buffer(
               'POLYGON( (6 3, 6 5, 9 5, 9 3, 6 3) )',
               2.0
           ) 
       );
```


### Relacionamentos Espaciais

#### Operador `ST_Relate`

**Caso 1:**
```sql
SELECT ST_Relate(
           ST_GeomFromText( 'POLYGON( (1 1, 1 3, 5 3, 5 1, 1 1) )' ),
           ST_GeomFromText( 'POLYGON( (3 2, 3 4, 5 4, 5 2, 3 2) )' )
       );
```


**Caso 2:**
```sql
SELECT ST_Relate(
           ST_GeomFromText( 'POLYGON( (1 5, 1 7, 3 7, 3 5, 1 5) )' ),
           ST_GeomFromText( 'POLYGON( (3 6, 3 7, 7 7, 7 6, 3 6) )' )
       );
```


**Caso 3:**
```sql
SELECT ST_Relate(
           ST_GeomFromText( 'POLYGON( (7 1, 7 3, 9 3, 9 1, 7 1) )' ),
           ST_GeomFromText( 'POINT( 8 3 )' )
       );
```


**Caso 4:**
```sql
SELECT ST_Relate(
           ST_GeomFromText( 'POLYGON( (9 5, 9 7, 11 7, 11 5, 9 5) )' ),
           ST_GeomFromText( 'LINESTRING( 10 8, 10 6, 13 6 )' )
       );
```


**Caso 5:**
```sql
SELECT ST_Relate(
           ST_GeomFromText( 'LINESTRING( 11 2, 13 4, 15 2 )' ),
           ST_GeomFromText( 'LINESTRING( 12 3, 12 1, 15 1 )' )
       );
```


**Caso 6:**
```sql
SELECT ST_Relate(
           ST_GeomFromText( 'POLYGON( (1 1, 1 3, 3 3, 3 1, 1 1) )' ),
           ST_GeomFromText( 'POINT( 2 2 )' ),
           'T*T***F**'
       );
```


**Caso 7:**
```sql
SELECT ST_Relate(
           ST_GeomFromText( 'LINESTRING( 5 5, 5 3, 3 3, 3 1, 1 1 )' ),
           ST_GeomFromText( 'LINESTRING( 6 4, 6 3, 7 3, 7 1 )' ),
           'T*T***F**'
       );
```


#### Relacionamentos Espaciais Nomeados


##### `ST_Equals`: as geometrias A e B são iguais?
```sql
SELECT ST_Equals(
           ST_GeomFromText( 'POLYGON( ( 1 1, 1 5, 5 5, 5 1, 1 1 ) )' ),
           ST_GeomFromText( 'POLYGON( (5 3, 5 5, 3 5, 1 5, 1 3, 1 1, 3 1, 5 1, 5 3 ) )' )
       );
```

##### `ST_Disjoint`: as geometrias A e B são disjuntas?

**Caso 1:**
```sql
SELECT ST_Disjoint(
           ST_GeomFromText( 'LINESTRING( 1.5 5, 3 5, 4 6, 6 5 )' ),
           ST_GeomFromText( 'LINESTRING( 1 6, 1 4, 4 4 )' )
       );
```


**Caso 2:**
```sql
SELECT ST_Disjoint(
           ST_GeomFromText( 'POLYGON( ( 1 1, 1 2, 3 2, 3 1, 1 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 3 3, 5 3, 5 2, 3 2, 3 3 ) )' )
       );
```


##### `ST_Touches`: a geometria A toca a geometria B?

**Caso 1:**
```sql
SELECT ST_Touches(
           ST_GeomFromText( 'LINESTRING( 1 7, 1 9, 3 9 )' ),
           ST_GeomFromText( 'LINESTRING( 1 9, 3 7 )' )
       );
```


**Caso 2:**
```sql
SELECT ST_Touches(
           ST_GeomFromText( 'LINESTRING( 1 4, 2 6 )' ),
           ST_GeomFromText( 'LINESTRING( 2 6, 3 4 )' )
       );
```


**Caso 3:**
```sql
SELECT ST_Touches(
           ST_GeomFromText( 'LINESTRING( 5 6, 5 8, 7 8 )' ),
           ST_GeomFromText( 'LINESTRING( 6 6, 6 9 )' )
       );
```


**Caso 4:**
```sql
SELECT ST_Touches(
           ST_GeomFromText( 'POLYGON( ( 9 6, 9 8, 12 8, 12 6, 9 6 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 12 7, 15 9, 15 5, 12 7 ) )' )
       );
```


**Caso 5:**
```sql
SELECT ST_Touches(
           ST_GeomFromText( 'POLYGON( ( 1 1, 1 3, 4 3, 4 1, 1 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 4 2, 4 4, 6 4, 6 2, 4 2 ) )' )
       );
```


**Caso 6:**
```sql
SELECT ST_Touches(
           ST_GeomFromText( 'POLYGON( ( 7 1, 7 3, 10 3, 10 1, 7 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 9 2, 13 4, 13 1, 9 2 ) )' )
       );
```


##### `ST_Crosses`: a geometria A cruza a geometria B?

**Caso 1:**
```sql
SELECT ST_Crosses(
           ST_GeomFromText( 'LINESTRING( 0 4, 3 9 )' ),
           ST_GeomFromText( 'LINESTRING( 1.5 6.5, 4 4 )' )
       );
```


**Caso 2:**
```sql
SELECT ST_Crosses(
           ST_GeomFromText( 'LINESTRING( 4 8, 7 8 )' ),
           ST_GeomFromText( 'LINESTRING( 5 6, 5 9 )' )
       );
```


**Caso 3:**
```sql
SELECT ST_Crosses(
           ST_GeomFromText( 'LINESTRING( 8 8, 12 8 )' ),
           ST_GeomFromText( 'LINESTRING( 9 6, 9 8, 11 8, 11 9 )' )
       );
```


**Caso 4:**
```sql
SELECT ST_Crosses(
           ST_GeomFromText( 'LineString( 11 5, 13 5, 13 6 )' ),
           ST_GeomFromText( 'POLYGON( ( 12 4, 12 7, 15 7, 15 5, 12 4) )' )
       );
```


**Caso 5:**
```sql
SELECT ST_Crosses(
           ST_GeomFromText( 'MultiPoint( 9 2, 9 3, 10 2 )' ),
           ST_GeomFromText( 'LineString( 8 1, 8 3, 10 3 )' )
       );
```


**Caso 6:**
```sql
SELECT ST_Crosses(
           ST_GeomFromText( 'MultiPoint( 3.5 1, 3.5 2.5, 4.5 1.5, 4.5 2.5 )' ),
           ST_GeomFromText( 'POLYGON( ( 1 1, 1 3, 4 3, 4 1, 1 1) )' )
       );
```


##### `ST_Overlaps`: a geometria A sobrepõe a geometria B?

**Caso 1:**
```sql
SELECT ST_Overlaps(
           ST_GeomFromText( 'LINESTRING( 4 8, 7 8 )' ),
           ST_GeomFromText( 'LINESTRING( 5 6, 5 9 )' )
       );
```


**Caso 2:**
```sql
SELECT ST_Overlaps(
           ST_GeomFromText( 'LINESTRING( 8 8, 12 8 )' ),
           ST_GeomFromText( 'LINESTRING( 9 6, 9 8, 11 8, 11 9 )' )
       );
```


**Caso 3:**
```sql
SELECT ST_Overlaps(
           ST_GeomFromText( 'POLYGON( ( 1 1, 1 3, 4 3, 4 1, 1 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 4 2, 4 4, 6 4, 6 2, 4 2 ) )' )
       );
```


**Caso 4:**
```sql
SELECT ST_Overlaps(
           ST_GeomFromText( 'POLYGON( ( 7 1, 7 3, 10 3, 10 1, 7 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 9 2, 13 4, 13 1, 9 2 ) )' )
       );
```



##### `ST_Contains`: a geometria A contém a geometria B?

**Caso 1:**
```sql
SELECT ST_Contains(
           ST_GeomFromText( 'POLYGON( ( 1 6, 1 9, 5 9, 5 6, 1 6 ) )' ),
           ST_GeomFromText( 'POINT( 3 8 )' )
       );
```


**Caso 2:**
```sql
SELECT ST_Contains(
           ST_GeomFromText( 'POLYGON( ( 6 6, 6 9, 10 9, 10 6, 6 6 ) )' ),
           ST_GeomFromText( 'POINT( 6 8 )' )
       );
```


**Caso 3:**
```sql
SELECT ST_Contains(
           ST_GeomFromText( 'POLYGON( ( 1 1, 1 5, 5 5, 5 1, 1 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 2 2, 2 4, 4 4, 4 2, 2 2 ) )' )
       );
```


**Caso 4:**
```sql
SELECT ST_Contains(
           ST_GeomFromText( 'POLYGON( ( 6 1, 6 5, 10 5, 10 1, 6 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 7 3, 7 5, 9 5, 9 3, 7 3 ) )' )
       );
```


**Caso 5:**
```sql
SELECT ST_Contains(
           ST_GeomFromText( 'POLYGON( ( 11 6, 11 9, 15 9, 15 6, 11 6 ) )' ),
           ST_GeomFromText( 'LINESTRING( 12 7, 12 9, 14 9 )' )
       );
```


**Caso 6:**
```sql
SELECT ST_Contains(
           ST_GeomFromText( 'POLYGON( ( 11 1, 11 5, 15 5, 15 1, 11 1 ) )' ),
           ST_GeomFromText( 'LINESTRING( 11 3, 11 5, 13 5 )' )
       );
```



##### `ST_Within`: a geometria A está dentro da geometria B?

**Caso 1:**
```sql
SELECT ST_Within(
           ST_GeomFromText( 'POINT( 3 8 )' ),
           ST_GeomFromText( 'POLYGON( ( 1 6, 1 9, 5 9, 5 6, 1 6 ) )' )
       );
```


**Caso 2:**
```sql
SELECT ST_Within(
           ST_GeomFromText( 'POINT( 6 8 )' ),
           ST_GeomFromText( 'POLYGON( ( 6 6, 6 9, 10 9, 10 6, 6 6 ) )' )
       );
```


**Caso 3:**
```sql
SELECT ST_Within(
           ST_GeomFromText( 'POLYGON( ( 2 2, 2 4, 4 4, 4 2, 2 2 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 1 1, 1 5, 5 5, 5 1, 1 1 ) )' )
       );
```


**Caso 4:**
```sql
SELECT ST_Within(
           ST_GeomFromText( 'POLYGON( ( 7 3, 7 5, 9 5, 9 3, 7 3 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 6 1, 6 5, 10 5, 10 1, 6 1 ) )' )
       );
```


**Caso 5:**
```sql
SELECT ST_Within(
           ST_GeomFromText( 'LINESTRING( 12 7, 12 9, 14 9 )' ),
           ST_GeomFromText( 'POLYGON( ( 11 6, 11 9, 15 9, 15 6, 11 6 ) )' )
       );
```


**Caso 6:**
```sql
SELECT ST_Within(
           ST_GeomFromText( 'LINESTRING( 11 3, 11 5, 13 5 )' ),
           ST_GeomFromText( 'POLYGON( ( 11 1, 11 5, 15 5, 15 1, 11 1 ) )' )
       );
```

##### `ST_Intersects`: a geometria A possui algum relacionamento espacial com a geometria B?

**Caso 1:**
```sql
SELECT ST_Intersects(
           ST_GeomFromText( 'POLYGON( ( 1 7, 1 9, 5 9, 5 7, 1 7 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 4 6, 4 8, 8 8, 8 6, 4 6 ) )' )
       );
```


**Caso 2:**
```sql
SELECT ST_Intersects(
           ST_GeomFromText( 'POLYGON( ( 10 6, 10 8, 12 8, 12 6, 10 6 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 12 6, 12 8, 14 8, 14 6, 12 6 ) )' )
       );
```


**Caso 3:**
```sql
SELECT ST_Intersects(
           ST_GeomFromText( 'POLYGON( ( 1 1, 1 5, 5 5, 5 1, 1 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 2 2, 2 4, 4 4, 4 2, 2 2 ) )' )
       );
```


**Caso 4:**
```sql
SELECT ST_Intersects(
           ST_GeomFromText( 'POLYGON( ( 6 1, 6 5, 10 5, 10 1, 6 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 7 3, 7 5, 9 5, 9 3, 7 3 ) )' )
       );
```


**Caso 5:**
```sql
SELECT ST_Intersects(
           ST_GeomFromText( 'POLYGON( ( 11 1, 11 3, 13 3, 13 1, 11 1 ) )' ),
           ST_GeomFromText( 'POLYGON( ( 13 3, 13 5, 15 5, 15 3, 13 3 ) )' )
       );
```


### Transformação entre Sistemas de Referencia Espacial

**1.** Para saber todos os sistemas de referência espacial suportados em seu sistema, consulte a tabela `spatial_ref_sys`:
```sql
SELECT * FROM spatial_ref_sys;
```


**2.** Transformando do SRID 4618 (Lat/Long SAD/69) para 29101 (Policnica SAD/69): 
```sql
SELECT ST_AsText(
           ST_Transform(
               ST_GeomFromText('POINT (-54 -12)', 4618),
               29101
           )
       );
```


**3.** Transformando do SRID 4618 (Lat/Long SAD/69) para 4674 (Lat/Long SAD/69): 
```sql
SELECT ST_AsText(
           ST_Transform(
               ST_GeomFromText('POINT (-54 -12)', 4618),
               4674
           )
       );
```

### Tabelas com Colunas Geométricas

**1.** Criando uma tabela para armazenar as localizações de escolas de primeiro e segundo grau:
```sql
CREATE TABLE escolas
(
    gid     SERIAL PRIMARY KEY,
    nome    VARCHAR(100),
    localizacao  GEOMETRY(POINT, 4326)
);
````


**2.** Inserindo tuplas (linhas ou registros) na tabela `escolas`:
```sql
INSERT INTO escolas (nome, localizacao)
     VALUES ('Escola Estadual Arlindo Bittencourt', ST_GeomFromText('POINT(-47.88497 -22.02557)', 4326) ),
            ('Colégio Arquidiocesano de Ouro Preto', ST_GeomFromText('POINT(-43.51592 -20.38144)', 4326) ),
            ('Instituto São José', ST_GeomFromText('POINT(-45.90245 -23.20000)', 4326) );
```


**3.** Consultando os metdados da tabela com feições denominada `escolas`:
```sql
SELECT * FROM geometry_columns WHERE f_table_name = 'escolas';
``` 
