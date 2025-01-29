# Utilizar una imagen base de Ubuntu
FROM ubuntu:20.04

# Establecer variables de entorno para evitar interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    autoconf \
    automake \
    texinfo \
    libcfitsio-dev \
    wcslib-dev \
    libtool \
    wget \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libsqlite3-dev \
    libcurl4-gnutls-dev 

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /home

# Descargar y descomprimir GSL
RUN wget https://ftp.gnu.org/gnu/gsl/gsl-latest.tar.gz && \
    tar -xf gsl-latest.tar.gz


# Configurar, compilar e instalar GSL
RUN cd gsl-2* && \
    ./configure CFLAGS="$CFLAGS -g0 -O3" && \
    make
RUN cd gsl-2* && make install

RUN cd .. && rm -rf gsl-*
    
# Set environment variable for library path
ENV LD_LIBRARY_PATH=/usr/local/lib

# Clonar el repositorio específico y cambiar a la rama 'deconvolution'
RUN git clone --branch deconvolution https://github.com/alvaromrls/gnuastro.git /gnuastro

# Establecer el directorio de trabajo
WORKDIR /gnuastro

# Configurar, compilar e instalar Gnuastro
RUN sed -i '/^\s*doc\s*\\$/d' Makefile.am 
# (ignorar la doc)^^^^^^^^
RUN ./bootstrap 
RUN  ./configure 
RUN make 
RUN make install

# Establecer el directorio de trabajo para el usuario
RUN mkdir -p /workspace
WORKDIR /workspace

# Definir el punto de entrada para la terminal
ENTRYPOINT ["/bin/bash"]
