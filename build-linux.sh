#!/bin/bash

# Enter paths to your tools here
# Wine binary can often just be "wine64"
WINE_BINARY="/cs/group/gurula/wine/bin/wine.sh"
ARMA_TOOLS_PATH="/cs/group/gurula/arma-tools/arma3tools"
ARMASCRIPTCOMPILER_PATH="/cs/group/gurula/arma-tools/ArmaScriptCompiler.exe"

# You must have a P: drive in your wineprefix
P_DRIVE_PATH="$("$WINE_BINARY" winepath -u P:)"

MOD_ROOT_PATH="$(dirname "$(realpath "$0")")"
cd "$MOD_ROOT_PATH"

ADDON_NAME="multiplayer_view_distance"

# Copy addon to P: drive
rm -r "$P_DRIVE_PATH/$ADDON_NAME"
cp -r "addons/$ADDON_NAME" "$P_DRIVE_PATH/$ADDON_NAME"

# Compile sqf scripts with ArmaScriptCompiler (reads config from sqfc.json)
# The project must be on P: drive
"$WINE_BINARY" "$ARMASCRIPTCOMPILER_PATH"

# If there was any error in compilation, exit
if [[ -s "$P_DRIVE_PATH/log.txt" ]]; then
    cat "$P_DRIVE_PATH/log.txt"
    exit 1
fi

# Clear the AddonBuilder temp directory before building
rm -r "/tmp/$ADDON_NAME"

# Build pbo with Bohemia's AddonBuilder
WINDOWS_MOD_ROOT_PATH="$("$WINE_BINARY" winepath -w "$MOD_ROOT_PATH")"
WINDOWS_ARMA_TOOLS_PATH="$("$WINE_BINARY" winepath -w "$ARMA_TOOLS_PATH")"
WINDOWS_TMP="$("$WINE_BINARY" winepath -w /tmp)"

"$WINE_BINARY" "$ARMA_TOOLS_PATH/AddonBuilder/AddonBuilder.exe" "-toolsDirectory=$WINDOWS_ARMA_TOOLS_PATH" "-temp=$WINDOWS_TMP" "P:\\$ADDON_NAME" "$WINDOWS_MOD_ROOT_PATH" "-include=$WINDOWS_MOD_ROOT_PATH\\includes.txt"
