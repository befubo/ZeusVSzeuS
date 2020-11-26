_side = blufor;

// MODULE FÜR BLUFOR
if(playerSide == blufor) then {
	["Spezial", "Recon-Drohne", {
		_points = curatorPoints zeus_1;
		if(_points >= 0.1) then {
		
		posModule = _this select 0;
		moduleObject = _this select 1;
		zeus_1 addCuratorPoints -0.1;
		[posModule,moduleObject]execVM "recon.sqf";
		} else {
			hint "Zu wenig Punkte!";
		}
	}] call zen_custom_modules_fnc_register;
	
	
	["Spezial", "Fallschirmjaeger", {
		_points = curatorPoints zeus_1;
		if(_points >= 0.3) then {
			posModule = _this select 0;
			moduleObject = _this select 1;
			_distance = posModule distance (position (globalVars getVariable "active_zone"));
	
			if(_distance > 700) then {
				zeus_1 addCuratorPoints -0.3;
				[posModule,moduleObject]execVM "parachute.sqf";
			} else {
				hint "Zu nah an aktiver Zone!";
			};
		} else {
			hint "Zu wenig Punkte!";
		}
	}] call zen_custom_modules_fnc_register;
};


// MODULE FÜR OPFOR
if(playerSide == opfor) then {
	["Spezial", "IED", {
		_points = curatorPoints zeus_2;
		if(_points >= 0.3) then {
			_toClose = 0;
			posModule = _this select 0;
			moduleObject = _this select 1;
			_nearUnits = posModule nearEntities 500;
			
			{
				if(side _x == blufor) then {
					_toClose = 1;
				};
			} foreach _nearUnits;
			
			if(_toClose == 1) then {
				hint "Feind ist zu nah!";
			} else {
				if(globalVars getVariable "ied_count" > 2) then {
					hint "Maximale Anzahl IEDs (3) gelegt!";
				} else {
					zeus_2 addCuratorPoints -0.3;
					[posModule,moduleObject]execVM "ied.sqf";
				};
			};
		} else {
			hint "Zu wenig Punkte!";
		}
	}] call zen_custom_modules_fnc_register;
	
	["Spezial", "Einheit zurueckziehen", {
		posModule = _this select 0;
		moduleObject = _this select 1;

		_grp = group moduleObject;
		_center = getPos (globalVars getVariable "active_zone");
		
		for "_i" from count waypoints _grp - 1 to 0 step -1 do
			{
				deleteWaypoint [_grp, _i];
			};
		
		_wpRe = _grp addWaypoint [_center, -1];
		_wpRe setWaypointType "MOVE";
		_wpRe setWaypointSpeed "FULL";
		_wpRe setWaypointBehaviour "CARELESS";
		_wpRe setWaypointStatements ["true", "_wpRe setWaypointBehaviour ""AWARE"";"];
	}] call zen_custom_modules_fnc_register;
};


