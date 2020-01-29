# PL/pgSQL

A Linguagem `PL/pgSQL` (*Programming Language* ) permite que comandos SQL sejam executados dentro de uma linguagem procedural, isto é, de uma linguagem com comandos de decisão (*if-then-else*) e repetição (laços *do-while*). `PL/pgSQL` facilita o trabalho de manipulação do resultado da execução de consultas.


A sintaxe geral de funções em `PL/pgSQL` (As partes entre **`[`** e **`]`** são opcionais.):

```sql
CREATE OR REPLACE FUNCTION nome-da-função(parâmetros)
RETURNS tipo-retorno
AS
$$
[<<rótulo>>]
[DECLARE
    lista-variáveis;]
BEGIN
    comandos;
[EXCEPTION
   [WHEN condição THEN
        comandos;
    ...]]
END [rótulo];
$$
LANGUAGE plpgsql;
```


## Criação e execução de funções PL/pgSQL

Função chamada `my_distance`: capaz de computar a distância euclideana entre dois pontos. O código desta função é mostrado a seguir:

```sql
CREATE OR REPLACE FUNCTION my_distance(first GEOMETRY,
                                       second GEOMETRY)
RETURNS NUMERIC
AS
$$
DECLARE
    dx NUMERIC DEFAULT 0.0;
    dy NUMERIC DEFAULT 0.0;
    d  NUMERIC DEFAULT 0.0;
BEGIN
    dx := ST_X(first) - ST_X(second);
    dy := ST_Y(first) - ST_Y(second);

    d := sqrt(power(dx, 2) + power(dy, 2));

    RETURN d;
END;
$$
LANGUAGE plpgsql;
```

Para executar a função `my_distance` podemos utilizar uma consulta do tipo `SELECT` usando uma das duas construções:

```sql
SELECT my_distance(
           ST_GeometryFromText('POINT(0 0)', 4326),
           ST_GeometryFromText('POINT(1 1)', 4326));
```
ou:
```sql
SELECT *
  FROM my_distance(
           ST_GeometryFromText('POINT(0 0)', 4326),
           ST_GeometryFromText('POINT(1 1)', 4326));
```

## Comentários

Em `PL/pgSQL`, os comentários de linha começam com um duplo hífen (**--**), enquanto comentários de bloco utilizam as marcações **/* ** e ** */**.

O trecho de código abaixo mostra como incluir alguns comentários na definição da função `my_distance`:

```sql
/*
  Descrição: Função que computa a distância euclideana
             entre dois pontos.

  Parâmetros:
    - first:  Ponto no espaço bidimensional.
    - second: Ponto no espaço bidimensional.

  Retorno: um valor numérico que representa a distância
           euclideana entre os pontos informados.
 */
CREATE OR REPLACE FUNCTION my_distance(first GEOMETRY,
                                       second GEOMETRY)
RETURNS NUMERIC
AS
$$
DECLARE
    dx NUMERIC DEFAULT 0.0;
    dy NUMERIC DEFAULT 0.0;
    d  NUMERIC DEFAULT 0.0;
BEGIN
    dx := ST_X(first) - ST_X(second);
    dy := ST_Y(first) - ST_Y(second);

    -- sqrt: operação raiz quadrada
    d := sqrt(power(dx, 2) + power(dy, 2));

    RETURN d;
END;
$$
LANGUAGE plpgsql;
```

## Estruturas Condicionais

Em `PL/pgSQL` temos dois tipos de comandos condicionais: *if-then-else* e *case-when*.

A sintaxe de comandos *if-then-else* é a seguinte:

```sql
IF condição THEN
    comandos;
[ELSIF condição THEN
    comandos;]
[ELSE
    comandos;]
END IF;
```

Comandos *case-when* possuem a seguinte sintaxe:

```sql
CASE expressão
    WHEN expressão [, expressão [ ... ]] THEN
        comandos;
   [WHEN expressão [, expressão [ ... ]] THEN
        comandos;
    ... ]
   [ELSE
        comandos;]
END CASE;
```

No exemplo da função `my_distance`, se considerarmos que a distância entre os pontos só pode ser computada caso eles se encontrem no mesmo sistema de referência espacial, poderíamos reescrever a função da seguinte forma:

