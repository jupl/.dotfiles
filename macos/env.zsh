if [[ "$OS" == macos ]]; then
  export CLICOLOR=1
  export ANDROID_SDK_ROOT='/usr/local/share/android-sdk'
  if [[ ! -d "$ANDROID_SDK_ROOT" ]]; then
    unset ANDROID_SDK_ROOT
  fi
fi
