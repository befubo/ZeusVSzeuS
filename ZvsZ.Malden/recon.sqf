_posModule = _this select 0;
_moduleObject = _this select 1;

_rand = random 10000;

_markerName = str _rand + "_reconArea"; 
createMarkerLocal [_markerName, _posModule];
_markerName setMarkerShape "ELLIPSE";
_markerName setMarkerSize [400, 400];
_markerName setMarkerBrush "SolidBorder";
_markerName setMarkerColor "colorIndependent";
_markerName setMarkerAlpha 0.5;

_markerName2 = str _rand + "_reconPoint"; 
createMarkerLocal [_markerName2, _posModule];
_markerName2 setMarkerType "mil_dot";
_markerName2 setMarkerColor "colorIndependent";

_side = blufor;
if(playerSide == blufor) then {
	_side = opfor;
} else {
	_side = blufor;
};

_reconDuration = 45;
while {_reconDuration > 0} do {
	_list = ASLToAGL _posModule nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 400];

	{
		if((side _x) == _side ) then {
			_posEnemy = getPos _x;
			_markerName1 = str _x + "_recon"; 
			createMarkerLocal [_markerName1, _posEnemy];
			_markerName1 setMarkerType "mil_dot";
		};
	} forEach _list;
	
	sleep 1;
	
	{
		if((side _x) == _side ) then {
			_posEnemy = getPos _x;
			_markerName1 = str _x + "_recon";
			_markerName1 setMarkerPos _posEnemy;
		};
	} forEach _list;
	
	_markerName2 setMarkerText str _reconDuration;
	_reconDuration = _reconDuration - 1;
};

deleteMarker _markerName;
deleteMarker _markerName2;

_list = ASLToAGL _posModule nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 400];

{
	if((side _x) == _side ) then {
		_markerName1 = str _x + "_recon";
		deleteMarker _markerName1;
	};
} forEach _list;



