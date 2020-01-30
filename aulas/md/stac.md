# SpatioTemporal Asset Catalog - Aula Prática


## Preparando Ambiente Python com Anaconda

Para criar um ambiente apropriado à execução do Jupyter Notebook dessa aula, crie um ambiente virtual com os seguintes pacotes (ou bibliotecas):

```shell
conda create --name geospatial \
             python=3 numpy matplotlib pandas \
             gdal shapely fiona  geopandas rasterio \
             notebook jupyterlab ipykernel nb_conda_kernels
```


Em seguida, ative o novo ambiente criado:

```shell
conda activate geospatial
```

O prompt do seu sistema deve ter incluído o prefixo `(geospatial)`, como mostrado abaixo:

```shell
(geospatial) gribeiro@enghaw-dell-note:~$ 
``` 


Nesse ambiente, vamos instalar o cliente STAC desenvolvido no projeto Brazil Data Cube:
```shell
python -m pip install -e git+https://github.com/brazil-data-cube/stac.py@STAC-0.8.0#egg=stac
```


Vá para a pasta do curso e lance o ambiente do Jupyter Notebook:
```shell
cd ~/Curso

jupyter-notebook
```