```sql
CREATE OR REPLACE FUNCTION my_distance(first GEOMETRY,
                                       second GEOMETRY)
RETURNS NUMERIC
AS
$$
DECLARE
    dx NUMERIC DEFAULT 0.0;
    dy NUMERIC DEFAULT 0.0;
    d  NUMERIC DEFAULT 0.0;
BEGIN
    IF(ST_SRID(first) <> ST_SRID(second)) THEN
        return NULL;
    END IF;

    dx := ST_X(first) - ST_X(second);
    dy := ST_Y(first) - ST_Y(second);

    d := sqrt(power(dx, 2) + power(dy, 2));

    RETURN d;
END;
$$
LANGUAGE plpgsql;
```

Repare que agora, se chamarmos a função para um par de pontos em diferentes sistemas de coordenadas, receberemos um valor nulo (**NULL**) como retorno:

```sql
SELECT my_distance(
           ST_GeometryFromText('POINT(0 0)', 4326),
           ST_GeometryFromText('POINT(1 1)', 29193));
```

No entanto, ao invés de retornarmos um valor **NULL** o mais adequado seria interromper a execução da função indicando algum tipo ou condição de erro. A seção a seguir mostra como podemos proceder nestes casos.

## Mensagens e Exceções

O comando `RAISE` pode ser usado para reportar mensagens, que são associadas a níveis de severidade: `DEBUG`, `LOG`, `INFO`, `NOTICE`, `WARNING`, e `EXCEPTION`.

 nova definição da função `my_distance` pode ser vista abaixo:

 ```sql
 CREATE OR REPLACE FUNCTION my_distance(first GEOMETRY,
                                        second GEOMETRY)
 RETURNS NUMERIC
 AS $$
 DECLARE
     dx NUMERIC DEFAULT 0.0;
     dy NUMERIC DEFAULT 0.0;
     d  NUMERIC DEFAULT 0.0;
 BEGIN
     IF((ST_GeometryType(first) <> 'ST_Point') OR
        (ST_GeometryType(second) <> 'ST_Point')) THEN
         RAISE EXCEPTION 'Tipos geométricos inválidos!';
     END IF;

     IF(ST_SRID(first) <> ST_SRID(second)) THEN
         RAISE EXCEPTION 'Pontos com SRIDs diferentes!';
     END IF;

     dx := ST_X(first) - ST_X(second);
     dy := ST_Y(first) - ST_Y(second);

     RAISE NOTICE 'dx: %', dx;
     RAISE NOTICE 'dy: %', dy;

     d := sqrt(power(dx, 2) + power(dy, 2));

     RETURN d;
 END;
 $$
 LANGUAGE plpgsql;
```
**1.**  Se não respeitarmos os tipos geométricos, a função irá produzir uma mensagem de erro e a função será interrompida:
```sql
 SELECT my_distance(
    ST_GeometryFromText('LINESTRING(0 0, 1 1)', 4326),
    ST_GeometryFromText('POINT(1 1)', 4326));
```

**2.** Se informarmos pontos com diferentes SRIDs, uma mensagem será produzida informando o erro e a função será interrompida:

```sql
SELECT my_distance(
    ST_GeometryFromText('POINT(0 0)', 29193),
    ST_GeometryFromText('POINT(1 1)', 4326));
```

**3.** Caso a função seja chamada com argumentos válidos, além do resultado, será produzida uma mensagem (**NOTICE**):

```sql
SELECT my_distance(
ST_GeometryFromText('POINT(0 0)', 4326),
ST_GeometryFromText('POINT(1 1)', 4326));
```

## Tipos dos Parâmetros e Tipo de Retorno

Todos os tipos de dados e operadores disponíveis em SQL também encontram-se disponíveis para a construção de funções `PL/pgSQL`.

Os parâmetros das funções são nomeados com os identificadores `\$1`, `\$2`, `...`, `\$n`. Nos exemplos anteriores, usamos nomes alternativos para renomear os parâmetros da função `my_distance`: **first** e **second**. Sem o uso de parâmetros nomeados, essa função seria definida da seguinte forma (Primeiro Remova a função `my_distance`):

```sql
DROP FUNCTION my_distance(geometry,geometry);
```

```sql
CREATE OR REPLACE FUNCTION my_distance(GEOMETRY, GEOMETRY)
RETURNS NUMERIC
AS
$$
DECLARE
    dx NUMERIC DEFAULT 0.0;
    dy NUMERIC DEFAULT 0.0;
    d  NUMERIC DEFAULT 0.0;
BEGIN
    IF((ST_GeometryType($1) <> 'ST_Point') OR
       (ST_GeometryType($2) <> 'ST_Point')) THEN
        RAISE EXCEPTION 'Tipos geométricos inválidos!';
    END IF;

    IF(ST_SRID($1) <> ST_SRID($2)) THEN
        RAISE EXCEPTION 'Pontos com SRIDs diferentes!';
    END IF;

    dx := ST_X($1) - ST_X($2);
    dy := ST_Y($1) - ST_Y($2);

    d := sqrt(power(dx, 2) + power(dy, 2));

    RETURN d;
END;
$$
LANGUAGE plpgsql;
```

