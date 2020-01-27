# Evolução das Tecnologias de Bancos de Dados


## Sistemas Gerenciadores de Bancos de Dados Relacionais


**1.** Criando uma tabela denominada `paises`:

```sql
CREATE TABLE paises
(
    pid  INT4 PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);
``` 


**2.** Inserindo tuplas na tabela `paises`:

```sql
INSERT INTO paises (pid, nome) VALUES(1, 'Alemanha');
```

```sql
INSERT INTO paises VALUES(2, 'Brasil');
```


**3.** Criando uma tabela denominada `cidades`:

```sql
CREATE TABLE cidades
(
    cid        SERIAL PRIMARY KEY,
    nome       VARCHAR(50) NOT NULL UNIQUE,
    populacao  INTEGER,
    pais_id    INTEGER,
    FOREIGN KEY (pais_id) REFERENCES paises(pid)
);
```


**4.** Inserindo tuplas na tabela `cidades`:

```sql
INSERT INTO cidades (nome, populacao, pais_id) VALUES ('Ouro Preto', 70227, 2),
                                                      ('Mariana', 58233, 2),
                                                      ('Munster', 291754, 1),
                                                      ('Itabirito', 45449, 2);
```


**5.** Exemplos:
  - **Projeção:** nome das cidades e populacao (em milhares)

  - **Seleção Tuplas:** cidades acima de 60.000 habitantes (ordenação por população)

  - **Produto Cartesiano:** cidades x paises

  - **Junção Tabelas:** cidades x paises

  - **Agregação:** população países


## Criando um Novo Tipo de Dado no PostgreSQL

Esta seção apresenta um exemplo simples de como criar um novo tipo de dados para representação de coordenadas geográficas.


**1.** Criando um tipo denominado `geo_point`:
```sql
CREATE TYPE geo_point AS
(
  x    REAL,
  y    REAL,
  srid INTEGER
);

```


**2.** Criando uma tabela para armazenamento da localização de escolas de primeiro e segundo grau:
```sql 
CREATE TABLE escolas
(
    gid         SERIAL PRIMARY KEY,
    nome        VARCHAR(100),
    localizacao GEO_POINT
);
```


**3.** Inserindo tuplas (linhas ou registros) na tabela `escolas`:
```sql
INSERT INTO escolas (gid, nome, localizacao)
     VALUES (1, 'Escola Estadual Arlindo Bittencourt', '(-47.88497, -22.02557, 4326)'::GEO_POINT),
            (2, 'Colégio Arquidiocesano de Ouro Preto', '(-43.51592, -20.38144, 4326)'::GEO_POINT),
            (3, 'Instituto São José', '(-45.90245, -23.20000, 4326)'::GEO_POINT);
```


**4.** Recuperando as tuplas da tabela `escolas`:
```sql
SELECT * FROM escolas;
```


**5.** Criando uma função para computar a distância entre dois pontos no plano cartesiano:
```sql
CREATE OR REPLACE FUNCTION distance(first GEO_POINT, second GEO_POINT)
    RETURNS REAL AS $$
    DECLARE
        dx REAL;
        dy REAL;
    BEGIN
        dx = (first.x - second.x);

        dy = (first.y - second.y);

        RETURN sqrt(dx * dx + dy * dy);
    END;
    $$
    LANGUAGE plpgsql;
```


**6.** Utilizando a função `distance` para computar a distância entre dois pontos:
```sql
SELECT distance('(1, 1, 4326)'::GEO_POINT, '(2, 2, 4326)'::GEO_POINT);
```


**7.** Criando um operador para comparação entre dois pontos:

(a) Criação da função de comparação:
```sql
CREATE OR REPLACE FUNCTION less_than(first GEO_POINT, second GEO_POINT)
    RETURNS BOOL AS $$
    BEGIN
        IF(first.x < second.x) THEN
            RETURN TRUE;
        END IF;

        IF(first.x > second.x) THEN
            RETURN FALSE;
        END IF;

        IF(first.y < second.y) THEN
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END;
    $$
    LANGUAGE plpgsql;
```


(b) A função acima poderia ser utilizada da seguinte forma:
```sql
SELECT less_than('(1, 2, 4326)'::GEO_POINT, '(10, 20, 4326)'::GEO_POINT);


SELECT less_than('(1, 2, 4326)'::GEO_POINT, '(-1, 2, 4326)'::GEO_POINT);

```


(c) Criando o operador associado à função de comparação:
```sql
CREATE OPERATOR <
(
  leftarg = GEO_POINT,
  rightarg = GEO_POINT,
  procedure = less_than,
  commutator = >,
  negator = >=
);
```


(d) Utilizando a função `less_than` através do operador `<`:
```sql
SELECT '(1, 2, 4326)'::GEO_POINT < '(10, 2, 4326)'::GEO_POINT;
```
