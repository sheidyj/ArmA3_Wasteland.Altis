// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

MainMissions =
[
	// Mission filename, weight
//	["mission_ArmedDiversquad", 2],
//	["mission_Coastal_Convoy", 3],
//	["mission_Convoy", 2]
//	["mission_HostileHeliFormation", 3]
	["mission_AirPatrol", 2],
//	["mission_APC", 0.5],
//	["mission_MBT", 0.5],
//	["mission_LightArmVeh", 0.5]
	["mission_ArmedHeli", 0.5],
//	["mission_CivHeli", 0.2]
];

SideMissions =
[
//	["mission_HostileHelicopter", 2],
//	["mission_MiniConvoy", 1],
//	["mission_SunkenSupplies", 1],
//	["mission_TownInvasion", 2],
	["mission_CaptureStadium", 1],
	["mission_Princess_Demons_treasures", 1],
	["mission_StoreGrab", 1],
//	["mission_Outpost", 3],
//	["mission_TowerDominations", 2.5],
//	["mission_Truck", 1]
];

MoneyMissions =
[
	["mission_MoneyShipment", 1],
//	["mission_SunkenTreasure", 1]
];

MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};

if !(ForestMissionMarkers isEqualTo []) then
{
	SideMissions append
	[
		["mission_AirWreck", 3],
		["mission_WepCache", 3]
	];
};

LandConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf") apply {[_x, false]};
CoastalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf") apply {[_x, false]};

MainMissions = [MainMissions, [["A3W_heliPatrolMissions", ["mission_Coastal_Convoy", "mission_HostileHeliFormation"]], ["A3W_underWaterMissions", ["mission_ArmedDiversquad"]]]] call removeDisabledMissions;
SideMissions = [SideMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
MoneyMissions = [MoneyMissions, [["A3W_underWaterMissions", ["mission_SunkenTreasure"]]]] call removeDisabledMissions;

{ _x set [2, false] } forEach MainMissions;
{ _x set [2, false] } forEach SideMissions;
{ _x set [2, false] } forEach MoneyMissions;
