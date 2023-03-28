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
//	@file Name: mission_LightArmVeh.sqf
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
		"B_APC_Tracked_01_rcws_F",
		"B_MRAP_01_gmg_F",
		"B_MRAP_01_hmg_F",
		"B_T_APC_Wheeled_01_cannon_F",
		"B_T_APC_Tracked_01_rcws_F",
		"B_T_MRAP_01_gmg_F",
		"B_T_MRAP_01_hmg_F",
		"O_APC_Wheeled_02_rcws_v2_F",
		"O_MRAP_02_gmg_F",
		"O_MRAP_02_hmg_F",
		"O_T_MRAP_02_gmg_ghex_F",
		"O_T_MRAP_02_hmg_ghex_F",
		"I_E_APC_tracked_03_cannon_F",
		"I_APC_tracked_03_cannon_F",
		"I_APC_Wheeled_03_cannon_F",
		"I_MRAP_03_gmg_F",
		"I_MRAP_03_hmg_F"
	] call BIS_fnc_selectRandom;

	_missionType = "Military Vehicle";
	_locationsArray = MissVehMarkers;		//rev by mjd

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_this call mission_VehicleCapture;
