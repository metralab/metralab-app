FROM cirrusci/flutter

# Flutter setup
RUN flutter channel stable
RUN flutter upgrade

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

# project setup and testing
WORKDIR /metralab
RUN flutter pub get
RUN flutter test

# web build
WORKDIR /metralab
RUN sed -i 's#base href="/#base href="/metralab-app/#' web/index.html
RUN flutter build web

# web deployment
WORKDIR /metralab
RUN git --work-tree build/web add --all
RUN git commit -m "Dockerized deployment"
RUN git push origin HEAD:gh-pages --force

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
