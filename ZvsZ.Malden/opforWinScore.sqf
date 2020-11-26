waitUntil { globalVars getVariable "score_opfor" > (globalVars getVariable "score_needed") - 1 };
"opforWin" call BIS_fnc_endMissionServer;