## Execução de Comandos SQL

Podemos utilizar comandos SQL com instruções válidas dentro de funções `PL/pgSQL`. Esses comandos podem utilizar nomes de variáveis definidas na própria função para compor o comando.

Para ilustrar a execução de comandos, vamos criar uma tabela chamada `pluviometros`:

```sql
CREATE TABLE pluviometros
(
    gid      SERIAL PRIMARY KEY,
    location GEOMETRY(POINT, 4326)
);
```

### Comandos que não retornam resultados

```sql
CREATE OR REPLACE FUNCTION my_insert(longitude NUMERIC,
                                     latitude  NUMERIC)
RETURNS VOID
AS
$$
BEGIN

    INSERT INTO pluviometros(location)
        VALUES(
            ST_SetSRID(
                ST_MakePoint(longitude, latitude),
                4326));

    RETURN;
END;
$$
LANGUAGE plpgsql;
```

Chamar a função `my_insert` que irá montar a tupla a ser inserida na tabela `pluviometros`:

```sql
SELECT my_insert(-45.8872, -23.1791);
```

### Comandos que retornam uma única tupla como resultado

Podemos também recuperar o resultado de uma consulta que retorne uma única tupla, ou seja, um resultado que pode ser composto de um ou mais valores:

```sql
CREATE OR REPLACE FUNCTION my_insert(longitude NUMERIC,
                                     latitude NUMERIC)
RETURNS pluviometros.gid%TYPE
AS
$$
DECLARE
    id pluviometros.gid%TYPE;
BEGIN

    INSERT INTO pluviometros(location)
        VALUES(
            ST_SetSRID(
                ST_MakePoint(longitude, latitude),
                4326))
        RETURNING gid INTO id;

    RETURN id;
END;
$$
LANGUAGE plpgsql;
```

Com essa modificação, ao invocarmos a função  `my_insert` obtemos o novo identificador da linha criada:

```sql
SELECT my_insert(-43.6419, -20.393);
```

```sql
CREATE OR REPLACE FUNCTION existe_pluviometro(location GEOMETRY,
                                              distance NUMERIC)
RETURNS BOOL
AS
$$
DECLARE
    pluviometro pluviometros%ROWTYPE;
BEGIN
    SELECT * INTO pluviometro
      FROM pluviometros
     WHERE ST_DWithin(pluviometros.location,
                      existe_pluviometro.location,
                      distance);

    IF FOUND THEN
        RAISE NOTICE
              'Encontrado pelo menos um pluviometro próximo: %',
              ST_AsText(pluviometro.location);

        RETURN TRUE;
    ELSE
        RAISE NOTICE
              'Não foi encontrado um único pluviômetro nas proximidades de: %',
              ST_AsText(existe_pluviometro.location);

        RETURN FALSE;
    END IF;
END;
$$
LANGUAGE plpgsql;
```

Se quisermos saber da existência ou não de um pluviômetro num raio de 1.0 grau das localizações `(-45, -23)` e `(-47, -25)`, podemos realizar as seguintes consultas:

```sql
SELECT existe_pluviometro(ST_SetSRID(ST_MakePoint(-45, -23), 4326), 1.0);
```
```sql
SELECT existe_pluviometro(ST_SetSRID(ST_MakePoint(-47, -25), 4326), 1.0);
```

Podemos utilizar um bloco para capturar os possíveis tipos de exceções, como mostrado na função abaixo:

```sql
CREATE OR REPLACE FUNCTION unico_pluviometro(location GEOMETRY,
                                             distance NUMERIC)
RETURNS BOOL
AS
$$
DECLARE
    pluviometro pluviometros%ROWTYPE;
BEGIN
    SELECT * INTO STRICT pluviometro
      FROM pluviometros
     WHERE ST_DWithin(pluviometros.location,
                      unico_pluviometro.location,
                      distance);
    RETURN TRUE;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE NOTICE 'Nenhum pluviômetro encontrado próximo a: %',
              ST_AsText(unico_pluviometro.location);
         RETURN FALSE;

    WHEN TOO_MANY_ROWS THEN
        RAISE NOTICE 'Vários pluviômetros encontrados próximo a: %',
              ST_AsText(unico_pluviometro.location);
        RETURN FALSE;
END;
$$
LANGUAGE plpgsql;
```
Para testar a função acima, execute os comandos abaixo:

