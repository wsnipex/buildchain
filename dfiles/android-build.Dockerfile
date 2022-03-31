FROM @UNAME@/builders:@BASETAG@
RUN apt update && apt -y install \
        android-tools-adb \
        lib32stdc++6 \
        lib32z1 \
        lib32z1-dev \
        zlib1g-dev && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip -qO /sdk-latest.zip && \
    wget https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip -qO /ndk21e.zip && \
    sudo -u @UNAME@ mkdir -p /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools && \
    sudo -u @UNAME@ unzip -q /sdk-latest.zip -d /home/@UNAME@/android-tools/android-sdk-linux && \
    sudo -u @UNAME@ unzip -q /ndk21e.zip -d /home/@UNAME@/android-tools && \
    yes | \
    sudo -u @UNAME@ /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/bin/sdkmanager \
                    --sdk_root=/home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools \
                    --licenses && \
    sudo -u @UNAME@ /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/bin/sdkmanager \
                    --sdk_root=/home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools \
                    platform-tools && \
    sudo -u @UNAME@ /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/bin/sdkmanager \
                    --sdk_root=/home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools \
                    "platforms;android-28" && \
    sudo -u @UNAME@ /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/bin/sdkmanager \
                    --sdk_root=/home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools \
                    "build-tools;28.0.3" && \
    sudo -u @UNAME@ keytool -genkey -keystore /home/@UNAME@/.android/debug.keystore -v -alias androiddebugkey \
                            -dname "CN=Android Debug,O=Android,C=US" -keypass android -storepass android \
                            -keyalg RSA -keysize 2048 -validity 10000 && \
    rm -rf /sdk-latest.zip /ndk21e.zip /var/lib/apt/lists/* && \
    sudo -u @UNAME@ mkdir \
            /home/@UNAME@/.cache \
            /home/@UNAME@/.tmp