// MODULE FÜR BEIDE SEITEN
["Konstruktionen", "Aussenposten bauen", {
	posModule = _this select 0;
	moduleObject = _this select 1;
	moduleObjectType = typeOf moduleObject;
	_distance_molos = posModule distance (position zoneMolos);
	_distance_sofia = posModule distance (position zoneSofia);
	_distance_military = posModule distance (position zoneMilitary);
	_distance_hotel = posModule distance (position zoneHotel);
	_distance_startBlufor = posModule distance (position camArea_1);
	
	if(_distance_molos < 700 or _distance_sofia < 700 or _distance_military < 700 or _distance_hotel < 700 or _distance_startBlufor < 700) then {
		hint "Zu nahe an einer Zone!";
	} else {
		switch (moduleObjectType) do
		{
			case "B_Truck_01_box_F":
			{
			rand = random 10000;
			[zeus_1,[rand,posModule,50]] remoteExec ["addCuratorEditingArea", 0, false];
			moduleObject setVariable ["outpost_id", rand, true];
			driver moduleObject disableAI "AUTOTARGET";
			driver moduleObject disableAI "MOVE";
			moduleObject setVelocity [0,0,0];
			
			[zeus_1,[[moduleObject],true]] remoteExec ["removeCuratorEditableObjects", 2, false];
			(driver moduleObject) allowDamage false;
			_posBuilding = moduleObject modelToWorld [15,0,0];
			"Land_Cargo_HQ_V1_F" createVehicle _posBuilding;
			moduleObject setFuel 0;
			
			_markerName = str rand + "_radius"; 
			createMarker [_markerName, posModule];
			_markerName setMarkerShape "ELLIPSE";
			_markerName setMarkerSize [100, 100];
			_markerName setMarkerBrush "SolidBorder";
			_markerName setMarkerColor "colorBLUFOR";
			
			_markerName_1 = str rand + "_icon"; 
			createMarker [_markerName_1, posModule];
			_markerName_1 setMarkerType "b_hq";
			_markerName_1 setMarkerColor "colorBLUFOR";			
			
			moduleObject addMPEventHandler ["MPKilled", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				_outpost_id = _unit getVariable "outpost_id";
				zeus_1 removeCuratorEditingArea _outpost_id;
				_markerName = str _outpost_id + "_radius";
				_markerName_1 = str _outpost_id + "_icon";
				(driver moduleObject) allowDamage true;
				(driver moduleObject) setDamage 1;
				deleteMarker _markerName;
				deleteMarker _markerName_1;
			}];
			};
			
			case "O_Truck_03_device_F":
			{
			rand = random 10000;
			[zeus_2,[rand,posModule,50]] remoteExec ["addCuratorEditingArea", 0, false];
			moduleObject setVariable ["outpost_id", rand, true];
			driver moduleObject disableAI "AUTOTARGET";
			driver moduleObject disableAI "MOVE";
			moduleObject setVelocity [0,0,0];
			
			[zeus_2,[[moduleObject],true]] remoteExec ["removeCuratorEditableObjects", 2, false];
			(driver moduleObject) allowDamage false;
			_posBuilding = moduleObject modelToWorld [15,0,0];
			"Land_Cargo_HQ_V3_F" createVehicle _posBuilding;
			moduleObject setFuel 0;
			
			_markerName = str rand + "_radius"; 
			createMarker [_markerName, posModule];
			_markerName setMarkerShape "ELLIPSE";
			_markerName setMarkerSize [100, 100];
			_markerName setMarkerBrush "SolidBorder";
			_markerName setMarkerColor "colorOPFOR";
			
			_markerName_1 = str rand + "_icon"; 
			createMarker [_markerName_1, posModule];
			_markerName_1 setMarkerType "o_hq";
			_markerName_1 setMarkerColor "colorOPFOR";	
			
			moduleObject addMPEventHandler ["MPKilled", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				_outpost_id = _unit getVariable "outpost_id";
				zeus_2 removeCuratorEditingArea _outpost_id;
				_markerName = str _outpost_id + "_radius";
				_markerName_1 = str _outpost_id + "_icon";
				(driver moduleObject) allowDamage true;
				(driver moduleObject) setDamage 1;
				deleteMarker _markerName;
				deleteMarker _markerName_1;
			}];
			};
			
		default { hint "Kein oder falsches Fahrzeug ausgewählt!"; };
		};
	};
}] call zen_custom_modules_fnc_register;

