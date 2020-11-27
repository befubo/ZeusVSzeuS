
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
			_distance = posModule distance (globalVars getVariable "posActiveZone");
			
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
		_center = getMarkerPos ("zone_" + str zoneIndex);
		
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
	
	_posIndex = 0;
	_tooFar = 0;
	{
		_posZone = getMarkerPos ("zone_" + str _posIndex);
		_distance = posModule distance _posZone;
		if(_distance < 700) then {
			_tooFar = 1;
		};
		_posIndex = _posIndex + 1;
	} foreach zones;
	
	if(_tooFar == 1) then {
		hint "Zu nahe an einer Zone!";
	} else {
		switch (moduleObjectType) do
		{
			case "B_Truck_01_box_F":
			{
			rand = random 10000;
			[zeus_1,[rand,posModule,50]] remoteExec ["addCuratorEditingArea", 0, false];
			_driver = driver moduleObject;
			hideObjectGlobal _driver;
			_driver setdamage 1;
			moduleObject setVelocity [0,0,0];
			
			
			deleteVehicle moduleObject;
			_building = "Land_Cargo_HQ_V1_F" createVehicle posModule;
			_building setVariable ["outpost_id", rand, true];
			
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
			
			_trg = createTrigger ["EmptyDetector", [posModule select 0,posModule select 1,0]];
			_trg setTriggerArea [20, 20, 0, false];
			_trg setTriggerActivation ["EAST", "PRESENT", true];
			_trg setTriggerStatements ["{_x iskindof ""O_engineer_F""} count thislist > 0", "_building = ((position thisTrigger) nearestObject ""Land_Cargo_HQ_V1_F""); _outpost_id = _building getVariable ""outpost_id""; zeus_1 removeCuratorEditingArea _outpost_id; _markerName = str _outpost_id + ""_radius""; 	_markerName_1 = str _outpost_id + ""_icon""; deleteMarker _markerName; deleteMarker _markerName_1; _building setDamage 1; _triggerObj = ((position thisTrigger) nearestObject ""EmptyDetector""); deleteVehicle _triggerObj", ""];
			};
			
			case "O_Truck_03_device_F":
			{
			rand = random 10000;
			[zeus_2,[rand,posModule,50]] remoteExec ["addCuratorEditingArea", 0, false];
			_driver = driver moduleObject;
			hideObjectGlobal _driver;
			_driver setdamage 1;
			moduleObject setVelocity [0,0,0];
			
			deleteVehicle moduleObject;
			_building = "Land_Cargo_HQ_V3_F" createVehicle posModule;
			_building setVariable ["outpost_id", rand, true];
			
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
			
			_trg = createTrigger ["EmptyDetector", [posModule select 0,posModule select 1,0]];
			_trg setTriggerArea [20, 20, 0, false];
			_trg setTriggerActivation ["WEST", "PRESENT", true];
			_trg setTriggerStatements ["{_x iskindof ""B_engineer_F""} count thislist > 0", "_building = ((position thisTrigger) nearestObject ""Land_Cargo_HQ_V3_F""); _outpost_id = _building getVariable ""outpost_id""; zeus_2 removeCuratorEditingArea _outpost_id; _markerName = str _outpost_id + ""_radius""; 	_markerName_1 = str _outpost_id + ""_icon""; deleteMarker _markerName; deleteMarker _markerName_1; _building setDamage 1; _triggerObj = ((position thisTrigger) nearestObject ""EmptyDetector""); deleteVehicle _triggerObj", ""];
			};
			
		default { hint "Kein oder falsches Fahrzeug ausgewählt!"; };
		};
	};
}] call zen_custom_modules_fnc_register;

["Konstruktionen", "Ressourcenpunkt bauen", {
	posModule = _this select 0;
	moduleObject = _this select 1;
	moduleObjectType = typeOf moduleObject;
	
	_distance = posModule distance (globalVars getVariable "posActiveZone");
	
	if(_distance > 700) then {
		hint "Zu weit weg vom nächsten Punkt!";
	} else {
		switch (moduleObjectType) do
		{
			case "B_Truck_01_box_F":
			{
			rand = random 10000;
			_driver = driver moduleObject;
			hideObjectGlobal _driver;
			_driver setdamage 1;
			moduleObject setVelocity [0,0,0];
			
			deleteVehicle moduleObject;
			_building = "Land_Cargo_House_V1_F" createVehicle posModule;
			_building setVariable ["support_id", rand, true];
			_newRes = (globalVars getVariable "blufor_res_factor") + 1;
			globalVars setVariable ["blufor_res_factor", _newRes, true];
			
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
			
			_trg = createTrigger ["EmptyDetector", [posModule select 0,posModule select 1,0]];
			_trg setTriggerArea [20, 20, 0, false];
			_trg setTriggerActivation ["EAST", "PRESENT", true];
			_trg setTriggerStatements ["{_x iskindof ""O_engineer_F""} count thislist > 0", "_building = ((position thisTrigger) nearestObject ""Land_Cargo_House_V1_F""); _support_id = _building getVariable ""support_id""; _markerName = str _support_id + ""_radius""; 	_markerName_1 = str _support_id + ""_icon""; deleteMarker _markerName; deleteMarker _markerName_1; _building setDamage 1; _newRes = (globalVars getVariable ""blufor_res_factor"") - 1; globalVars setVariable [""blufor_res_factor"", _newRes, true]; _triggerObj = ((position thisTrigger) nearestObject ""EmptyDetector""); deleteVehicle _triggerObj", ""];
			};
			
			case "O_Truck_03_device_F":
			{
			rand = random 10000;
			_driver = driver moduleObject;
			hideObjectGlobal _driver;
			_driver setdamage 1;
			moduleObject setVelocity [0,0,0];
			
			deleteVehicle moduleObject;
			_building = "Land_Cargo_House_V3_F" createVehicle posModule;
			_building setVariable ["support_id", rand, true];
			_newRes = (globalVars getVariable "redfor_res_factor") + 1;
			globalVars setVariable ["redfor_res_factor", _newRes, true];
			
			_markerName = str rand + "_radius"; 
			createMarker [_markerName, posModule];
			_markerName setMarkerShape "ELLIPSE";
			_markerName setMarkerSize [100, 100];
			_markerName setMarkerBrush "SolidBorder";
			_markerName setMarkerColor "colorOPFOR";
			
			_markerName_1 = str rand + "_icon"; 
			createMarker [_markerName_1, posModule];
			_markerName_1 setMarkerType "b_support";
			_markerName_1 setMarkerColor "colorOPFOR";			
			
			_trg = createTrigger ["EmptyDetector", [posModule select 0,posModule select 1,0]];
			_trg setTriggerArea [20, 20, 0, false];
			_trg setTriggerActivation ["WEST", "PRESENT", true];
			_trg setTriggerStatements ["{_x iskindof ""B_engineer_F""} count thislist > 0", "_building = ((position thisTrigger) nearestObject ""Land_Cargo_House_V3_F""); _support_id = _building getVariable ""support_id""; _markerName = str _support_id + ""_radius""; 	_markerName_1 = str _support_id + ""_icon""; deleteMarker _markerName; deleteMarker _markerName_1; _building setDamage 1; _newRes = (globalVars getVariable ""redfor_res_factor"") - 1; globalVars setVariable [""redfor_res_factor"", _newRes, true]; _triggerObj = ((position thisTrigger) nearestObject ""EmptyDetector""); deleteVehicle _triggerObj", ""];
			};
			
		default { hint "Kein oder falsches Fahrzeug ausgewählt!"; };
		};
	};
}] call zen_custom_modules_fnc_register;