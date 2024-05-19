if (isMultiplayer) then {

    // Initialize the mod on server side
    if (isServer) then {
        private _videoOptions = getVideoOptions;
        serverViewDistance = _videoOptions get "overallVisibility";
        serverTerrainGrid = _videoOptions get "terrainQuality";

        setViewDistance serverViewDistance;
        setTerrainGrid serverTerrainGrid;

        [[serverViewDistance, serverTerrainGrid], {
            params ["_serverViewDistance", "_serverTerrainGrid"];
            serverViewDistance = _serverViewDistance;
            serverTerrainGrid = _serverTerrainGrid;

            private _videoOptions = getVideoOptions;
            private _clientViewDistance = _videoOptions get "overallVisibility";
            private _clientTerrainGrid = _videoOptions get "terrainQuality";

            setViewDistance (serverViewDistance min _clientViewDistance);
            setTerrainGrid (serverTerrainGrid max _clientTerrainGrid);
        }] remoteExec ["call", -2, "MPVD_JIP_ID"];
    };
    
    // If the process has interface, whether client or server, add some UI event handlers
    if (hasInterface) then {
        // Event handler for opening video options dialog
        [missionNamespace, "OnDisplayRegistered", {
            params ["_display", "_class"];
            if (_class isEqualTo "RscDisplayOptionsVideo") then {
                
                // Event handler for changing view distance in video options. 103 = overall visibility number field.
                (_display displayCtrl 103) ctrlAddEventHandler ["EditChanged", {
                    params ["_control", "_newText"];
                    
                    private _newViewDistance = parseNumber _newText;
                    if (isServer) then {
                        setViewDistance _newViewDistance;
                    } else {
                        setViewDistance (serverViewDistance min _newViewDistance);
                    };
                }];
                
                // Event handler for changing terrain grid in video options. 123 = terrain quality dropdown menu.
                (_display displayCtrl 123) ctrlAddEventHandler ["LBSelChanged", {
                    params ["_control", "_lbCurSel"];
                    
                    private _newTerrainGrid = getNumber (("getText (_x >> 'text') isEqualTo (_control lbText _lbCurSel)" configClasses (configfile >> "CfgVideoOptions" >> "TerrainQuality")) # 0 >> "terrainGrid");
                    if (isServer) then {
                        setTerrainGrid _newTerrainGrid;
                    } else {
                        setTerrainGrid (serverTerrainGrid max _newTerrainGrid);
                    };
                }];
            };
        }] call BIS_fnc_addScriptedEventHandler;

        // Event handler for closing video options dialog. By default it is run in uiNamespace, so switching to missionNamespace.
        [missionNamespace, "OnDisplayUnregistered", {
            with missionNamespace do {
                params ["_display", "_class"];
                if (_class isEqualTo "RscDisplayOptionsVideo") then {
                    
                    if (isServer) then {
                        private _videoOptions = getVideoOptions;
                        serverViewDistance = _videoOptions get "overallVisibility";
                        serverTerrainGrid = _videoOptions get "terrainQuality";

                        setViewDistance serverViewDistance;
                        setTerrainGrid serverTerrainGrid;
                        
                        [[serverViewDistance, serverTerrainGrid], {
                            params ["_serverViewDistance", "_serverTerrainGrid"];
                            serverViewDistance = _serverViewDistance;
                            serverTerrainGrid = _serverTerrainGrid;

                            private _videoOptions = getVideoOptions;
                            private _clientViewDistance = _videoOptions get "overallVisibility";
                            private _clientTerrainGrid = _videoOptions get "terrainQuality";

                            setViewDistance (serverViewDistance min _clientViewDistance);
                            setTerrainGrid (serverTerrainGrid max _clientTerrainGrid);
                        }] remoteExec ["call", -2, "MPVD_JIP_ID"]; // Using a common JIP ID so later updates overwrite old ones on the JIP queue
                    } else {
                        private _videoOptions = getVideoOptions;
                        private _clientViewDistance = _videoOptions get "overallVisibility";
                        private _clientTerrainGrid = _videoOptions get "terrainQuality";

                        setViewDistance (serverViewDistance min _clientViewDistance);
                        setTerrainGrid (serverTerrainGrid max _clientTerrainGrid);
                    };
                };
            };
        }] call BIS_fnc_addScriptedEventHandler;
    };
};
