//	@file Name: createMissionLocation.sqf
//	@file Author: [404] Deadbeat, AgentRev

if (!isServer) exitwith {};

private ["_validLocations", "_selectedMarker", "_markerIndex"];

_validLocations = [MissionSpawnMarkers, { !(_x select 1) }] call BIS_fnc_conditionalSelect;

_selectedMarker = (_validLocations call BIS_fnc_selectRandom) select 0;
_markerIndex = [MissionSpawnMarkers, _selectedMarker] call BIS_fnc_findInPairs;

(MissionSpawnMarkers select _markerIndex) set [1, true];

[markerPos _selectedMarker, _markerIndex]
