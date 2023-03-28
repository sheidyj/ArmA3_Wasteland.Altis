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
//	@file Name: Outpost1.sqf
//	@file Author: JoSchaap, AgentRev, [IT42O] MjDoc
//	@file embellished by [IT42O] MjDoc

[
	// Class, Position, Direction, Init /*(optional X, Y, heit, turn)*/
	["Land_Bunker_01_blocks_3_F", [/*-*/0/*.232666*/, 8.4473, 0.153743], 359.72],
	["Land_Bunker_01_tall_F", [-7.20874, 7.29346, 0.0623822], 135.219],
	["Land_Mil_WallBig_4m_F", [-/*0*/10.163574, 0/*1.57666*/, 0/*.0357904*/], /*91.34008*/90],
	["Land_Bunker_01_tall_F", [7.20874, 7.37305, 0.0623822], 224.5],
	["Box_CSAT_Equip_F", [-1.04126, 0.24707, 0], 286.415, { [_this, ["mission_USSpecial", "mission_Main_A3snipers"] call BIS_fnc_selectRandom] call fn_refillbox }],
	["CamoNet_BLUFOR_open_F", [0, 0, /*-*/0.5/*00534153*/], 0/*.243539*/],
	["Box_East_WpsSpecial_F", [0.470947, -0.591309, 0], 85.8074, { [_this, "mission_USLaunchers"] call fn_refillbox }],
	["Land_Mil_WallBig_4m_F", [/*-0*/10./*246338*/163574, /*-1.82959*/0, /*-*/0/*.0460205*/], /*359.373*/270],
	["Land_Bunker_01_tall_F", [-7.20874, -7.29346, 0.0623822], 44.567],
	["Land_Bunker_01_tall_F", [7.20874, -7.37305, 0.0623822], -44.162272],
	["Land_Bunker_01_blocks_3_F", [/*-*/0/*.29248*/, -8.4473, 0.116841], 181.21038],
	["O_GMG_01_high_F", [7.80874, 7.97305, 5.1], 0,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["O_GMG_01_high_F", [-7.80874, 7.99346, 5.1], 0,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["O_GMG_01_high_F", [-7.80874, -7.99346, 5.1], 180,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["O_GMG_01_high_F", [7.80874, -7.97305, 5.1], 180,/*{if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/]
]
