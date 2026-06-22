# Multiplayer View Distance

In vanilla Arma 3 multiplayer the view distance is locked to 1600m and terrain grid size (terrain quality) is locked to 10. It is not respecting client's nor server's video settings.

This mod makes the multiplayer respect the client's view distance and terrain grid settings, just like in single player. They cannot however be raised over the server's respective settings, this allows the server to control players' maximum view distances.

The mod is very simple and works purely in the background. It does not expose any UI or configurable options. The user won't notice it running in any other way than view distance respecting the user's settings in multiplayer.

## How to build

1. Have [HEMTT](https://github.com/BrettMayson/HEMTT) installed
2. Run `hemtt build` in the project directory

## TODO

- Create a logo and description for the mod
- Make the build script create a complete mod directory structure
- Sign the mod releases
- Publish the mod in Steam Workshop