["Konstruktionen", "Ressourcenpunkt bauen", {
	posModule = _this select 0;
	moduleObject = _this select 1;
	moduleObjectType = typeOf moduleObject;
	_distance = posModule distance (position (globalVars getVariable "active_zone"));
	
	if(_distance > 700) then {
		hint "Zu weit weg vom nächsten Punkt!";
	} else {
		switch (moduleObjectType) do
		{
			case "B_Truck_01_box_F":
			{
			rand = random 10000;
			moduleObject setVariable ["support_id", rand, true];
			driver moduleObject disableAI "AUTOTARGET";
			driver moduleObject disableAI "MOVE";
			moduleObject setVelocity [0,0,0];
			
			[zeus_1,[[moduleObject],true]] remoteExec ["removeCuratorEditableObjects", 2, false];
			(driver moduleObject) enableSimulation false;
			(driver moduleObject) allowDamage false;
			_newRes = (globalVars getVariable "blufor_res_factor") + 1;
			globalVars setVariable ["blufor_res_factor", _newRes, true];
			_posBuilding = moduleObject modelToWorld [10,0,0];
			"Land_Cargo_House_V1_F" createVehicle _posBuilding;
			moduleObject setFuel 0;
			
			_markerName = str rand + "_radius"; 
			createMarker [_markerName, posModule];
			_markerName setMarkerShape "ELLIPSE";
			_markerName setMarkerSize [100, 100];
			_markerName setMarkerBrush "SolidBorder";
			_markerName setMarkerColor "colorBLUFOR";
			
			_markerName_1 = str rand + "_icon"; 
			createMarker [_markerName_1, posModule];
			_markerName_1 setMarkerType "b_support";
			_markerName_1 setMarkerColor "colorBLUFOR";	
			
			moduleObject addMPEventHandler ["MPKilled", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				_newRes = (globalVars getVariable "blufor_res_factor") - 1;
				globalVars setVariable ["blufor_res_factor", _newRes, true];
				_support_id = _unit getVariable "support_id";
				_markerName = str _support_id + "_radius";
				_markerName_1 = str _support_id + "_icon";
				(driver moduleObject) allowDamage true;
				(driver moduleObject) setDamage 1;
				deleteMarker _markerName;
				deleteMarker _markerName_1;
			}];
			};
			
			case "O_Truck_03_device_F":
			{
			rand = random 10000;
			moduleObject setVariable ["support_id", rand, true];
			driver moduleObject disableAI "AUTOTARGET";
			driver moduleObject disableAI "MOVE";
			moduleObject setVelocity [0,0,0];
			
			[zeus_2,[[moduleObject],true]] remoteExec ["removeCuratorEditableObjects", 2, false];
			(driver moduleObject) enableSimulation false;
			(driver moduleObject) allowDamage false;
			_newRes = (globalVars getVariable "redfor_res_factor") + 1;
			globalVars setVariable ["redfor_res_factor", _newRes, true];
			_posBuilding = moduleObject modelToWorld [10,0,0];
			"Land_Cargo_House_V3_F" createVehicle _posBuilding;
			moduleObject setFuel 0;
			
			_markerName = str rand + "_radius"; 
			createMarker [_markerName, posModule];
			_markerName setMarkerShape "ELLIPSE";
			_markerName setMarkerSize [100, 100];
			_markerName setMarkerBrush "SolidBorder";
			_markerName setMarkerColor "colorOPFOR";
			
			_markerName_1 = str rand + "_icon"; 
			createMarker [_markerName_1, posModule];
			_markerName_1 setMarkerType "o_support";
			_markerName_1 setMarkerColor "colorOPFOR";	
			
			moduleObject addMPEventHandler ["MPKilled", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				_newRes = (globalVars getVariable "redfor_res_factor") - 1;
				globalVars setVariable ["redfor_res_factor", _newRes, true];
				_support_id = _unit getVariable "support_id";
				_markerName = str _support_id + "_radius";
				_markerName_1 = str _support_id + "_icon";
				(driver moduleObject) allowDamage true;
				(driver moduleObject) setDamage 1;
				deleteMarker _markerName;
				deleteMarker _markerName_1;
			}];
			};
			
		default { hint "Kein oder falsches Fahrzeug ausgewählt!"; };
		};
	};
}] call zen_custom_modules_fnc_register;





