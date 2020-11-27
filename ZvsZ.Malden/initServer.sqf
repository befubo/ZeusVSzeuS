[[], 'zoneInit.sqf'] remoteExec ['BIS_fnc_execVM', 2];

// ------------------ GAMEMODE CALC ----------------

if(globalVars getVariable "gamemode" == 1) then {
	[globalVars getVariable "advance_time_attacker"] call BIS_fnc_countDown;
	sleep 1;
	[[], 'opforWinTime.sqf'] remoteExec ['BIS_fnc_execVM', 2];
	[[], 'showScore.sqf'] remoteExec ['BIS_fnc_execVM', 2];
};

if(globalVars getVariable "gamemode" == 2) then {
	[[], 'opforWinScore.sqf'] remoteExec ['BIS_fnc_execVM', 2];
	[[], 'showScore.sqf'] remoteExec ['BIS_fnc_execVM', 2];
};

addMissionEventHandler ["EntityKilled", {
	params ["_killed", "_killer", "_instigator"];
	
	_killed removeAllEventHandlers "fired";
	
	if (side group _killed isEqualTo EAST) then {
		if(_killed isKindOf "Man") then {
			p1 addPlayerScores [1, 0, 0, 0, 0];
		};
		if(_killed isKindOf "StaticWeapon") then {
			p1 addPlayerScores [1, 0, 0, 0, 0];
		};
		if(_killed isKindOf "Car") then {
			p1 addPlayerScores [0, 1, 0, 0, 0];
		};
		if(_killed isKindOf "Air") then {
			p1 addPlayerScores [0, 0, 0, 1, 0];
		};
		if(_killed isKindOf "Tank") then {
			p1 addPlayerScores [0, 0, 1, 0, 0];
		};
	};
	if (side group _killed isEqualTo WEST) then {
		if(_killed isKindOf "Man") then {
			_newScore = (globalVars getVariable "score_opfor") + 1;
			globalVars setVariable ["score_opfor", _newScore, true];
			p2 addPlayerScores [1, 0, 0, 0, 0];
		};
		if(_killed isKindOf "StaticWeapon") then {
			_newScore = (globalVars getVariable "score_opfor") + 1;
			globalVars setVariable ["score_opfor", _newScore, true];
			p2 addPlayerScores [1, 0, 0, 0, 0];
		};
		if(_killed isKindOf "Car") then {
			_newScore = (globalVars getVariable "score_opfor") + 5;
			globalVars setVariable ["score_opfor", _newScore, true];
			p2 addPlayerScores [0, 1, 0, 0, 0];
		};
		if(_killed isKindOf "Air") then {
			_newScore = (globalVars getVariable "score_opfor") + 5;
			globalVars setVariable ["score_opfor", _newScore, true];
			p2 addPlayerScores [0, 0, 0, 1, 0];
		};
		if(_killed isKindOf "Tank") then {
			_newScore = (globalVars getVariable "score_opfor") + 10;
			globalVars setVariable ["score_opfor", _newScore, true];
			p2 addPlayerScores [0, 0, 1, 0, 0];
		};
	};
}];