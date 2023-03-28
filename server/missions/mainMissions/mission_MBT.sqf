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
//	@file Name: mission_MBT.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file embellished by [IT42O] MjDoc

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"B_MBT_01_cannon_F",
		"B_MBT_01_TUSK_F",
		"B_T_MBT_01_cannon_F",
		"B_T_MBT_01_TUSK_F",
		"O_MBT_02_cannon_F",
		"O_MBT_04_cannon_F",
		"O_MBT_04_command_F",
		"O_T_MBT_02_cannon_ghex_F",
		"O_T_MBT_04_cannon_F",
		"O_T_MBT_04_command_F",
		"B_AFV_Wheeled_01_cannon_F",
		"B_AFV_Wheeled_01_up_cannon_F",
		"B_T_AFV_Wheeled_01_cannon_F",
		"B_T_AFV_Wheeled_01_up_cannon_F",
		"I_MBT_03_cannon_F"
	] call BIS_fnc_selectRandom;

	_missionType = "Heavyweight Tank";
	_locationsArray = MissVehMarkers;		//rev by mjd

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_this call mission_VehicleCapture;
