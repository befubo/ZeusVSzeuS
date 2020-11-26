_zonesCount = (count zones) - 1;
while {true} do {
// ------------------ GAMEMODE TIME -------------------
	if(globalVars getVariable "gamemode" == 1) then {
		_scoreText = format["<t size='0.5' color='#000FFF'>Ziele Blufor: %1/%3</t>", globalVars getVariable "score_opfor",_zonesCount];
		[_scoreText,0,-0.28,1,0,0,789] remoteExec ["BIS_fnc_dynamicText", 0, true];
	};
// ------------------ GAMEMODE POINTS -----------------
	if(globalVars getVariable "gamemode" == 2) then {
		_scoreText = format["<t size='0.5' color='#000FFF'>Ziele Blufor: %1/%3</t><br/><t size='0.5' color='#FF0000'>Punkte Opfor: %2</t>", globalVars getVariable "score_blufor",globalVars getVariable "score_opfor",_zonesCount];
		[_scoreText,0,-0.28,1,0,0,789] remoteExec ["BIS_fnc_dynamicText", 0, true];
	};
	sleep 1;
};