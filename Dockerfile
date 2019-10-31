FROM circleci/android:api-28

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get -qq update && \
  sudo apt-get -y install --no-install-recommends libglu1-mesa \
  lib32stdc++6 \
  curl \ 
  xz-utils \ 
  git \
  unzip \ 
  xz-utils \
  lcov \
  software-properties-common > /dev/null \
  && sudo apt-get --purge autoremove > /dev/null \
  && sudo apt-get autoclean > /dev/null \
  && sudo rm -rf /var/lib/apt/lists/*

ENV FLUTTER_VERSION 1.7.8+hotfix.4-stable
ENV FLUTTER_HOME /home/circleci/flutter

RUN cd /home/circleci/ && wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v${FLUTTER_VERSION}.tar.xz

RUN cd /home/circleci && \
  tar xf flutter_linux_v${FLUTTER_VERSION}.tar.xz

RUN cd /home/circleci && \
  rm -rf flutter_linux_v${FLUTTER_VERSION}.tar.xz

ENV PATH ${PATH}:${FLUTTER_HOME}/bin

RUN flutter config --no-analytics

RUN flutter doctor

RUN gem install bundler

WORKDIR /
