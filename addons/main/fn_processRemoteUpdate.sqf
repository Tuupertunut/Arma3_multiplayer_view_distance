params ["_serverViewDistance", "_serverTerrainGrid"];
// Update global variables with new values before calling the update function
serverViewDistance = _serverViewDistance;
serverTerrainGrid = _serverTerrainGrid;

call mpvd_fnc_updateViewDistance;
