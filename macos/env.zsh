if [[ "$OS" == macos ]]; then
  export CLICOLOR=1

  local android_path="$HOME/Library/Android/sdk"
  if [[ -d "$android_path" ]]; then
    export ANDROID_SDK_ROOT="$android_path"
    export ANDROID_HOME="$android_path"
    export PATH="$PATH:$android_path/emulator:$android_path/platform-tools:$android_path/tools/bin"
  fi
fi
