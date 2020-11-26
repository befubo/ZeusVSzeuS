params ["_zoneIndex","_trgSize","_designation","_name","_codeExecute"];

_temp = [zones, (_zoneIndex)] call BIS_fnc_findNestedElement;
_newZone = (zones select (_temp select 0)) select 0;
_temp = [zones, (_zoneIndex)] call BIS_fnc_findNestedElement;
_oldZone = (zones select (_temp select 0)) select 0;

_temp = [spawns, (_zoneIndex)] call BIS_fnc_findNestedElement;
_newOpforSpawn = (zones select (_temp select 0)) select 0;

posNewZone = getMarkerPos "_newZone";
posOldZone = getMarkerPos "_oldZone";
posNewSpawn = getMarkerPos "_newOpforSpawn";

zoneIndex = zoneIndex + 1;

	
//------------------ MANAGE RESSOURCES ------------------
	zeus_1 addCuratorPoints 0.5;
	zeus_2 addCuratorPoints 0.5;
	zeus_1 setCuratorCoef ["place",-0.75];
	zeus_2 setCuratorCoef ["place",-0.75];
	
	
//------------------ MANAGE EDITING AREAS ---------------
	zeus_1 addCuratorEditingArea [zoneIndex,posOldZone,150];
	zeus_2 removeCuratorEditingArea (zoneIndex - 1);
	zeus_2 addCuratorEditingArea [zoneIndex,posNewSpawn,50];
	zeus_2 addCuratorEditingArea [(zoneIndex + 100),posNewZone,150];
	
	zeus_1 addCuratorCameraArea [zoneIndex,posOldZone,150];
	zeus_1 setCuratorCameraAreaCeiling 25;


//------------------ MANAGE SECTOR ----------------------
	deleteVehicle sector;
	[[posNewZone,150,zoneLetters select (zoneIndex - 1),zoneNames select (zoneIndex - 1),"[zoneIndex] execVM ""changeZone.sqf"";"], 'createSector.sqf'] remoteExec ['BIS_fnc_execVM', 0];


//------------------ MANAGE SCORE ----------------------
	if(globalVars getVariable "gamemode" == 1) then {
		[globalVars getVariable "advance_time_attacker"] call BIS_fnc_countDown;
	};
	if(globalVars getVariable "gamemode" == 2) then {
		_newScore = (globalVars getVariable "score_blufor") + 1;
		globalVars setVariable ["score_blufor", _newScore, true];
	};
	
	
//------------------ MANAGE WP HANDLERS ----------------
	zeus_2 removeEventHandler ["CuratorWaypointPlaced", eh_start];
	
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
	
	zeus_2 removeCuratorEditingArea (zoneIndex + 100);
	zeus_1 removeCuratorCameraArea zoneIndex;
	zeus_1 setCuratorCameraAreaCeiling 300;

//------------------ ENABLE BLUFOR WP ------------------
	zeus_1 removeEventHandler ["CuratorWaypointPlaced", _eh];






