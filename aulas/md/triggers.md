# Triggers

O código a seguir mostra como poderíamos construir uma tabela com uma restrição do tipo `check-constraint`:

```sql
CREATE TABLE lotes
(
    gid  SERIAL PRIMARY KEY,
    geom GEOMETRY(POLYGON, 0),
    CHECK(ST_Area(geom) >= 360.0)
);
```

**1.** Inserir a feição de um terreno com dimensões 12mx30m, respeitamos a regra imposta:

```sql
INSERT INTO lotes (geom)
    VALUES (ST_GeomFromText(
                'POLYGON((0 0, 12 0, 12 30, 0 30, 0 0))', 0));
```
**2.** Adicionar uma nova tupla com dados de um terreno com dimensões de 10mx24m (fora da regra):

```sql
INSERT INTO lotes (geom)
    VALUES (ST_GeomFromText(
                'POLYGON((12 0, 22 0, 22 24, 12 24, 12 0))', 0));
```
Suponha agora que queiramos incluir uma nova regra na nossa tabela a fim de evitar que um novo lote seja cadastrado de forma a ter sobreposição com algum outro lote já cadastrado. Neste caso, não é possível definir esta regra como uma restrição do tipo `check-constraint`. Neste caso, m mecanismo útil para estabelecer este tipo de restrição é conhecido por `trigger`.

## Triggers PL/pgSQL

A definição do `trigger` é realizada através do comando `CREATE TRIGGER`, que possui a seguinte sintaxe:
```SQL
CREATE [CONSTRAINT] TRIGGER nome-trigger
  {BEFORE | AFTER | INSTEAD OF} {tipo-evento [OR ...]}
  ON nome-tabela
  [FROM referenced_table_name ]
  [NOT DEFERRABLE |
    [DEFERRABLE] [INITIALLY IMMEDIATE | INITIALLY DEFERRED]]
  [FOR [EACH] {ROW | STATEMENT}]
  [WHEN (condition)]
  EXECUTE PROCEDURE nome-função-trigger(argumentos)
```

A função `PL/pgSQL` usada para definir o `trigger` não possui parâmetros e o tipo de retorno é do tipo `trigger`, como mostrado abaixo:

```SQL
CREATE OR REPLACE FUNCTION nome-da-função-trigger()
RETURNS trigger
AS
$$
DECLARE
    lista-variáveis;
BEGIN
    comandos;
END;
$$ LANGUAGE plpgsql;
```

Incluir uma nova regra na tabela  a fim de evitar que um novo lote seja cadastrado de forma a ter sobreposição com algum outro lote já cadastrado. Podemos criar um `trigger` associado à tabela `lotes`:


```sql
CREATE OR REPLACE FUNCTION verifica_overlap_lote()
RETURNS trigger
AS
$$
DECLARE
    lote lotes%ROWTYPE; -- ou: RECORD
BEGIN
    IF TG_OP = 'INSERT' THEN   
        FOR lote IN SELECT *
                      FROM lotes
                     WHERE ST_Intersects(NEW.geom, geom) LOOP
            IF NOT ST_Touches(NEW.geom, lote.geom) THEN
                RAISE EXCEPTION 'Lote viola restrição de integridade espacial!';
            END IF;
        END LOOP;
    ELSIF TG_OP = 'UPDATE' THEN
        FOR lote IN SELECT *
                      FROM lotes
                     WHERE ST_Intersects(NEW.geom, geom)
                       AND (lotes.gid != OLD.gid) LOOP
            IF NOT ST_Touches(NEW.geom, lote.geom) THEN
                RAISE EXCEPTION 'Lote viola restrição de integridade espacial!';
            END IF;
        END LOOP;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

Definir o `trigger` sobre a tabela `lotes`:

```SQL
CREATE TRIGGER trigger_verifica_overlap_lote
  BEFORE INSERT OR UPDATE
  ON lotes
  FOR EACH ROW EXECUTE PROCEDURE verifica_overlap_lote();
```

**1.** Inserir um lote que não viole nossa restrição de integridade espacial:

```SQL
INSERT INTO lotes
    (geom)
    VALUES (
        ST_GeomFromText(
            'POLYGON((12 0, 24 0, 24 30, 12 30, 12 0))',
            0));
```
**2.** Inserir um novo lote que viole a restrição de integridade espacial:

```SQL
INSERT INTO lotes
    (geom)
    VALUES (
        ST_GeomFromText(
            'POLYGON((-5 0, 7 0, 7 30, -5 30, -5 0))',
             0));
```

**3.** Alter a geometria do primeiro lote:
```SQL
UPDATE lotes
   SET geom = ST_GeomFromText(
                  'POLYGON((11 0, 23 0, 23 30, 11 30, 11 0))',
                  0)
 WHERE gid = 3;
```

Comando para remover o objeto `trigger`:

```SQL
DROP TRIGGER trigger_verifica_overlap_lote ON lotes;
```SQL
