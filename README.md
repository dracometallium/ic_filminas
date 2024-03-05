# Filminas para Introducción a la computación

Normalmente unas filminas hechas en _LaTex_ no requieren mucha introducción,
pero este repo es más que eso. Ademas de los `.tex`, este repositorio contiene
un conjunto de _scripts_ y un `Makefile` que ayudan a generar, administrar y
transformar distintos recursos.

## Requerimientos

Para funcionar correctamente se necesita tener instalados los siguientes
programas:

-   `makefile`
-   `inkscape`
-   `vim`
-   `pdflatex`
-   `imagemagick`

## Uso

-   `make` o `make all`: Crea todos los archivos.
-   `make pdf-only`: Crea los archivos, y luego remueve los temporales.
-   `make resize`: Redimensiona las imágenes de tipo rasterizadas (formatos
    `jpg` y `png`) a un tamaño máximo de **1080x1080px**. Esto se hace con el
    fin de reducir el espació ocupado por estas, manteniendo una buena
    calidad ¡Se debe ejecutar antes de hacer el `git add`!
-   `make clean`: Elimina todos los archivos generados por `make`.
-   `make help`: Muestra una ayuda.

## Consideraciones

-   Todas las imágenes (que no sean parte de una animación) deben estar dentro
    de la carpeta `img` o `logos`.
-   Las imágenes almacenadas deben se de tipo `svg`, `png` o `jpg`. Si se
    almacena una imagen en formato `pdf`, sera removida por `make clean`.
-   El `Makefile` tiene una función para crear `pdf`s a partir de código _C_,
    sin embargo se debe crear una carpeta acorde para almacenarlo, y
    configurar la variable `CODIGO` del `Makefile`.
-   **¡¡REDIMENSIONAR LAS IMÁGENES!!** Ejecutar `make resize` antes de `git
    add`.
-   Se provee una herramienta para generar animaciones burdas, cada
    _"fotograma"_ se almacena en la carpeta `ani`. Su funcionamiento se
    explica a continuación.

### Generador de """animaciones"""

Se incluye una herramienta para generar animaciones muy burdas, donde en cada
paso se agrega contenido sobre el fotograma anterior. Ver el ejemplo **Sistema
posicional ¿Cómo entendemos un numeral?** de la filmina
`02-sitemasNumeracion.pdf`.

El método de uso es sencillo. Se debe crear un `svg`, con capas llamadas
_L00_, _L01_, _L02_, ... _LNN_. Por cada capa _LXX_ se genera un archivo
`ani/<nombre_base>-XX.pdf`, donde solo se muestran las capas de la _L00_ a la
_LXX_ (todas las capaz por arriba de la capa _LXX_ están ocultas).
