if (isMultiplayer) then {
    // Default values to allow the server itself to have no limit when adjusting its view distance. We cannot use actual infinity (1e39 in SQF) because ArmaScriptCompiler will fail to compile it, so using 1e38 instead.
    serverViewDistance = 1e38;
    serverTerrainGrid = 0;

    // Start the first view distance correction on server side
    if (isServer) then {
        call mpvd_fnc_updateViewDistance;
    };

    // If the process has interface, whether client or server, add some UI event handlers
    if (hasInterface) then {
        // Event handler for opening video options dialog
        [missionNamespace, "OnDisplayRegistered", {
            params ["_display", "_class"];
            if (_class isEqualTo "RscDisplayOptionsVideo") then {

                // Event handler for changing view distance in video options. 103 = IDC_OPTIONS_VISIBILITY_VALUE, overall visibility number field.
                (_display displayCtrl 103) ctrlAddEventHandler ["EditChanged", {
                    params ["_control", "_newText"];

                    private _newViewDistance = parseNumber _newText;
                    setViewDistance (serverViewDistance min _newViewDistance);
                }];

                // Event handler for changing terrain grid in video options. 123 = IDC_OPTIONS_TERRAIN, terrain quality dropdown menu.
                (_display displayCtrl 123) ctrlAddEventHandler ["LBSelChanged", {
                    params ["_control", "_lbCurSel"];

                    // The dropdown menu does not directly contain terrain grid values, so searching for them in config by using the texts from the dropdown menu
                    private _newTerrainGrid = getNumber (("getText (_x >> 'text') isEqualTo (_control lbText _lbCurSel)" configClasses (configfile >> "CfgVideoOptions" >> "TerrainQuality")) # 0 >> "terrainGrid");
                    setTerrainGrid (serverTerrainGrid max _newTerrainGrid);
                }];
            };
        }] call BIS_fnc_addScriptedEventHandler;

        // Event handler for closing video options dialog. By default it is run in uiNamespace, so switching to missionNamespace.
        [missionNamespace, "OnDisplayUnregistered", {
            params ["_display", "_class"];
            if (_class isEqualTo "RscDisplayOptionsVideo") then {
                with missionNamespace do {

                    call mpvd_fnc_updateViewDistance;
                };
            };
        }] call BIS_fnc_addScriptedEventHandler;
    };
};
