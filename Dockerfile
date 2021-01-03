FROM ubuntu

COPY android /metralab/android
COPY ios /metralab/ios
COPY lib /metralab/lib
COPY test /metralab/test
COPY .git /metralab/.git
COPY .gitignore /metralab/.gitignore
COPY .metadata /metralab/.metadata
COPY Gemfile /metralab/Gemfile
COPY Gemfile.lock /metralab/Gemfile.lock
COPY metralab.iml /metralab/metralab.iml
COPY pubspec.yaml /metralab/pubspec.yaml

# dependencies
WORKDIR /
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
RUN apt-get install -y curl git zip openjdk-8-jdk  ruby-full npm
# RUN apk add bash curl file git zip ruby-full npm
RUN curl -o android_tools.zip https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
ENV ANDROID_SDK_ROOT="/home/android"
RUN unzip -qq -d $ANDROID_SDK_ROOT android_tools.zip && rm android_tools.zip
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools
RUN mv $ANDROID_SDK_ROOT/tools $ANDROID_SDK_ROOT/cmdline-tools/tools
ENV PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/platforms"
RUN yes "y" | sdkmanager "build-tools;30.0.0"
RUN git clone https://github.com/flutter/flutter.git
ENV PATH="$PATH:/flutter/bin"
RUN flutter channel stable

# setup and testing
WORKDIR /metralab
# RUN gem install fastlane
RUN npm install -g gh-pages
RUN flutter pub get
RUN flutter test

# Android build
WORKDIR /metralab
RUN flutter build appbundle

# # Android deployment
# WORKDIR /metralab/android
# RUN fastlane init
# # ...

# # iOS build
# WORKDIR /metralab
# RUN flutter build ios --release --no-codesign

# # iOS deployment
# WORKDIR /metralab/ios
# RUN fastlane init
# # ...

# web build
WORKDIR /metralab
RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter create .
RUN flutter build web

# # web deployment
# WORKDIR /metralab/
# RUN touch package.json && echo "{}" > package.json # gh-pages needs it
# RUN yes "yes" | gh-pages -d build/web

# # cleanup
# WORKDIR /metralab
# RUN flutter channel stable
