globalVars setVariable ["gamemode", paramsArray select 0, true];
globalVars setVariable ["advance_time_attacker", paramsArray select 1, true];
globalVars setVariable ["score_needed", paramsArray select 2, true];
globalVars setVariable ["build_time_defender", paramsArray select 3, true];

globalVars setVariable ["blufor_res_factor", 0, true];
globalVars setVariable ["redfor_res_factor", 0, true];
globalVars setVariable ["score_blufor", 0, true];
globalVars setVariable ["score_opfor", 0, true];

globalVars setVariable ["ied_count", 0, true];

addMissionEventHandler ["EachFrame", {
	{
		_x setSkill 1;
		_x allowFleeing 0;
		group _x setSpeedMode "FULL";
	} foreach allUnits;
}];


//------------------ PLACEABLE UNITS BLUFOR ------------------
bluforUnits = [
"B_engineer_F",0.07,
"B_soldier_AR_F",0.07,
"B_soldier_AAR_F",0.06,
"B_HeavyGunner_F",0.07,
"B_soldier_M_F",0.06,
"B_Soldier_F",0.04,
"B_soldier_LAT_F",0.07,
"B_sniper_F",0.09,
"B_spotter_F",0.09,
"B_Soldier_GL_F",0.07,
"B_Sharpshooter_F",0.09,
"B_medic_F",0.06,
"B_Soldier_SL_F",0.06,
"B_Soldier_TL_F",0.06,
"B_crew_F",0.06,
"B_LSV_01_unarmed_F",0.1,
"B_MRAP_01_F",0.15,
"B_Truck_01_covered_F",0.1,
"B_Truck_01_box_F",0.5,
"B_LSV_01_AT_F",0.9,
"B_LSV_01_armed_F",0.8,
"B_MRAP_01_gmg_F",0.9,
"B_MRAP_01_hmg_F",0.9,
"MU_NATO_Gorgon",1,
"B_APC_Wheeled_01_cannon_F",1,
"B_AFV_Wheeled_01_up_cannon_F",1.2,
"B_Heli_Light_01_F",1,
"B_Mortar_01_F",0.6,
"zen_modules_moduleGarrison",0,
"zen_modules_moduleUnGarrison",0,
"zen_modules_moduleSearchBuilding",0,
"zen_modules_moduleFlyHeight",0,
"zen_modules_moduleCASGun",0.9,
"zen_modules_moduleCASMissile",1,
"zen_modules_moduleCASBomb",1.1,
"zen_modules_moduleFireMission",0.1,
"zen_remote_control",0.2
];


//------------------ PLACEABLE UNITS BLUFOR ------------------
opforUnits = [
"O_engineer_F",0.07,
"O_Soldier_SL_F",0.06,
"O_Soldier_F",0.04,
"O_Soldier_LAT_F",0.07,
"O_soldier_M_F",0.06,
"O_Soldier_TL_F",0.06,
"O_Soldier_AR_F",0.07,
"O_Soldier_A_F",0.06,
"O_medic_F",0.06,
"O_Soldier_GL_F",0.07,
"O_sniper_F",0.09,
"O_spotter_F",0.09,
"O_LSV_02_unarmed_F",0.1,
"O_MRAP_02_F",0.75,
"O_Truck_02_covered_F",0.1,
"O_Truck_03_device_F",0.5,
"O_LSV_02_AT_F",0.9,
"O_LSV_02_armed_F",0.8,
"O_MRAP_02_gmg_F",0.9,
"O_MRAP_02_hmg_F",0.9,
"O_APC_Wheeled_02_rcws_v2_F",1,
"O_APC_Tracked_02_cannon_F",1,
"O_HMG_01_high_F",0.7,
"O_Mortar_01_F",0.6,
"Land_BagFence_Long_F",0.05,
"Land_BagFence_Corner_F",0.05,
"Land_BagFence_End_F",0.05,
"Land_BagFence_Short_F",0.05,
"Land_Razorwire_F",0.1,
"Land_CzechHedgehog_01_new_F",0.1,
"zen_modules_moduleGarrison",0,
"zen_modules_moduleUnGarrison",0,
"zen_modules_moduleSearchBuilding",0,
"zen_modules_moduleFlyHeight",0,
"zen_modules_moduleCASGun",0.9,
"zen_modules_moduleCASMissile",1,
"zen_modules_moduleCASBomb",1.1,
"zen_modules_moduleFireMission",0.1,
"zen_remote_control",0.2
];

//------------------ HELI UNITS INCLUDED ------------------
_heli = paramsArray select 5;
if(_heli == 1) then {
	bluforUnits pushBack "B_Heli_Light_01_F";
	bluforUnits pushBack 0.6;
	bluforUnits pushBack "B_Heli_Light_01_dynamicLoadout_F";
	bluforUnits pushBack 0.9;
	bluforUnits pushBack "B_Helipilot_F";
	bluforUnits pushBack 0.03;
	bluforUnits pushBack "B_soldier_AAA_F";
	bluforUnits pushBack 0.07;
	
	opforUnits pushBack "O_Heli_Light_02_unarmed_F";
	opforUnits pushBack 0.6;
	opforUnits pushBack "O_Heli_Light_02_dynamicLoadout_F";
	opforUnits pushBack 0.9;
	opforUnits pushBack "O_helipilot_F";
	opforUnits pushBack 0.03;
	opforUnits pushBack "O_Soldier_AAA_F";
	opforUnits pushBack 0.07;
};

//------------------ TANK UNITS INCLUDED ------------------
_tank = paramsArray select 6;
if(_tank == 1) then {
	bluforUnits pushBack "B_MBT_01_TUSK_F";
	bluforUnits pushBack 1.2;
	bluforUnits pushBack "B_crew_F";
	bluforUnits pushBack 0.03;
	
	opforUnits pushBack "O_MBT_02_cannon_F";
	opforUnits pushBack 1.2;
	opforUnits pushBack "O_crew_F";
	opforUnits pushBack 0.03;
};

//------------------ ARTILLERY UNITS INCLUDED ------------------
_arty = paramsArray select 7;
if(_arty == 1) then {
	bluforUnits pushBack "B_MBT_01_arty_F";
	bluforUnits pushBack 1.2;
	bluforUnits pushBack "B_crew_F";
	bluforUnits pushBack 0.03;
	
	opforUnits pushBack "O_MBT_02_arty_F";
	opforUnits pushBack 1.2;
	opforUnits pushBack "O_crew_F";
	opforUnits pushBack 0.03;
};

//------------------ DEBUG MODE ------------------
_debug = paramsArray select 8;
if(_debug == 1) then {
	bluforUnits pushBack "O_Soldier_F";
	bluforUnits pushBack 0.01;
	bluforUnits pushBack "O_MRAP_02_F";
	bluforUnits pushBack 0.01;
	bluforUnits pushBack "O_Soldier_LAT_F";
	bluforUnits pushBack 0.01;
	bluforUnits pushBack "O_engineer_F";
	bluforUnits pushBack 0.01;
	
	opforUnits pushBack "B_Soldier_F";
	opforUnits pushBack 0.01;
	opforUnits pushBack "B_MRAP_01_F";
	opforUnits pushBack 0.01;
	opforUnits pushBack "B_soldier_LAT_F";
	opforUnits pushBack 0.01;
	opforUnits pushBack "B_engineer_F";
	opforUnits pushBack 0.01;
};

[zeus_1, bluforUnits] call BIS_fnc_curatorObjectRegisteredTable;
[zeus_2, opforUnits] call BIS_fnc_curatorObjectRegisteredTable;