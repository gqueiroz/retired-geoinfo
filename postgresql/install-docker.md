# Instalação do PostgreSQL e PostGIS com Docker


> Para realizar os passos a seguir, será necessário ter o Docker instalado em sua máquina. Veja o tutorial de instalação do Docker para sua plataforma de preferência em: [Notas de Instalação do Docker](../docker/README.md).


Para utilizar o PostgreSQL e o PostGIS através de um container Docker, vamos utilizar a imagem mantida no [Docker Hub](https://hub.docker.com/r/mdillon/postgis). A imagem [mdillon/postgis](https://hub.docker.com/r/mdillon/postgis) fornece um contêiner do Docker com o PostgreSQL 11 e a extensão PostGIS 2.5.


## Download da imagem PostgreSQL com a extensão PostGIS

Para realizar o download da imagem `mdillon/postgis` vamos utilizar o comando `docker pull`:

```shell
  $ docker pull mdillon/postgis:11
```

Para verificar se a imagem foi baixada para o seu computador, utilize o comando:

```shell
  $ docker image ls
```

As seguintes informações devem aparecer:

```shell
REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
mdillon/postgis                11                  19d07168491a        8 days ago          713MB
```


## Criação de Volumes

Para facilitar as atividades do curso, crie um volume denominado `curso_pg_vol` através do seguinte comando:

```shell
  $ docker volume create curso_pg_vol
```


Em seguida, crie um diretório na pasta raiz de seu usuário para compartilhar entre o seu host e o contêiner que será criado na próxima seção:

```shell
  $ mkdir $HOME/data
```


## Criando um Contêiner Docker com PostgreSQL e PostGIS

O comando `docker run` cria um contêiner Docker a partir de uma determinada imagem e o coloca em execução. Para criar o contêiner do PostgreSQL fornecido pela imagem `mdillon/postgis`, utilize o seguinte comando:

```shell
  $ docker run --detach \
               --publish 127.0.0.1:5432:5432 \
               --volume curso_pg_vol:/var/lib/postgresql/data \
               --volume $HOME/data:/data \
               --env POSTGRES_PASSWORD=secreto \
               --name curso_geo_pg \
               --ipc=host \
               --shm-size 128m \
               mdillon/postgis:11
```

Este comando permite especificar diferentes parâmetros. Por exemplo, para o curso foram especificados parâmetros relacionados a tipo de execução (`detach`), associação de portas entre o host e o contêiner (`publish`), identificação do contêiner (`name`), entre outros. Para mais informações acesse: [docker run](https://docs.docker.com/engine/reference/run/).


## Dicas

**1.** Podemos criar uma rede Docker, que possibilita conectar os contêineres e serviços do Docker, utilizando o comando:

```shell
  $ docker network create geo_net
```


Para conectar o contâiner `curso_geo_pg` à rede `geo_net` pode ser utilizado o comando abaixo:

```shell
  $ docker network connect geo_net curso_geo_pg
```


**2.** Para acessar o PostgreSQL do contâiner `curso_geo_pg`, execute o comando abaixo

```shell
  $ docker exec -it curso_geo_pg psql -U postgres -h localhost -p 5432
```


**3.** Para abrir um terminal bash no contâiner `curso_geo_pg`, execute o comando abaixo

```shell
  $ docker exec -it curso_geo_pg bash
```


**Observação:** Mais informações sobre a instalação podem ser encontradas em: [mdillon/postgis](https://hub.docker.com/r/mdillon/postgis/).
