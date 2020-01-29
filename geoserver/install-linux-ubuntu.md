# Instalação do GeoServer para Linux Ubuntu

> Para seguir esses passos é necessário que o Apache Tomcat já tenha sido instalado em sua máquina. Caso você não tenha instalado o Apache Tomcat, [consulte esta página](../tomcat/install-linux-ubuntu.md).


Interrompa a execução do Apache Tomcat:

```shell
~/tomcat/apache-tomcat-8.5/bin/shutdown.sh
```

A instalação do GeoServer é feita através do arquivo de *deploy* (`.war`). Faça o download deste arquivo:

```shell
wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.15.0/geoserver-2.15.0-war.zip
```


Após realizar o download, descompacte o arquivo zip baixado:

```shell
unzip geoserver-2.15.0-war.zip
```


Em seguida, copie o arquivo `geoserver.war` para o diretório `webapps`, presente no diretório de instalação do Apache Tomcat:

```shell
cp geoserver.war ~/tomcat/apache-tomcat-8.5/webapps/geoserver.war
```


Inicialize o Apache Tomcat e aguarde a finalização de sua inicialização: 

```shell
~/tomcat/apache-tomcat-8.5/bin/startup.sh
```


Para testar sua instalação, abra o navegador e acesse o seguinte endereço: [http://127.0.0.1:8080/geoserver](http://127.0.0.1:8080/geoserver). A página de administração do geoserver deverá ser exibida.


A credencial padrão do GeoServer é a seguinte:
  - **Usuário:** admin
  - **Senha:** geoserver
