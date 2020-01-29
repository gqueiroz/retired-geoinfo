# Instalação do Apache Tomcat para Linux Ubuntu

> Os passos apresentados abaixo foram realizados no Ubuntu 18.04 LTS


## Preparando o Ambiente Java

Para realizar a instalação do Apache Tomcat 8.5 é necessário configurar o ambiente Java 1.8. Além do ambiente Java algumas ferramentas auxíliares como `unzip` e `curl` também serão instaladas no comando abaixo:

```shell
sudo apt update -y && sudo apt install openjdk-8-jdk unzip curl -y
```


Com as ferramentas necessárias instaladas, faça o *download* do Apache Tomcat. Para isso, utilize os seguintes comandos:

```shell
cd /tmp

curl -o apache-tomcat-8.5.50.zip https://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.50/bin/apache-tomcat-8.5.50.zip
```


Após o download, você deve extrair o conteúdo baixado dentro do diretório `~/tomcat`, como apresentado abaixo:

```shell
unzip apache-tomcat-*.zip

mkdir -p ~/tomcat

mv apache-tomcat-* ~/tomcat

mv ~/tomcat/apache-tomcat-8.5.50/ ~/tomcat/apache-tomcat-8.5
```


Para configurar a utilização de recursos do seu computador por parte do Apache Tomcat, como memória RAM, faça o download do arquivo [conf/tomcat.env.sh](./linux-conf/tomcat.env.sh) e o copie para o diretório de execução do tomcat, como mostrado no comando abaixo:

```shell
curl -o tomcat.env.sh https://raw.githubusercontent.com/gqueiroz/geoinfo/master/tomcat/linux-conf/tomcat.env.sh


cp tomcat.env.sh ~/tomcat/apache-tomcat-8.5/bin/setenv.sh
```


Por fim, atribua a permissão de execução para todos os *scripts* do tomcat:

```shell
chmod +x ~/tomcat/apache-tomcat-8.5/bin/*.sh
```


Pronto! O tomcat foi configurado!


Para lançar o Apache Tomcat, utilize o seguinte comando:
```shell
~/tomcat/apache-tomcat-8.5/bin/startup.sh
```



Mais informações sobre a instalação podem ser encontradas em: [Apache Tomcat](http://tomcat.apache.org/).