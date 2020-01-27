# Instalação do PostgreSQL/PostGIS para Microsoft Windows 10


## Instalação do PostgreSQL 11.6

Na página de download do [PostgreSQL](https://www.postgresql.org/download/), selecione a opção `Windows`, como mostrado na figura abaixo.

![Download page PostgreSQL](./img/pg-download.png "Download page PostgreSQL")


Ao selecionar a opção `Windows` você será redirecionado para a página de instaladores do Windows. Acesse o *link* `Download the installer` como mostrado a seguir:

![Windows page installer PostgreSQL](./img/pg-download-2.png "Windows page installer PostgreSQ")


Após o acesso, é exibida uma tabela de opções de instaladores. Selecione a opção `PostgreSQL Version` `11.6` para `Windows x86-64` como indicado na figura.

![PostgreSQL Database Download](./img/pg-download-3.png "PostgreSQL Database Download")

Após o download ser concluído, siga os passos apresentados a seguir:


**1.** No diretório de Downloads do Windows, abra o instalador `postgresql-11.6-3-windows-x64`:

![PostgreSQL Installer](./img/pg-win-install-01.png "PostgreSQL Installer")


**2.** Após iniciar o instalador, será exibida uma janela para configuração do PostgreSQL (`Setup - PostgreSQL`). Pressione `Next >` para continuar.

![PostgreSQL Setup](./img/pg-win-install-02.png "PostgreSQL Setup")


**3.** Se você possui um disco SSD de pequeno porte, sugerimos alterar o local da pasta de destino do PostgreSQL para um disco com maior capacidade. Aponte para o diretório que você deseja instalar o PostgreSQL e pressione `Next >` para continuar.

![PostgreSQL Install Directory](./img/pg-win-install-03.png "PostgreSQL Install Directory")


**4.** O instalador irá apresentar as opções de componentes a serem instalados. Selecione as opções de acordo com a imagem a seguir, e pressione `Next >` para continuar.

![PostgreSQL Components](./img/pg-win-install-04.png "PostgreSQL Components")


**5.** Assim como no **passo 3**, se você possui um disco SSD de pequeno porte, sugerimos alterar o local da pasta de destino dos dados a serem armazenados para um disco com maior capacidade. Aponte para a pasta desejada e pressione `Next >` para continuar.

![PostgreSQL Data Directory](./img/pg-win-install-05.png "PostgreSQL Data Directory")


**6.** Defina uma senha para o superusuário postgresql, e pressione `Next >` para continuar.

![PostgreSQL Password](./img/pg-win-install-06.png "PostgreSQL Password")


**7.** Selecione o número da porta desejada para o servidor PostgreSQL. Por padrão define-se o número de porta `5432`. Caso a porta `5432` já esteja em uso por outra aplicação, utilize outro número de porta para o servidor PostgreSQL. Pressione `Next >` para continuar.

![PostgreSQL Port](./img/pg-win-install-07.png "PostgreSQL Port")


**8.** Na etapa de opções avançadas (`Advanced Options`) mantenha `Locale` definido como apresentado na figura abaixo, e pressione `Next >` para continuar

![PostgreSQL Advanced Options](./img/pg-win-install-08.png "Advanced Options")


**9.** A próxima janela apresenta um resumo das opções de configuração que serão utilizadas na instalação do PostgreSQL. Pressione `Next >` para continuar.

![PostgreSQL Installation Summary](./img/pg-win-install-09.png "Summary")


**10.** Essa janela mostra apenas que o processo de instalação encontra-se em progresso:

![PostgreSQL Progress](./img/pg-win-install-10.png "Progress")


**11.** Ao final da instalação, uma janela como mostrada abaixo será apresentada. Mantenha a opção `Stack Builder` selecionada. Pressione `Finish` para finalilzar a instalação do PostgreSQL:

![PostgreSQL Finish](./img/pg-win-install-11.png "Finish")


## Instalação do PostGIS 2.5

Mantendo a opção `Stack Builder` selecionada ao final da instalação do PostgreSQL, será apresentada uma nova janela de instalação (`Stack Builder 4.2.0`). O `Stack Builder` é utilizado para fazer o download e instalação de ferramentas e aplicações adicionais ao PostgreSQL.


O `Stack Builder` será utilizado para instalação da extensão espacial PostGIS, para isto, siga os passos apresentados a seguir:


**1.** Na primeira janela exibida pelo `Stack Builder` é apresentada a versão (ou versões) do PostgreSQL instalada no sistema. Selecione a opção `PostgreSQL 11(x64)` como mostrado na figura abaixo e pressione `Next >` para continuar.

![Welcome to Stack Builder](./img/pg-win-install-12.png "Welcome to Stack Builder")


**2.** No item de `Categories`, abra o subitem `Spatial Extensions` e selecione a opção `PostGIS 2.5 Bundle for PostgreSQL 11 (64bit) v2.5.3` como ilustrado na próxima figura. Pressione `Next >` para continuar.

![Stack Builder Categories](./img/pg-win-install-13.png "Stack Builder Categories")


**3.** Aponte para o diretório que você deseja realizar o download do instalador PostGIS e pressione `Next >` para continuar.

![Stack Builder PostGIS Directory Download](./img/pg-win-install-14.png "Stack Builder PostGIS Directory Download")


**4.** Conforme apresenta a próxima imagem, mantenha a opção `Skip Installation` desmarcada e pressione `Next >` para iniciar a instalação do PostGIS.

![Stack Builder PostGIS Download Finish](./img/pg-win-install-15.png "Stack Builder PostGIS Download Finish")


**5.** Ao final do processo de download será exibida uma nova janela para dar continuidade a instalação do PostGIS. O PostGIS é baseado em diversos softwares livres. Nessa janela você deverá aceitar os termos da licença do PostGIS e de outros sistemas ou bibliotecas. Pressione `I Agree >` para continuar:

![PostGIS License Agreement](./img/pgis-win-install-01.png "PostGIS License Agreement")


**6.** Na opção de componentes a serem instalados, selecione conforme indicado na figura e pressione `Next >`.

![PostGIS Choose Components](./img/pgis-win-install-02.png "PostGIS Choose Components")


**7.** Aponte para o diretório que você deseja instalar o PostGIS e pressione `Next >`.

![PostGIS Choose Install Location](./img/pgis-win-install-03.png "PostGIS Choose Install Location")


**8.** Essa janela mostra apenas que o processo de instalação do PostGIS encontra-se em progresso:

![PostGIS Progress](./img/pgis-win-install-04.png "PostGIS Progress")


**9.** Selecione `Sim (Yes)`para registrar a variável de ambiente `GDAL_DATA` como apresentado abaixo:

![PostGIS GDAL_DATA](./img/pgis-win-install-05.png "PostGIS GDAL_DATA")


**10.** Selecione `Sim (Yes)` para habilitar os drives de dados raster, registrando a variável de ambiente `POSTGIS_GDAL_ENABLED_DRIVERS`.

![PostGIS POSTGIS_GDAL_ENABLED_DRIVERS](./img/pgis-win-install-06.png "POSTGIS_GDAL_ENABLED_DRIVERS")


**11.** Selecione `Sim (Yes)`para registrar a variável de ambiente `POSTGIS_ENABLE_OUTDB_RASTERS` como indicado.

![PostGIS POSTGIS_ENABLE_OUTDB_RASTERS](./img/pgis-win-install-07.png "POSTGIS_ENABLE_OUTDB_RASTERS")


**12.** Se o processo de instalação foi realizado com sucesso, uma janela como mostrada abaixo será apresentada. Pressione `Close` para finalilzar a instalação:

![PostGIS Install Finish](./img/pgis-win-install-08.png "PostGIS Install Finish")


**13.** Ao final da instalação, será apresentada a janela do `Stack Builder` confirmando o processo de instalação do PostGIS. Pressione `Finish` para finalilzar o processo.

![Stack Builder PostGIS Install Finish](./img/pgis-win-install-09.png "Stack Builder PostGIS Install Finish")


## Testando a instalação do PostgreSQL/PostGIS para Microsoft Windows 10

O PostgreSQL/PostGIS pode ser acessado através de diferentes formas. Utilizaremos a aplicação `pgAdmin4` (instalado durante o processo de instalação do PostgreSQL).


No menu de aplicações do Windows 10 encontre e inicialize o `pgAdmin 4` como indicado na figura abaixo:

![Menu Win pgAdmin](./img/pg-win-start-pgadmin.png "Menu Win pgAdmin")


No primeiro acesso ao `pgAdmin 4`, será necessário definir uma senha (aplicável apenas a usuários do modo de área de trabalho) que irá ser utilizada para proteger e desbloquear posteriormente as senhas salvas do servidor. Pressione `OK` para continuar

![pgAdmin Password](./img/pgadmin4-password.png "pgAdmin Password")


Ao inicializar o `pgAdmin 4`, uma janela como a mostrada abaixo será exibida:

![pgAdmin Tela Inicial](./img/pgadmin4-tela-inicial.png "pgAdmin Tela Inicial")
