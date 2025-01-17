FROM @UNAME@/builders:@BASETAG@
RUN apt update && apt -y install \
        bison flex \
	ccache \
        android-tools-adb \
        lib32stdc++6 \
        lib32z1 \
        lib32z1-dev \
        zlib1g-dev && \
    wget @SDKZIP@ -qO /sdk.zip && \
    sudo -u @UNAME@ mkdir -p /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools && \
    sudo -u @UNAME@ unzip -q /sdk.zip -d /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/latest && \
    mv /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/latest/cmdline-tools/* /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/latest/ && \
    yes | \
    sudo -u @UNAME@ /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager --licenses && \
    sudo -u @UNAME@ /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager @SDKINSTALL@ && \
    sudo -u @UNAME@ keytool -genkey -keystore /home/@UNAME@/.android/debug.keystore -v -alias androiddebugkey \
                            -dname "CN=Android Debug,O=Android,C=US" -keypass android -storepass android \
                            -keyalg RSA -keysize 2048 -validity 10000 && \
    rm -rf /sdk.zip /ndk.zip /var/lib/apt/lists/* && \
    ln -s /home/@UNAME@/android-tools/android-sdk-linux/cmdline-tools/platform-tools/adb /usr/local/bin/adb && \
    sudo -u @UNAME@ mkdir \
            /home/@UNAME@/.cache \
            /home/@UNAME@/.tmp
