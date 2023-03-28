//	@file Name: mission_Coastal_Convoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo)

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf"

private ["_vehChoices", "_convoyVeh", "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints", "_box1", "_box2", "_box3", "_signal", "_popaql", "_smoke", "_pos", "_vehicle", "_chute"];

_setupVars =
{
	_missionType = "Deadly Patrol";
	_locationsArray = CoastalConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_vehChoices =
	[
		["O_Heli_Attack_02_black_F", "O_Heli_Attack_02_black_F"],
		["O_Heli_Attack_02_black_F", "O_Heli_Attack_02_black_F"],
		["O_Heli_Attack_02_black_F", "O_Heli_Attack_02_black_F"]
	];

	if (missionDifficultyHard) then
	{
		(_vehChoices select 0) set [1, "O_Heli_Attack_02_black_F"];
		(_vehChoices select 1) set [1, "O_Heli_Attack_02_black_F"];
		(_vehChoices select 2) set [1, "O_Heli_Attack_02_black_F"];
	};

	_convoyVeh = _vehChoices call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	//_veh3 = _convoyVeh select 0;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_variant", "_special", "_vehicle", "_soldier"];

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
			case (_type isKindOf "Boat_Armed_01_base_F"):
			{
				// the boats need a gunner (rear) and a commander (frontgunner) aside from a driver
				if (missionDifficultyHard) then
				{
					// frontgunner will be here if mission is running at hard dificulty
					_soldier = [_aiGroup, _position] call createRandomSoldierC;
					_soldier moveInTurret [_vehicle, [0]]; // commanderseat - front gunner
				};

				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [1]]; // rear gunner
			};

			case (_type isKindOf "Heli_Transport_01_base_F"):
			{
				// these choppers have 2 turrets so we need 2 gunners
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [1]];

				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [2]];
			};

			case (_type isKindOf "O_Heli_Attack_02_dynamicLoadout_F" || _type isKindOf "O_Heli_Attack_02_dynamicLoadout_F"):
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

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startdirs select 0] call _createVehicle,
		[_veh2, _starts select 1, _startdirs select 1] call _createVehicle
		//[_veh3, _starts select 2, _startdirs select 2] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "RED"; // units will defend themselves
	_aiGroup setBehaviour "COMBAT"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "LIMITED" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");

	_missionHintText = format ["Two <t color='%3'>%1</t> are patrolling the coasts, escorted by a <t color='%3'>%2</t>.<br/>Intercept them and recover their cargo!", _vehicleName, _vehicleName2, mainMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed
	
	_box1 = createVehicle ["C_IDAP_supplyCrate_F", _lastPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;
	_marker1 = "smokeShellRed" createVehicle getPosATL _box1;
	_marker2 = "smokeShellOrange" createVehicle getPosATL _box1;
    _marker1 setPosATL (getPosATL _box1);
	_marker2 setPosATL (getPosATL _box1);
    _marker1 attachTo [_box1,[0,0,0]];
	_marker2 attachTo [_box1,[0,0,0.5]];
	_time = time + 5;
	
	_box2 = createVehicle ["C_IDAP_supplyCrate_F", _lastPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;
	_marker3 = "smokeShellRed" createVehicle getPosATL _box2;
	_marker4 = "smokeShellOrange" createVehicle getPosATL _box2;
    _marker3 setPosATL (getPosATL _box2);
	_marker4 setPosATL (getPosATL _box2);
    _marker3 attachTo [_box2,[0,0,0]];
	_marker4 attachTo [_box2,[0,0,0.5]];
	_time = time + 5;
	
	_successHintMessage = "The patrol has been stopped, the ammo crates are yours to take. Find them near the wreck!";
};

_this call mainMissionProcessor3;
