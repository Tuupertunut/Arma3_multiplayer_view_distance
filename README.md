# Multiplayer View Distance

In vanilla Arma 3 multiplayer the view distance is locked to 1600m and terrain grid size (terrain quality) is locked to 10. It is not respecting client's nor server's video settings.

This mod makes the multiplayer respect the client's view distance and terrain grid settings, just like in single player. They cannot however be raised over the server's respective settings, this allows the server to control players' maximum view distances.

The mod is very simple and works purely in the background. It does not expose any UI or configurable options. The user won't notice it running in any other way than view distance respecting the user's settings in multiplayer.

## How to build (on Linux)

1. Have Wine installed
2. Have P: drive setup in your wineprefix
3. Have Bohemia's [Arma 3 Tools](https://store.steampowered.com/app/233800/Arma_3_Tools/) (from Steam) downloaded somewhere
4. Have [ArmaScriptCompiler](https://github.com/dedmen/ArmaScriptCompiler) downloaded somewhere
5. Edit your Wine, Arma 3 Tools and ArmaScriptCompiler paths to the `build-linux.sh` script
6. Run `./build-linux.sh`

There are no Windows build instructions as I haven't built this mod on Windows.

## TODO

- Create a logo and description for the mod
- Make the build script create a complete mod directory structure
- Sign the mod releases
- Publish the mod in Steam Workshop
