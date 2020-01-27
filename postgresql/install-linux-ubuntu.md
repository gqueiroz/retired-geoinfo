# Instalação do PostgreSQL e PostGIS para Linux (Ubuntu)


> Os passos apresentados abaixo foram realizado no Ubuntu Bionic (18.04 LTS)


## Acrescentando o Repositório do PostgreSQL no Sistema de Pacotes do Ubuntu

Para realizar a instalação do PostgreSQL, é necessário criar o arquivo `pgdg.list`. Para isto, utilize o seguinte comando:

```shell
  $ sudo touch /etc/apt/sources.list.d/pgdg.list
```


Edite o arquivo `/etc/apt/sources.list.d/pgdg.list`.


Para edição do arquivo, você pode utilizar o `vi`:

```shell
  $ sudo vi /etc/apt/sources.list.d/pgdg.list
```


ou, se preferir, pode usar o `gedit`:

```bash
$ sudo gedit /etc/apt/sources.list.d/pgdg.list
```


Adicione a seguinte linha no arquivo para habilitar o repositório:

```shell
  deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main
```


Após salvar o arquivo, utilize os seguintes comandos para importar a chave de assinatura do repositório e atualizar as listas de pacotes:

```shell
  $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

  $ sudo apt-get update
```

Agora podemos instalar os pacotes!


## Instalação da Versão PostgreSQL 11

Os pacotes mais comuns e importantes são:


|      Pacote             |                           Descrição                                       |
|-------------------------|---------------------------------------------------------------------------|
|postgresql-client-11     |bibliotecas de clientes e binários de clientes binaries                                       |
|postgresql-11            |*core* servidor de banco de dados                                          |
|libpq-dev                |bibliotecas e cabeçalhos para o desenvolvimento de front-end da linguagem C|
|postgresql-server-dev-11 |bibliotecas e cabeçalhos para o desenvolvimento de front-end da linguagem C|
|pgadmin4                 |Utilitário de administração gráfica do pgAdmin 4                           |

Para instalar o PostgreSQL 11 e outros pacotes, utilize o seguinte comando:

```shell
  $ sudo apt-get install -y postgresql-11 postgresql-client-11 libpq-dev postgresql-server-dev-11 pgadmin4
```


Para verificar se a instalação está correta e o servidor executando, utilize o seguinte comando:

```shell
  $ sudo -u postgres psql -c "SELECT version();"
```


Você deverá obter uma saída semelhante a apresentada abaixo:
```shell
                                                              version                                                              
-----------------------------------------------------------------------------------------------------------------------------------
 PostgreSQL 11.6 (Ubuntu 11.6-1.pgdg18.04+1) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, 64-bit
(1 row)
```


## Instalação da extensão PostGIS

Para instalar a extensão espacial PostGIS utilize o seguinte comando:

```shell
  $ sudo apt-get install postgresql-11-postgis-2.5
```


Para testar sua instalação, utilize o comando abaixo:
```shell
  $ sudo -u postgres psql -c "SELECT name, default_version FROM pg_available_extensions WHERE name = 'postgis';"
```


Você deverá obter uma saída semelhante a apresentada abaixo:
```shell
  name   | default_version 
---------+-----------------
 postgis | 2.5.3
(1 row)
```


**Observação:** 
  - Mais informações da instalação do `PostgreSQL` no `Linux Ubuntu` podem ser encontradas em: [PostgreSQL downloads (Ubuntu)](https://www.postgresql.org/download/linux/ubuntu/).

  - Mais informações da instalação do `PostGIS` podem ser encontradas em: [PostGIS downloads (Ubuntu)](https://postgis.net/install/).
