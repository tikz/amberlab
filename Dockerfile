
FROM ubuntu:20.04
MAINTAINER Mauro Song <mauronicolassong@gmail.com>

# Descomentar para buildear en la red de la facultad
# ENV http_proxy http://proxy.fcen.uba.ar:8080

RUN apt-get update
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata locales

# Amber 20
RUN apt-get -y install gcc cmake g++ gfortran curl python3 python3-tk python3-pip flex bison zlib1g-dev libnetcdf-dev libboost-all-dev libbz2-dev

ADD amber/Amber20.RC4.tar.bz2 /amber
ADD amber/AmberTools20.RC4.tar.bz2 /amber
WORKDIR /amber/amber20_src/build

RUN pip3 install numpy scipy matplotlib setuptools
RUN sed -i 's!-DDOWNLOAD_MINICONDA=TRUE!-DPYTHON_EXECUTABLE=/usr/bin/python3!g' /amber/amber20_src/build/run_cmake

RUN ./run_cmake
RUN make
RUN make install

# JupyterLab
RUN pip3 install jupyterlab
RUN sed -i 's!"language": "python"!"language": "python", "env": { "PYTHONPATH": "${PYTHONPATH}:/amber/amber20/lib/python3.8/site-packages" }!g' /usr/local/share/jupyter/kernels/python3/kernel.json

# JupyterLab themes
RUN curl -s -L https://deb.nodesource.com/setup_14.x | bash
RUN apt-get install -y nodejs
RUN jupyter labextension install @arbennett/base16-monokai @arbennett/base16-nord @arbennett/base16-one-dark

ENV SHELL /bin/bash

# User
RUN useradd -m -s /bin/bash user
ADD default-settings/ /home/user/.jupyter
WORKDIR /home/user
RUN mkdir /home/user/workspace
RUN chown -R user:user /home/user

# sudo
RUN apt-get install -y sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN usermod -aG sudo user

# Libs
RUN pip3 install pandas seaborn nglview
RUN jupyter-nbextension enable nglview --py --sys-prefix


COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT /run.sh
