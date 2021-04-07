# amberlab

Contiene:

- JupyterLab
- Amber 20 (CPU)
- AmberTools 20
- pytraj
- sci-kit
- pandas
- matplotlib
- seaborn
- nglview
- gluten
- aspartamo
- glutamato monosódico

## Uso
No es necesario clonar este repositorio, basta con correr el siguiente comando para descargar la imagen de DockerHub y lanzar el contenedor:

`docker run -p 8888:8888 -v ~/amberlab-workspace:/home/user/workspace --name amberlab tikz/amberlab`

En caso de que estés detrás del proxy nefasto de la facultad y tus scripts necesiten hacer requests HTTP, para que funcionen hay que agregar la variable de entorno `http_proxy`:

`docker run -p 8888:8888 -v ~/amberlab-workspace:/home/user/workspace -e http_proxy="http://proxy.fcen.uba.ar:8080" --name amberlab tikz/amberlab`

---------------

Si todo salió bien, JupyterLab debería ser accesible en http://localhost:8888

La carpeta `amberlab-workspace` que fue creada en tu home al correr el comando anterior contiene los mismos archivos que son mostrados en la barra izquierda del JupyterLab.
