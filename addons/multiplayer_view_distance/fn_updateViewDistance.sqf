private _videoOptions = getVideoOptions;
private _localViewDistance = _videoOptions get "overallVisibility";
private _localTerrainGrid = _videoOptions get "terrainQuality";

// Set view distance, but it cannot be higher than the server view distance. Server view distance is read from a global variable that should be set.
setViewDistance (serverViewDistance min _localViewDistance);
setTerrainGrid (serverTerrainGrid max _localTerrainGrid);

// Updating view distance on the server also affects clients, so send them updated variables and a command to update themselves
if (isServer) then {
    [_localViewDistance, _localTerrainGrid] remoteExecCall ["mpvd_fnc_processRemoteUpdate", -2, "MPVD_JIP_ID"]; // Using a common JIP ID so later updates overwrite old ones on the JIP queue
};
