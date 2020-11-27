_posModule = _this select 0;
_moduleObject = _this select 1;

_group = creategroup [west, true];


_unit_1 = _group createUnit ["B_recon_TL_F", _posModule, [], 30, "CAN_COLLIDE"];
_unit_2 = _group createUnit ["B_Recon_Sharpshooter_F", _posModule, [], 30, "CAN_COLLIDE"];
_unit_3 = _group createUnit ["B_recon_medic_F", _posModule, [], 30, "CAN_COLLIDE"];
_unit_4 = _group createUnit ["B_recon_LAT_F", _posModule, [], 30, "CAN_COLLIDE"];
[zeus_1,[units _group,false]] remoteExec ["addCuratorEditableObjects", 2, false];


{
	_x allowDamage false;
	_x setPos [getPos _x select 0,getPos _x select 1,300];
} forEach units _group;

sleep 0.2;

{
	_chute = createVehicle ["NonSteerable_Parachute_F", (getPosatl _x), [], 0, "NONE"];
	_chute setPosATL (getPosatl _x);
	_x moveinDriver _chute;
} forEach units _group;

sleep 0.2;

{
	_x allowDamage true;
} forEach units _group;



_wpPara = _group addWaypoint [_posModule, -1];
_wpPara setWaypointType "MOVE";
_wpPara setWaypointSpeed "FULL";