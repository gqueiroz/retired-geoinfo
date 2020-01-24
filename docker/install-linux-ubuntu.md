# Instalação do Docker para Linux Ubuntu


A instalação do Docker em ambiente Linux é apresentada nas etapas abaixo. Os comandos executados são válidos para o Linux Ubuntu 16.04 ou superior.


## Instalação Automatizada do Docker

**1.** Faça o download do seguinte [script de instalação](https://get.docker.com) através do comando mostrado abaixo:

```shell
$ curl -fsSL https://get.docker.com -o get-docker.sh
```


**2.** Após baixar o script, execute-o com um usuário com privilégios de administrador em seu sistema, ou utilize o comando `sudo`, como apresentado abaixo:

```shell
$ sudo sh get-docker.sh
```


**3.** Após a execução do comando acima, o ambiente Docker já estará instalado e pronto para ser utilizado em seu sistema. Para facilitar seu uso, adicione o seu usuário ao grupo `docker`, como mostrado no comando abaixo:

```shell
$ sudo usermod -aG docker $USER
```

**4.** Após o comando acima, encerre sua sessão e faça o login novamente. Para testar se sua instalação está correta, utilize o seguinte comando:

```shell
$ docker -v
```


## Instalação Manual do Docker

**1.** Atualize seu sistema de pacotes:

```shell
$ sudo apt-get update
```


**2.** Instale as seguintes ferramentas auxiliares:

```shell
$ sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common
```


**3.** Adicione a chave pública do repositório docker para Ubuntu:

```shell
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
Se o comando for executado com sucesso o terminal apresentará a mensagem `OK`.

**4.** Para verificar a chave pública do repositório Docker adicionado anteriormente digite o seguinte comando:

```shell
$ sudo apt-key fingerprint 0EBFCD88
```

Caso a chave tenha sido corretamente adicionada seu terminal exibirá uma mensagem semelhante à apresentada abaixo:

```shell
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]

```

**5.** Adicione o repositório `stable` de download do Docker ao seu sistema de pacote de acordo com sua versão do Ubuntu instalada, utilizando o comando a seguir:

```shell
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

**6.** Novamente atualize seu sistema de pacote:

```shell
$ sudo apt-get update
```

**7.** Com os pacotes atualizados instale o Docker e outros componentes necessários com o comando:

```shell
$ sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

**8.** Após a execução do comando acima, o ambiente Docker já estará instalado e pronto para ser utilizado em seu sistema. Para facilitar seu uso, crie um grupo `docker` e adicione o seu usuário ao grupo criado.

Crie o grupo `docker`:

```shell
$ sudo groupadd docker
```

Adicione seu usuário ao grupo `docker`:

```shell
$ sudo usermod -aG docker $USER
```

**9.** Após o comando acima, encerre sua sessão e faça o login novamente. Para testar se sua instalação está correta, utilize o seguinte comando:

```shell
$ docker -v
```
Se a instalação estiver correta o terminal irá exibir uma mensagem contendo a versão instalada do Docker semelhante a saída abaixo:

```shell
Docker version 19.03.5, build 633a0ea838
```

**10.** Para executar seu primeiro container Docker execute o comando abaixo:

```shell
$ docker run hello-world
```

O container `hello-world` executado exibe a seguinte mensagem e finaliza sua execução:

```shell
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```


**Observação:** Mais informações sobre a instalação podem ser encontradas em: [Docker](https://docs.docker.com/install/).
