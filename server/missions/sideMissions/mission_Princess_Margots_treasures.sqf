// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2020 A3Wasteland.com *
// ******************************************************************************************
/********************************************************************************************
														   ....              
													 .##############.        
									 ####.         #########@@#########      
									%####         #######=        =######    
									####@       ######*             .#####.  
					 ####           ####       #######                #####. 
					 ####          .####      #####                    ##### 
					 ####%         -####     .####                     .#####
					 .####         .####     =####          ####        #####
					  ####         .####     .####           #.  ###    #####
					  #####         ####      #####                 .  #####%
					   ###################     #####                  ###### 
						-###############%  %#-  ######*            =######@  
									:###%    .#   #######################    
									 ####.  #-      :################%       
										   ####.         -%###%.             
																			 
***********************************************************************************************/
//	@file Name: mission_Princess_Margots_treasures.sqf
//	Initial version of code -> A3Wasteland.com
//	@file author inspiration: this is done thanks to the love of my only princess Margot, love charges me with energy, giving this opportunity ...
//	@file Author: [IT42O] MjDoc


if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_nbUnits", "_setupObjects", "_marker42O", "_createMarkerLocal", "_aiGroup", "_outpost", "_outpost2", "_objects", "_objects2", "_marker1", "_marker2", "_marker3", "_marker4", "_marker5", "_marker6", "_marker7", "_marker8", "_marker9"];

_setupVars =
{
	_missionType = "Princess Margot's Treasures";
	_locationsArray = MSpMark;
	_nbUnits = AI_GROUP_LARGE;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_outpost = (call compile preprocessFileLineNumbers "server\missions\outposts\PrinMargoTreasCords.sqf") call BIS_fnc_selectRandom;
	_objects = [_outpost, _missionPos, 0] call createPrincessMargotsTreasures;
	_outpost2 = (call compile preprocessFileLineNumbers "server\missions\outposts\PrinMargoTreasCords2.sqf") call BIS_fnc_selectRandom;
	_objects2 = [_outpost2, _missionPos, 0] call createPrincessMargotsTreasures2;
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits, 70] call createprincessMargotsSoldiers;
//////////////////
	
		
	_vehicleClass = if (missionDifficultyHard) then
	{
		selectRandom ["O_Heli_Attack_02_black_F", "O_Heli_Attack_02_black_F"];
	}
	else
	{
		selectRandom [["B_Heli_Light_01_dynamicLoadout_F", "pawneeNormal"], ["O_Heli_Light_02_dynamicLoadout_F", "orcaDAGR"], "I_Heli_light_03_dynamicLoadout_F"];
	};

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_variant", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
		_variant = _type param [1,"",[""]];

		if (_type isEqualType []) then
		{
			_type = _type select 0;
		};

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];

		if (_variant != "") then
		{
			_vehicle setVariable ["A3W_vehicleVariant", _variant, true];
		};

		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		// add a driver/pilot/captain to the vehicle
		// the little bird, orca, and hellcat do not require gunners and should not have any passengers
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;

		switch (true) do
		{
			case (_type isKindOf "Heli_Transport_01_base_F"):
			{
				// these choppers have 2 turrets so we need 2 gunners
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [1]];

				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [2]];
			};

			case (_type isKindOf "Heli_Attack_01_base_F" || _type isKindOf "Heli_Attack_02_base_F"):
			{
				// these choppers need 1 gunner
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInGunner _vehicle;
			};
		};

		// remove flares because it overpowers AI choppers
		if (_type isKindOf "Air") then
		{
			{
				if (["CMFlare", _x] call fn_findString != -1) then
				{
					_vehicle removeMagazinesTurret [_x, [-1]];
				};
			} forEach getArray (configFile >> "CfgVehicles" >> _type >> "magazines");
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

//	_aiGroup = createGroup CIVILIAN;

	_vehicle = [_vehicleClass, _missionPos, 0] call _createVehicle;

	_leader = effectiveCommander _vehicle;
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "RED"; // Defensive behaviour
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "HOLD";
		//_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityListII) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	//_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "picture");
	//_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "displayName");

	//_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Intercept it and recover its cargo!", _vehicleName, sideMissionColor];

	_numWaypoints = count waypoints _aiGroup;
	
////////////////	
	_missionHintText = format ["Pirates captured the castle, do not let intruders steal the treasures of Princess <t color='%1'>Margot</t>!", sideMissionColor]

};


