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
//	@file Name: mainMissionProcessor3.sqf
//	Initial version of code -> A3Wasteland.com
//	@file author inspiration: this is done thanks to the love of my only princess Margot, love charges me with energy, giving this opportunity ...
//	@file Author: [IT42O] MjDoc

#define MISSION_PROC_TYPE_NAME "Main"
#define MISSION_PROC_TIMEOUT (["A3W_mainMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE mainMissionColor

#include "mainMissions\mainMissionDefines.sqf"
#include "missionProcessor7.sqf";
