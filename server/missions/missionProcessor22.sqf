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
//	@file Name: missionProcessor22.sqf
//	Initial version of code -> A3Wasteland.com
//	@file author inspiration: this is done thanks to the love of my only princess Margot, love charges me with energy, giving this opportunity ...
//	@file Author: [IT42O] MjDoc

if (!isServer) exitwith {};

private ["_availableLocations", "_missionLocation","_marker", "_complete", "_lastPos", "_leader"];

_marker = [_missionType, _missionPos] call createMissionMarker22;
_aiGroup setVariable ["A3W_missionMarkerName", _marker, true];
if (!isNil "_waitUntilMarkerPos") then { _marker setMarkerPos (call _waitUntilMarkerPos) };


else
{
	// Mission completed

	if (isNull _leader) then
	{
		_lastPos = markerPos _marker;
	}
	else
	{
		_lastPos = _leader call fn_getPos3D;
		_floorHeight = (getPos _leader) select 2;
		_lastPos set [2, (_lastPos select 2) - _floorHeight];
	};

	if (!isNil "_successExec") then { call _successExec };
	
	};

deleteMarker _marker;

if (!isNil "_locationsArray") then
{
	[_locationsArray, _missionLocation, false] call setLocationState;
};
