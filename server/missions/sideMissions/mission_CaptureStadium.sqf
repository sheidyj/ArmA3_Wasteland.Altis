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
//	@file Name: mission_CaptureStadium.sqf
//	Initial version of code -> A3Wasteland.com
//	@file author inspiration: this is done thanks to the love of my only princess Margot, love charges me with energy, giving this opportunity ...
//	@file Author: [IT42O] MjDoc

if (!isServer) exitwith {};

#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_outpost", "_objects", "_marker1", "_marker2", "_time", "_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_createVehicle"];

_setupVars =
{
	_missionType = "Capture stadium";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_MEDIUM } else { AI_GROUP_MEDIUM };

	// settings for this mission
	_locArray = ((call cityListII) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;

	//randomize amount of units
	_nbUnits = _nbUnits + round(random (_nbUnits*0.5));
	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
};



_setupObjects =
{
	
	//_missionPos = markerPos _missionLocation;

	_outpost = (call compile preprocessFileLineNumbers "server\missions\outposts\CaptureStadiumCord.sqf") call BIS_fnc_selectRandom;
	_objects = [_outpost, _missionPos, 0] call createCaptureStadium;
	
//	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_objects];
	
	// spawn some rebels/enemies
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits, 90] call createStadiumSoldiers;

	// move them into buildings
	//[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;

	
	
	_vehicleClass = if (missionDifficultyHard) then
	{
		selectRandom ["B_Heli_Transport_01_F", "B_Heli_Transport_01_F"];
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

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "NORMAL" };

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
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "displayName");	//by mjd test

	//_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Intercept it and recover its cargo!", _vehicleName, sideMissionColor];

	_numWaypoints = count waypoints _aiGroup;
	
	
	//_missionHintText = format ["<br/><t size='1.25' color='%1'>%2</t><br/><br/>There seem to be <t color='%1'>%3 enemies</t> hiding inside stadium, and one helicopter patrols the airspace. Get rid of them all, and take their supplies!<br/>", sideMissionColor, _townName, _nbUnits];

	
	//_Its_time42O = "Land_ConnectorTent_01_white_closed_F";	// by mjd test
	//_missionPicture = getText (configFile >> "CfgVehicles" >> (_Its_time42O param [0,""]) >> "picture");		// by mjd test
	
	_missionHintText = format ["<br/><t size='1.25' color='%2'>%3</t><br/><br/>There seem to be <t color='%2'>%4 enemies</t> hiding inside stadium, and <t color='%2'>%1</t> patrols the airspace. Get rid of them all, and take their supplies!<br/>", _vehicleName, sideMissionColor, _townName, _nbUnits];	//by mjd test
	
	//_missionHintText = format ["<br/><t size='1.25' color='%2'>%3</t><br/><br/>There seem to be <t color='%2'>%4 enemies</t> hiding inside stadium, and <t color='%2'>%1</t> patrols the airspace. Get rid of them all, and take their supplies!<br/>", _missionPicture, _vehicleName, sideMissionColor, _townName, _nbUnits];	//by mjd test
	uiSleep 0.1;
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Capture stadium successfully LOADED";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = nil;
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
//	uiSleep 0.1;
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Capture stadium FAILED";
};

_successExec =
{
	// Mission completed
	//{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];

	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Their belongings are now yours, amunition nearby. Take it!, damn it now!!!", sideMissionColor, _townName];
		
	_box1 = createVehicle ["I_E_CargoNet_01_ammo_F", _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;
    _box1 setPos [_missionPos select 0,_missionPos select 1,140];
	
	_marker1 = "smokeShellRed" createVehicle getPosATL _box1;
	_marker2 = "smokeShell" createVehicle getPosATL _box1;
    _marker1 setPosATL (getPosATL _box1);
	_marker2 setPosATL (getPosATL _box1);
    _marker1 attachTo [_box1,[0,0,0]];
	_marker2 attachTo [_box1,[0,0,0.5]];
    _time = time + 5;
	_box1 call fn_paraDrop;
	//uiSleep 5;
	
	_box2 = createVehicle ["I_E_CargoNet_01_ammo_F", _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;
	_box2 setPos [_missionPos select 0,_missionPos select 1,145];
	
	_marker3 = "smokeShellRed" createVehicle getPosATL _box2;
	_marker4 = "smokeShell" createVehicle getPosATL _box2;
    _marker3 setPosATL (getPosATL _box2);
	_marker4 setPosATL (getPosATL _box2);
    _marker3 attachTo [_box2,[0,0,0]];
	_marker4 attachTo [_box2,[0,0,0.5]];
    _time = time + 5;
	_box2 call fn_paraDrop;
	
	{ deleteVehicle _x } forEach _objects;
//	uiSleep 0.1;
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Capture stadium successfully COMPLETED";
};

_this call sideMissionProcessor2;
