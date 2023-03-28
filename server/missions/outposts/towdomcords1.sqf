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
//	@file Name: towdomcords1.sqf
//	Initial version of code -> A3Wasteland.com
//	@file author inspiration: this is done thanks to the love of my only princess Margot, love charges me with energy, giving this opportunity ...
//	@file Author: [IT42O] MjDoc


[
	// Class, Position, Direction, Init
	["Land_ControlTower_01_F", [0, 0, 0], 0],
	["Box_EAF_AmmoVeh_F", [0.797363,-2.55566, 9.4], 0, { [_this, ["mission_USSpecial", "mission_Main_A3snipers"] call BIS_fnc_selectRandom] call fn_refillbox }],
	["Land_Bunker_01_blocks_3_F",[-6.22461,-0.187744,0],270.576],
	["Land_Bunker_01_blocks_3_F",[0.750977,6.8772,0],359.545],
	["Land_Bunker_01_blocks_3_F",[0.786133,-7.4314,0],179.85],
	["Land_BagFence_01_round_green_F",[-5.0918,5.65503,-0.00130129],131.517],
	["Land_BagFence_01_round_green_F",[-5.05518,-6.16699,-0.00130129],43.0277],
	["Land_Bunker_01_blocks_3_F",[7.95752,-0.30542,0],90.3304],
	["Land_BagFence_01_round_green_F",[6.60986,5.3291,-0.00130129],227.133],
	["Land_BagFence_01_round_green_F",[6.74561,-6.31787,-0.00130129],316.314],
	["Land_ConcreteHedgehog_01_F",[-11.7944,-4.25293,0],297.15],
	["Land_ConcreteHedgehog_01_F",[-12.4331,2.35498,0],292.583],
	["Land_ConcreteHedgehog_01_F",[-10.3018,8.09399,0],247.565],
	["Land_ConcreteHedgehog_01_F",[-5.87402,11.762,0],80.4094],
	["Land_ConcreteHedgehog_01_F",[0.455566,13.4683,0],310.152],
	["Land_ConcreteHedgehog_01_F",[-9.65723,-9.92651,0],266.626],
	["Land_ConcreteHedgehog_01_F",[13.9448,-0.50293,0],9.92456],
	["Land_ConcreteHedgehog_01_F",[12.3325,6.92993,0],284.622],
	["Land_ConcreteHedgehog_01_F",[7.71875,12.2302,0],64.6944],
	["Land_ConcreteHedgehog_01_F",[1.94824,-14.4309,0],221.9],
	["Land_ConcreteHedgehog_01_F",[-4.87061,-13.8057,0],171.962],
	["Land_ConcreteHedgehog_01_F",[12.8823,-7.21436,0],139.629],
	["Land_ConcreteHedgehog_01_F",[8.31299,-12.4558,0],106.799],
	["I_E_CargoNet_01_ammo_F", [0.766113, -2.63086, 0.031], 0, { [_this, "mission_USLaunchers"] call fn_refillbox }],
	["O_GMG_01_high_F",[-2.6626,-3.94531,12.3654],229.728,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["O_GMG_01_high_F",[-2.49561,4.14063,12.3654],320.801,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["O_GMG_01_high_F",[3.87158,-4.13623,12.3654],139.011,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["O_GMG_01_high_F",[4.22607,3.89941,12.3654],46.4312,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["I_HMG_02_high_F",[5.72119,-5.48779,-0.0749998],141.011,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["I_HMG_02_high_F",[5.82227,4.33936,-0.0749998],46.4312,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["I_HMG_02_high_F",[-4.31396,-5.05005,-0.0749998],223.787,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	["I_HMG_02_high_F",[-4.30811,4.99854,-0.0749998],312.32,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/]
]


