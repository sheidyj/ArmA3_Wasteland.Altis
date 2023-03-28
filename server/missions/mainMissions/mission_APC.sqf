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
//	@file Name: mission_APC.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file embellished by [IT42O] MjDoc

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"B_APC_Wheeled_01_cannon_F",
		"O_APC_Wheeled_02_rcws_F",
		"I_APC_Wheeled_03_cannon_F",
		"B_APC_Tracked_01_rcws_F",
		"I_LT_01_AA_F",
		"O_T_APC_Tracked_02_AA_ghex_F",
		"B_T_APC_Tracked_01_AA_F",
		"O_APC_Tracked_02_cannon_F",
		"I_APC_tracked_03_cannon_F",
		"B_APC_Tracked_01_AA_F",
		"O_APC_Tracked_02_AA_F"
	] call BIS_fnc_selectRandom;

	_missionType = switch (true) do
	{
		case ({_vehicleClass isKindOf _x} count ["B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F"] > 0): { "Anti-aircraft machine" };		//rev by mjd
		case (_vehicleClass isKindOf "Tank_F"):                                                          { "Tank at rest" };				//rev by mjd
		default                                                                                          { "APC at rest" };					//rev by mjd
	};

	_locationsArray = MissVehMarkers;		//rev by mjd

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_this call mission_VehicleCapture;
