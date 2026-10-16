source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting
end

# Configuración del Android SDK para Fish
set -gx ANDROID_HOME $HOME/Android/Sdk

# Agregar herramientas de Android al PATH de forma nativa en Fish
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools

# Configuración de Java (JDK 17) para Fish
set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk
fish_add_path $JAVA_HOME/bin
