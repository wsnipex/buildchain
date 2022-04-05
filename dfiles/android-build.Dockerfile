FROM @UNAME@/builders:@BASETAG@
RUN apt update && apt -y install \
        android-tools-adb \
        lib32stdc++6 \
        lib32z1 \
        lib32z1-dev \
        zlib1g-dev && \
    wget @SDKZIP@ -qO /sdk.zip && \
    wget @NDKZIP@ -qO /ndk.zip && \
    sudo -u @UNAME@ mkdir -p /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools && \
    sudo -u @UNAME@ unzip -q /sdk.zip -d /home/@UNAME@/android-tools/android-sdk-linux && \
    sudo -u @UNAME@ unzip -q /ndk.zip -d /home/@UNAME@/android-tools && \
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
    rm -rf /sdk.zip /ndk.zip /var/lib/apt/lists/* && \
    sudo -u @UNAME@ mkdir \
            /home/@UNAME@/.cache \
            /home/@UNAME@/.tmp