```sql
SELECT unico_pluviometro(ST_SetSRID(ST_MakePoint(-45, -23), 4326), 1.0);
```

```sql
SELECT unico_pluviometro(ST_SetSRID(ST_MakePoint(-47, -25.), 4326), 1.0);
```

### Comandos Dinâmicos

```sql
CREATE OR REPLACE FUNCTION random_insert()
RETURNS pluviometros.gid%TYPE
AS
$$
DECLARE
    id pluviometros.gid%TYPE;
    r NUMERIC;
    longitude NUMERIC;
    latitude NUMERIC;
    pt GEOMETRY;
    query TEXT;
BEGIN
    query := 'INSERT INTO pluviometros (location) VALUES($1) RETURNING gid';

    r := random();

    longitude := 360.0 * r - 180.0;
    latitude := 180.0 * r - 90.0;

    RAISE NOTICE 'Localização: (%, %)', longitude, latitude;

    pt := ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);

    EXECUTE query INTO STRICT id USING pt;

    RETURN id;
END;
$$
LANGUAGE plpgsql;
```
Execute a função `random_insert` :

```sql
SELECT random_insert();
```

## Retornando Conjuntos ou Tuplas

Podemos definir o tipo de retorno de uma função como sendo um conjunto de valores usando o construtor `SETOF` ou `TABLE`. Neste caso, ao invés de usar uma única instrução `RETURN`, utilizamos as instruções `RETURN NEXT` ou `RETURN QUERY`.

A função `generate_4pts` irá gerar um conjunto com quatro pontos sorteados de forma aleatória:

```sql
CREATE OR REPLACE FUNCTION generate_4pts()
RETURNS SETOF GEOMETRY
AS
$$
DECLARE
    pt GEOMETRY;
BEGIN
    pt := ST_SetSRID(ST_MakePoint(360.0 * random() - 180.0,
                                  180.0 * random() - 90.0), 4326);
    RETURN NEXT pt;

    pt := ST_SetSRID(ST_MakePoint(360.0 * random() - 180.0,
                                  180.0 * random() - 90.0), 4326);
    RETURN NEXT pt;

    pt := ST_SetSRID(ST_MakePoint(360.0 * random() - 180.0,
                                  180.0 * random() - 90.0), 4326);
    RETURN NEXT pt;

    pt := ST_SetSRID(ST_MakePoint(360.0 * random() - 180.0,
                                  180.0 * random() - 90.0), 4326);
    RETURN NEXT pt;

    RETURN;
END;
$$
LANGUAGE plpgsql;
```
Podemos invocar a função `generate_4pts` da seguinte forma:

```sql
SELECT ST_AsText(pt) AS geom FROM generate_4pts() AS pt;
```

Outra possibilidade de retornar um conjunto de valores é através do comando `RETURN QUERY`. A função `nearest_pluviometros` ilustra como podemos utilizar este comando:

```sql
CREATE OR REPLACE FUNCTION nearest_pluviometros(location GEOMETRY,
                                                distance NUMERIC)
RETURNS SETOF pluviometros
AS
$$
DECLARE
    q TEXT;
BEGIN
    q := 'SELECT * FROM pluviometros' ||
         ' WHERE ST_DWithin(location, $1, $2)';

    RETURN QUERY EXECUTE q USING location, distance;

    RETURN;
END;
$$
LANGUAGE plpgsql;
```

Invocando a função `nearest_pluviometros`:

```sql
SELECT gid, ST_AsText(location)
  FROM nearest_pluviometros(
           ST_SetSRID(ST_MakePoint(-45, -23), 4326),
           10.0);
```

Outra possibilidade de escrita da função `nearest_pluviometros` seria sem a utilização do comando `EXECUTE`:

```sql
CREATE OR REPLACE FUNCTION nearest_pluviometros(location GEOMETRY,
                                                distance NUMERIC)
RETURNS SETOF pluviometros
AS
$$
BEGIN
    RETURN QUERY SELECT *
                   FROM pluviometros
                  WHERE ST_DWithin(pluviometros.location,
                                   nearest_pluviometros.location,
                                   distance);

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Nenhum pluviometro nas proximidades: %', ST_AsText($1);
    END IF;

    RETURN;
END;
$$
LANGUAGE plpgsql;
```

## Comandos de Repetição

`PL/pgSQL` possui diversos tipos de estruturas para laços de repetição: `LOOP`, `WHILE`, `FOR` e `FOREACH`. Além de comandos para desvio do fluxo de instruções: `EXIT` e `CONTINUE`.

