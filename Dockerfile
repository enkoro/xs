FROM nginx:stable-alpine

RUN uname -a

# ARG XRAY_VERSION=v1.8.23
#
# RUN wget https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-android-arm64-v8a.zip

# RUN bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
