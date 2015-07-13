FROM ubuntu:14.04.2

MAINTAINER joee liew liewjoee@yahoo.com

#Add display driver
ADD NVIDIA-Linux-x86_64-340.76.run /tmp/NVIDIA-DRIVER.run
RUN apt-get update && apt-get install -yq kmod mesa-utils software-properties-common
RUN sh /tmp/NVIDIA-DRIVER.run -a -N --ui=none --no-kernel-module

#ADD codelite
RUN apt-key adv --fetch-keys http://repos.codelite.org/CodeLite.asc
RUN apt-add-repository 'deb http://repos.codelite.org/ubuntu/ trusty universe'
RUN apt-get update

RUN apt-get install -yq build-essential mono-gmcs mono-xbuild mono-dmcs \
  libmono-corlib4.0-cil libmono-system-data-datasetextensions4.0-cil \
  libmono-system-web-extensions4.0-cil libmono-system-management4.0-cil \
  libmono-system-xml-linq4.0-cil cmake dos2unix clang xdg-user-dirs pulseaudio alsa-utils \
  codelite wxcrafter x11-apps libclang-common-3.5-dev libclang1-3.5 libllvm3.5 llvm-3.5 \
  llvm-3.5-dev llvm-3.5-runtime libgtk-3-0 clang-3.5

#DONT WANT TO KEEP DOWNLOADING FROM GITHUB
#RUN git clone --progress --verbose -b 4.8 https://<user>:<password>@github.com/EpicGames/UnrealEngine.git

Add UnrealEngine /UnrealEngine

WORKDIR /UnrealEngine
RUN pwd
RUN ./Setup.sh
RUN ./GenerateProjectFiles.sh