### FOR com variável de controle do tipo inteiro

```sql
CREATE OR REPLACE FUNCTION random_pt_generator(npts NUMERIC)
RETURNS SETOF RECORD
AS $$
DECLARE
    tupla RECORD;
    longitude NUMERIC;
    latitude NUMERIC;
    pt GEOMETRY;
BEGIN
    RAISE NOTICE 'Computando % pontos aleatórios...', npts;

    FOR i IN 1..npts LOOP
        longitude := 360.0 * random() - 180.0;
        latitude := 180.0 * random() - 90.0;

        pt := ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);

        tupla := (i, pt);  -- ou: SELECT i, pt INTO tupla;

        RETURN NEXT tupla;

        IF (i % 1000) = 0 THEN
            RAISE NOTICE 'random_pt_generator: iteração %', i;
        END IF;
    END LOOP;

    RETURN;
END;
$$
LANGUAGE plpgsql;
```

A função `random_pt_generator` é tipo de função que não pode ser utilizada somente na cláusula `SELECT` pois ela retorna um conjunto de tuplas. Neste caso, deve-se utilizar a função na cláusula `FROM`, mas com um cuidado especial, que é definir o tipo do conjunto retornado como apresenta a consulta a seguir que computa 5 pontos:

```sql
SELECT gid, ST_AsText(geom)
  FROM random_pt_generator(5) AS tabela(gid INTEGER, geom GEOMETRY);

```

### FOR sobre o resultado de uma consulta

Outro tipo de laço `FOR` pode ser empregado para iterar nas tuplas resultantes de uma consulta como apresenta o exemplo a seguir:

```sql
CREATE OR REPLACE FUNCTION build_pt_table(table_name TEXT,
                                          npts NUMERIC)
RETURNS VOID
AS
$$
DECLARE
    tupla RECORD;
    i     INTEGER DEFAULT 1;
BEGIN
    RAISE NOTICE 'Criando tabela %...', table_name;

    EXECUTE 'CREATE TABLE ' || table_name ||
            '(gid INTEGER, geom GEOMETRY(POINT,4326))';

    FOR tupla IN SELECT *
                   FROM random_pt_generator(npts) AS tabela(gid INTEGER, geom GEOMETRY)
              LOOP
        EXECUTE 'INSERT INTO ' || table_name ||
                '(gid, geom) VALUES($1, $2)' USING tupla.gid, tupla.geom;

        IF (i % 1000) = 0 THEN
            RAISE NOTICE 'Inseridos % tuplas!', i;
        END IF;

        i = i + 1;
    END LOOP;

    RAISE NOTICE 'Criando chave primária...';

    EXECUTE format('ALTER TABLE %I ADD PRIMARY KEY(gid)', table_name);

    RAISE NOTICE 'Criando índice espacial...';

    EXECUTE 'CREATE INDEX spidx_' || table_name ||
    '_geom ON ' || table_name || ' USING GIST(geom)';

    RETURN;
END;
$$
LANGUAGE plpgsql;
```
Usando a função `build_pt_table`, vamos criar uma tabela chamada `pt10k` contendo 10.000 pontos:

```sql
SELECT build_pt_table('pt10k', 10000);
```

Outra forma útil deste tipo de `FOR` utiliza o comando `EXECUTE`:


```sql
[<<rótulo>>]
FOR variável-tupla IN EXECUTE query-string [USING expressão [, ... ]] LOOP
    comandos;
END LOOP [rótulo];
```

### WHILE

```sql
[<<rótulo>>]
WHILE expressão-booleana LOOP
    comandos;
END LOOP [rótulo];
```

### LOOP: repetições incondicionais

```sql
[<<rótulo>>]
LOOP
    comandos;
END LOOP [rótulo];
```

### EXIT: interrompendo um laço ou bloco de comandos

```sql
EXIT [rótulo] [WHEN expressão-booleana];
```

### CONTINUE: desviando o fluxo de uma laço

```sql
CONTINUE [rótulo] [WHEN expressão-booleana];
```

### FOREACH: iterando sobre arrays

```sql
[<<rótulo>>]
FOREACH variável [SLICE número] IN ARRAY expressão-array LOOP
    comandos;
END LOOP [rótulo];
```

## Blocos

Podemos criar e aninhar novos blocos dentro do bloco principal de uma função. Os blocos possuem a seguinte estrutura:

```sql
[<<rótulo>>]
DECLARE
    lista-variáveis;
BEGIN
    comandos;
[EXCEPTION
    WHEN condição THEN
        ...]
END [rótulo];
```
