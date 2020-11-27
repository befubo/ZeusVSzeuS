_posModule = _this select 0;
_moduleObject = _this select 1;

_ied = "IEDUrbanSmall_Remote_Ammo" createVehicle [_posModule select 0,_posModule select 1,0];
globalVars setVariable ["ied_count", (globalVars getVariable "ied_count") + 1, true];

_side = blufor;
if(playerSide == blufor) then {
	_side = "EAST";
} else {
	_side = "WEST";
};

_trg = createTrigger ["EmptyDetector", [_posModule select 0,_posModule select 1,0]];
_trg setTriggerArea [10, 10, 0, false];
_trg setTriggerActivation [_side, "PRESENT", false];
_trg setTriggerStatements ["this", "((position thisTrigger) nearestObject ""IEDUrbanSmall_Remote_Ammo"") setDamage 1; globalVars setVariable [""ied_count"", (globalVars getVariable ""ied_count"") - 1, true];", ""];
