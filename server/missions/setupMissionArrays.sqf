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
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev, [IT42O] MjDoc
//	@file embellished by [IT42O] MjDoc

if (!isServer) exitWith {};

MainMissions =
[
	// Mission filename, weight
	["mission_ArmedDiversquad", 2],					//test
//	["mission_Coastal_Convoy", 3],					//np
//	["mission_Convoy", 2]							//np
//	["mission_HostileHeliFormation", 3]				//np
//	["mission_AirPatrol", 2]						//np
//	["mission_APC", 0.5],							//np
//	["mission_MBT", 0.5],							//np
	["mission_LightArmVeh", 0.5]					//test
//	["mission_ArmedHeli", 0.5],						//np
//	["mission_CivHeli", 0.2]						//np
];

SideMissions =
[
//	["mission_HostileHelicopter", 2],				//np
//	["mission_MiniConvoy", 1]						//np. small probl. in waypoints
	["mission_SunkenSupplies", 1]					//test
//	["mission_TownInvasion", 2],					//np
//	["mission_CaptureStadium", 0.5],				//prbl.
//	["mission_Princess_Margots_treasures", 0.25],	//np
//	["mission_StoreGrab", 1],						//np
//	["mission_Outpost", 3],							//np
//	["mission_TowerDominations", 2.5]				//np
//	["mission_Truck", 1]							//np
];

MoneyMissions =
[
//	["mission_MoneyShipment", 2],					//np
	["mission_SunkenTreasure", 3]					//test
];
// Markers
//new pos by mjd need redaction
MSpMark = (allMapMarkers select {["PrincessMargotsPoint_", _x] call fn_startsWith}) apply {[_x, false]};					//by mjd
MissSpawnMarkers = (allMapMarkers select {["StoreGrab_", _x] call fn_startsWith}) apply {[_x, false]};						//by mjd
MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith}) apply {[_x, false]};
MissiAirVehMarkers = (allMapMarkers select {["MissAirVeh_", _x] call fn_startsWith}) apply {[_x, false]};					//by mjd
MissVehMarkers = (allMapMarkers select {["MissVeh_", _x] call fn_startsWith}) apply {[_x, false]};							//by mjd
MissSpawnMarks = (allMapMarkers select {["TowerDominPoint_", _x] call fn_startsWith}) apply {[_x, false]};					//by mjd
MissAmmTrkSpMarks = (allMapMarkers select {["AmmMissTrkPoint_", _x] call fn_startsWith}) apply {[_x, false]};				//by mjd
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenAmmunitionMission = (allMapMarkers select {["AmmunitionMission_", _x] call fn_startsWith}) apply {[_x, false]};		//by mjd

if !(ForestMissionMarkers isEqualTo []) then
{
	SideMissions append
	[
		/*["mission_AirWreck", 3],
		["mission_WepCache", 3]*/
	];
};

LandConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf") apply {[_x, false]};
CoastalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf") apply {[_x, false]};
LightMilPatPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\LightMilPatList.sqf") apply {[_x, false]};	//by mjd

MainMissions = [MainMissions, [["A3W_heliPatrolMissions", ["mission_Coastal_Convoy", "mission_HostileHeliFormation", "mission_AirPatrol"]], ["A3W_underWaterMissions", ["mission_ArmedDiversquad"]]]] call removeDisabledMissions;
SideMissions = [SideMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
MoneyMissions = [MoneyMissions, [["A3W_underWaterMissions", ["mission_SunkenTreasure"]]]] call removeDisabledMissions;

{ _x set [2, false] } forEach MainMissions;
{ _x set [2, false] } forEach SideMissions;
{ _x set [2, false] } forEach MoneyMissions;
