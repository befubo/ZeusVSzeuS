_side = _this select 0;
if(_side == WEST) then {
	
	zoneIndex = _this select 1;
	_zonesCount = count zones;
	if(_zonesCount > zoneIndex) then {
		
		posNewZone = getMarkerPos ("zone_" + str zoneIndex);
		posOldZone = getMarkerPos ("zone_" + str (zoneIndex - 1));
		posNewSpawn = getMarkerPos ("spawn_" + str zoneIndex);


	//------------------ MANAGE EDITING AREAS ---------------

		zeus_1 addCuratorEditingArea [zoneIndex,posOldZone,150];
		zeus_1 addCuratorCameraArea [zoneIndex,posOldZone,150];
		zeus_1 setCuratorCameraAreaCeiling 25;
		
		
		if(zoneIndex != 1) then {
			zeus_2 removeCuratorEditingArea (zoneIndex + 99);
			zeus_1 removeCuratorEditingArea (zoneIndex - 1);
			};
		zeus_2 addCuratorEditingArea [(zoneIndex + 100),posNewSpawn,50];
		zeus_2 addCuratorEditingArea [(zoneIndex + 200),posNewZone,150];

	//------------------ MANAGE SECTOR ----------------------
		if(zoneIndex != 1) then {deleteVehicle sector;};
		[posNewZone,150,zoneLetters select (zoneIndex - 1),zoneNames select (zoneIndex - 1),(zoneIndex + 1)] execVM "createSector.sqf";
		
	//------------------ MANAGE RESSOURCES ------------------
		
		if(zoneIndex != 1) then {
		zeus_1 addCuratorPoints 0.5;
		zeus_2 addCuratorPoints 0.5;
		};
		
	//------------------ MANAGE SCORE ----------------------
		if(globalVars getVariable "gamemode" == 1) then {
			[globalVars getVariable "advance_time_attacker"] call BIS_fnc_countDown;
		};
		if(globalVars getVariable "gamemode" == 2 && zoneIndex != 1) then {
			_newScore = (globalVars getVariable "score_blufor") + 1;
			globalVars setVariable ["score_blufor", _newScore, true];
		};
		
		
	//------------------ MANAGE WP HANDLERS ----------------
		
		_eh = zeus_1 addEventHandler ["CuratorWaypointPlaced", {
			params ["_curator", "_group", "_waypointID"];
			deleteWaypoint [_group, _waypointID];
		}];


	//------------------ PREPHASE INIT --------------------
		_counter = globalVars getVariable "build_time_defender";
		while {_counter > 0} do {
			[[format ["<t size='2'>%1 Sek</t>",_counter], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText"];
			_counter = _counter - 1;
			sleep 1;
		};
		[["<t size='2'>LOS!</t>", "PLAIN DOWN", -1, true, true]] remoteExec ["titleText"];
		
		
	//------------------ MANAGE EDITING AREAS ---------------
		
		zeus_1 removeCuratorCameraArea zoneIndex;
		zeus_1 setCuratorCameraAreaCeiling 300;
		
		zeus_2 removeCuratorEditingArea (zoneIndex + 200);

	//------------------ ENABLE BLUFOR WP ------------------
		zeus_1 removeEventHandler ["CuratorWaypointPlaced", _eh];

		} else {
			
			zeus_1 removeCuratorEditingArea zoneIndex;
			zeus_2 removeCuratorEditingArea (zoneIndex + 200);

			if(globalVars getVariable "gamemode" == 2) then {
				_newScore = (globalVars getVariable "score_blufor") + 1;
				globalVars setVariable ["score_blufor", _newScore, true];
			};

			deleteVehicle sector;
			"bluforWin" call BIS_fnc_endMissionServer;
			
		};
	};