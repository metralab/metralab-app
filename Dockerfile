FROM ubuntu

# variables
ARG DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT="/home/android"
ENV PATH="$PATH:/flutter/bin:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin"

# dependencies (alpine: apk add bash curl file git zip ruby-full npm)
RUN apt-get update && apt-get install -y tzdata
RUN apt-get install -y curl git zip openjdk-8-jdk openssh-server
RUN curl -o android_tools.zip https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
RUN unzip -qq -d $ANDROID_SDK_ROOT android_tools.zip && rm android_tools.zip
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools
RUN mv $ANDROID_SDK_ROOT/tools $ANDROID_SDK_ROOT/cmdline-tools/tools
RUN yes "y" | sdkmanager "build-tools;30.0.0"
RUN git clone https://github.com/flutter/flutter.git
RUN flutter channel stable

# environment
ARG ssh_prv_key
ARG ssh_pub_key
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub
RUN git config --global user.email "giorgiogiuffre23@gmail.com"
RUN git config --global user.name "Giorgio Giuffrè"
RUN git clone git@github.com:metralab/metralab-app.git metralab

# setup and testing
WORKDIR /metralab
RUN flutter pub get
RUN flutter test

# web build
WORKDIR /metralab
RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter create .
RUN sed -i 's#base href="/#base href="/metralab-app/#' web/index.html
RUN flutter build web

# web deployment
WORKDIR /metralab
RUN git --work-tree build/web add --all
RUN git commit -m "Dockerized deployment"
RUN git push origin HEAD:gh-pages --force

# cleanup after using Flutter web
WORKDIR /metralab
RUN flutter channel stable
RUN flutter upgrade

# # Android build
# WORKDIR /metralab
# RUN flutter build appbundle

# # Android deployment
# WORKDIR /metralab/android
# RUN gem install fastlane (--> requires apt-get install ruby-full)
# RUN fastlane init
# # ...

# # iOS build
# WORKDIR /metralab
# RUN flutter build ios --release --no-codesign

# # iOS deployment
# WORKDIR /metralab/ios
# RUN fastlane init
# # ...
