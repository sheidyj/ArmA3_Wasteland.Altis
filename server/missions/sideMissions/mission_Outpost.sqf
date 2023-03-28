//	@file Name: mission_VehicleCapture.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_nbUnits", "_outpost", "_objects"];

_setupVars =
{
	_missionType = "Camp Adversary";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = AI_GROUP_MEDIUM;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_outpost = (call compile preprocessFileLineNumbers "server\missions\outposts\outpostsList.sqf") call BIS_fnc_selectRandom;
	_objects = [_outpost, _missionPos, 0] call createOutpost;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits, 5] call createCustomGroup;

	_missionHintText = format ["An armed <t color='%1'>Camp Adversary</t> containing weapon crates has been spotted near the marker, go capture it!", sideMissionColor]
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Camp Adversary STARTED";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Camp Adversary FAILED";
};

_successExec =
{
	// Mission complete
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _objects;
	[_locationsArray, _missionLocation, _objects] call setLocationObjects;

	_successHintMessage = "The Camp Adversary has been captured, good work!";
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Camp Adversary COMPLETED";
};

_this call sideMissionProcessor2;
