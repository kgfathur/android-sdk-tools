
FROM gradle:7.6-jdk8-focal

LABEL maintainer="kgfathur" \
      name="android-sdk" \
      description="Java, Gradle, Android SDK, NodeJS, Ionic, and Cordova Installed"

USER root
COPY src /src

RUN chmod +x /src/setup.sh \
  && bash /src/setup.sh \
  && rm -vrf /src \
  && rm -rf /var/log/*

ENV PATH="$PATH:/opt/android-sdk/cmdline-tools/8.0/bin:/opt/android-sdk/tools/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/emulator" \
  ANDROID_SDK_ROOT="/opt/android-sdk"