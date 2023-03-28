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
//	@file Name: mission_StoreGrab.sqf
//	Initial version of code -> A3Wasteland.com
//	@file author inspiration: this is done thanks to the love of my only princess Margot, love charges me with energy, giving this opportunity ...
//	@file Author: [IT42O] MjDoc

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_nbUnits", "_outpost", "_objects"];

_setupVars =
{
	_missionType = "Store Grab";
	_locationsArray = MissSpawnMarkers;
	_nbUnits = AI_GROUP_SMALL;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_outpost = (call compile preprocessFileLineNumbers "server\missions\outposts\outpostsList24.sqf") call BIS_fnc_selectRandom;
	_objects = [_outpost, _missionPos, 0] call createStoreGrab;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroupCIV;

	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;
	
	_missionHintText = format ["An armed <t color='%1'>Store Grab</t> containing weapon crates has been spotted near the marker, go capture it!", sideMissionColor]
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Store Grab STARTED";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Store Grab FAILED";
};

_successExec =
{
	// Mission complete
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _objects;
	[_locationsArray, _missionLocation, _objects] call setLocationObjects;

	_successHintMessage = "The Store is captured, good work!, the ammunition boxs is inside. Take it now!";
//	diag_log "[BRO'F] WASTELAND SERVER - Mission Store Grab COMPLETED";
};

_this call sideMissionProcessor3;
