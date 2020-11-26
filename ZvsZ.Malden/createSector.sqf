//Exit if we are not the server
if !( isServer ) exitWith {};


private ["_pos","_trgSize","_designation","_name","_codeExecute"];
_pos = _this select 0;
_trgSize = _this select 1;
_designation = _this select 2;
_name = _this select 3;
codeExecute = _this select 4;

"ModuleSector_F" createUnit [_pos,createGroup sideLogic,format
["	sector=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
	this setVariable ['name',_name];
	this setVariable ['Designation',_designation];
	this setVariable ['OwnerLimit','1'];
	this setVariable ['OnOwnerChange','[[_this select 1,codeExecute], ''changeZone.sqf''] remoteExec [''BIS_fnc_execVM'', 2];'];
	this setVariable ['CaptureCoef','0.05']; 	
	this setVariable ['CostInfantry','0.2'];
	this setVariable ['CostWheeled','0.2'];
	this setVariable ['CostTracked','0.2'];
	this setVariable ['CostWater','0.2'];
	this setVariable ['CostAir','0.2'];
	this setVariable ['CostPlayers','0.2'];
	this setVariable ['DefaultOwner',0];
	this setVariable ['TaskOwner','3'];
	this setVariable ['TaskTitle',_name];
	this setVariable ['taskDescription',_name];
	this setVariable ['ScoreReward','0'];
	this setVariable ['Sides',[east,west]];
	this setVariable ['objectArea',[_trgSize,_trgSize,0,false ]];
"]];


_markerName = _name + "_radius"; 
_radiusMarker = createMarker [_markerName, _pos];
_markerName setMarkerShape "ELLIPSE";
_markerName setMarkerSize [700, 700];
_markerName setMarkerBrush "Border";

