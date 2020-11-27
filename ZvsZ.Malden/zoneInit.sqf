if (!isServer) exitWith {};

_markers = allMapMarkers;
zones = [];
spawns = [];
zoneLetters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P"];
zoneNames = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliett","Kilo","Lima","Mike","November","Oscar","Papa"];

{
	if(["zone", str _x] call BIS_fnc_inString) then {
		zones pushBack str _x;
	};
	if(["spawn", str _x] call BIS_fnc_inString) then {
		spawns pushBack str _x;
	};
} foreach _markers;

sleep 1;

zeus_1 addCuratorPoints 1;
zeus_2 addCuratorPoints 1;

_zonesCount = (count zones) - 1;
globalVars setVariable ["zonesCount", _zonesCount, true];

[[WEST,1], 'changeZone.sqf'] remoteExec ['BIS_fnc_execVM', 2];


//_blufor_start_pos = getMarkerPos blufor_start;
//_opfor_start_pos = getMarkerPos opfor_start;

//zeus_1 addCuratorEditingArea [90,_blufor_start_pos,150];
