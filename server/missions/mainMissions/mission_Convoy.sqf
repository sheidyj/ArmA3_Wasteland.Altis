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
//	@file Name: mission_Convoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file embellished by [IT42O] MjDoc

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_marker1", "_marker2", "_convoyVeh", "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2"];

_setupVars =
{
	_missionType = "Ammunition Transportation";		//rev by mjd
	_locationsArray = LandConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// pick the vehicles for the convoy
	_convoyVeh =
	[
		["B_T_Truck_01_covered_F", "O_Truck_03_covered_F", "O_T_Truck_03_covered_ghex_F"],		//by mjd
		["B_T_Truck_01_covered_F", "O_Truck_03_covered_F", "O_T_Truck_03_covered_ghex_F"],		//by mjd
		["B_T_Truck_01_covered_F", "O_Truck_03_covered_F", "O_T_Truck_03_covered_ghex_F"]		//by mjd
	] call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 2;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		//_vehicle setVariable ["A3W_skipAutoSave", true, true];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;		//by mjd
		_soldier moveInCargo _vehicle;									//by mjd
		
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];

		if !(_type isKindOf "Truck_F") then
		{
			_soldier = [_aiGroup, _position] call createRandomSoldier;
			_soldier moveInGunner _vehicle;

			_soldier = [_aiGroup, _position] call createRandomSoldier;

			if (_vehicle emptyPositions "commander" > 0) then
			{
				_soldier moveInCommander _vehicle;
			}
			else
			{
				_soldier moveInCargo [_vehicle, 0];
			};
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startDirs select 0] call _createVehicle
		//[_veh2, _starts select 1, _startDirs select 1] call _createVehicle,
		//[_veh3, _starts select 2, _startDirs select 2] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "RED"; 														// units will defend themselves
	_aiGroup setBehaviour "SAFE";													    // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 25;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "SAFE";											 // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");

	_missionHintText = format ["A <t color='%2'>%1</t> with a box of weapons, equipments and dirty money moves on a map. Stop him and take booty!", _vehicleName, mainMissionColor];

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

	_box1 = createVehicle ["Box_NATO_Equip_F", _lastPos, [], 2, "None"];											//rev by mjd
	_box1 setDir random 360;
	[_box1, "mission_ASSRIFLCRATE"] call fn_refillbox;																//by mjd
	
	_box2 = createVehicle ["Box_NATO_Equip_F", _lastPos, [], 2, "None"];											//rev by mjd
	_box2 setDir random 360;
	[_box2, "mission_AmmsCrt"] call fn_refillbox;																	//by mjd

	_successHintMessage = "The convoy has been destroyed!, the equipment box, weapons are now at your disposal!";	//rev by mjd
};

_this call mainMissionProcessor;