_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
	{ deleteVehicle _x } forEach _objects2;
	//{ deleteVehicle _x } forEach _vehicle;
	
//deleteVehicle "O_Heli_Attack_02_black_F";
	
	//{ deleteMarker _x } forEach [_marker11, _marker12, _marker13];

};


_successExec =

{	
	// Mission complete
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _objects2;
	[_locationsArray, _missionLocation, _objects2] call setLocationObjects;

	_successHintMessage = "Princess Margot's treasures were captured, good work!";
	
	_box1 = createVehicle ["C_IDAP_CargoNet_01_supplies_F", _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USLaunchers"] call fn_refillbox;
    _box1 setPos [_missionPos select 0,_missionPos select 1,190];
	
	_marker1 = "smokeShellRed" createVehicle getPosATL _box1;
	_marker2 = "smokeShell" createVehicle getPosATL _box1;
	_marker3 = "Chemlight_Red" createVehicle getPosATL _box1;
    _marker1 setPosATL (getPosATL _box1);
	_marker2 setPosATL (getPosATL _box1);
	_marker3 setPosATL (getPosATL _box1);
    _marker1 attachTo [_box1,[0,0,0.5]];
	_marker2 attachTo [_box1,[0,0,0.6]];
	_marker3 attachTo [_box1,[0,0,0.65]];
    _time = time + 5;
	_box1 call fn_paraDrop;
	uiSleep 5;
	
	_box2 = createVehicle ["C_IDAP_CargoNet_01_supplies_F", _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;
    _box2 setPos [_missionPos select 0,_missionPos select 1,180];
	uiSleep 4;
	_marker4 = "smokeShellRed" createVehicle getPosATL _box2;
	_marker5 = "smokeShell" createVehicle getPosATL _box2;
	_marker6 = "Chemlight_Red" createVehicle getPosATL _box2;
    _marker4 setPosATL (getPosATL _box2);
	_marker5 setPosATL (getPosATL _box2);
	_marker6 setPosATL (getPosATL _box2);
    _marker4 attachTo [_box2,[0,0,0.5]];
	_marker5 attachTo [_box2,[0,0,0.6]];
	_marker6 attachTo [_box2,[0,0,0.65]];
    _time = time + 5;
	_box2 call fn_paraDrop;
	//uiSleep 5;
	
	_box3 = createVehicle ["C_IDAP_CargoNet_01_supplies_F", _lastPos, [], 2, "None"];
	_box3 setDir random 360;
	[_box3, "mission_USLaunchers"] call fn_refillbox;
    _box3 setPos [_missionPos select 0,_missionPos select 1,/*140*/150];
	
	_marker7 = "smokeShellRed" createVehicle getPosATL _box3;
	_marker8 = "smokeShell" createVehicle getPosATL _box3;
	_marker9 = "Chemlight_Red" createVehicle getPosATL _box3;
    _marker7 setPosATL (getPosATL _box3);
	_marker8 setPosATL (getPosATL _box3);
	_marker9 setPosATL (getPosATL _box3);
    _marker7 attachTo [_box3,[0,0,0.5]];
	_marker8 attachTo [_box3,[0,0,0.6]];
	_marker9 attachTo [_box3,[0,0,0.65]];
    _time = time + 5;
	_box3 call fn_paraDrop;
	
	{ deleteVehicle _x } forEach _objects;
	{ deleteMarker _x } forEach [_marker11, _marker12, _marker13];
	
	
};


_this call sideMissionProcessor;


