#!/bin/bash

source /src/build-env \
  && INSTALL_PKGS=$(cat /src/pkg-list.txt) \
  && curl -fsSL https://deb.nodesource.com/setup_10.x | sed 's/sleep 20/sleep 3/g;' | bash - \
  && apt-get install -y $INSTALL_PKGS \
  && npm install -g ionic@5.4.16 \
  && npm install -g cordova@10.0.0 \
  && cordova --version \
  && ionic --version \
  && mkdir /opt/android-sdk/ \
  && wget -q -P /src --user=${NEXUS_REPO_USER} --password=${NEXUS_REPO_PASSWORD} ${ANDROID_SDK_TOOLS_URL} \
  && unzip -d /opt/android-sdk/cmdline-tools/ /src/commandlinetools-linux-8092744_latest.zip \
  && mv /opt/android-sdk/cmdline-tools/cmdline-tools /opt/android-sdk/cmdline-tools/8.0 \
  && source /src/android-sdk.sh \
  && yes | sdkmanager "build-tools;29.0.3" "platforms;android-29" \
  && yes | sdkmanager "platform-tools" \
  && unset $(cat /src/build-env | cut -d'=' -f1) \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -vrf /var/log/{apt,dpkg.log} \
  && rm -rf /var/lib/apt/lists/* \
  && rm -vrf /var/lib/apt \
  && rm -vrf /var/log/*