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
//	@file Name: CaptureStadium.sqf
//	Initial version of code -> A3Wasteland.com
//	@file author inspiration: this is done thanks to the love of my only princess Margot, love charges me with energy, giving this opportunity ...
//	@file Author: [IT42O] MjDoc

[
	// Class, Position, Direction, Init /*(optional X, Y, heit, turn)*/
	["Land_Garbage_square5_F",[0.0805664,0.0751953,0],0], 
	["Campfire_burning_F",[0,-0.0498047,0.0299988],0],
	["Land_ClothShelter_02_F",[13.8535,5.14063,0],99.5866],
	["Land_ClothShelter_02_F",[-3.36475,-14.7705,0],166.916],
	["Land_Sleeping_bag_brown_F",[16.355,2.06543,0],233.031],
	["Land_Sleeping_bag_brown_F",[0.227539,-16.7695,0],27.3499],
	["Land_Sleeping_bag_brown_F",[18.3984,1.54492,0],231.426],
	["Land_Sleeping_bag_brown_F",[17.1401,7.62012,0],320.509],
	["Land_Sleeping_bag_brown_F",[-5.34229,-18.3506,0],300.048],
	["Land_Sleeping_bag_brown_F",[0.920898,-18.8643,0],27.3499],
	["Land_ConnectorTent_01_floor_light_F",[20.4038,4.39063,0],278.41],
	["Land_Sleeping_bag_brown_F",[19.2568,7.49414,0],321.663],
	["Land_MedicalTent_01_white_generic_inner_F",[20.4043,4.36621,0],278.069],
	["Land_ConnectorTent_01_floor_light_F",[-1.55859,-21.0791,0],345.025],
	["Land_Sleeping_bag_brown_F",[-4.88623,-20.3965,0],300.048],
	["Land_Sleeping_bag_brown_F",[20.6831,1.32031,0],229.435],
	["Land_MedicalTent_01_white_generic_inner_F",[-1.58057,-21.0889,0],344.685],
	["Land_Sleeping_bag_brown_F",[1.56348,-20.8721,0],29.1637],
	["Land_Football_01_F",[13.7793,-17.7051,0],280.219],
	["Land_Sleeping_bag_brown_F",[21.5156,7.12012,0],323.417],
	["Land_Sleeping_bag_brown_F",[22.6133,0.908203,0],227.95],
	["Land_Sleeping_bag_brown_F",[-4.35205,-22.4922,0],300.048],
	["Land_Sleeping_bag_brown_F",[2.19141,-22.8594,0],35.5931],
	["Land_Sleeping_bag_brown_F",[23.5366,6.92578,0],326.632],
	["Land_Sleeping_bag_brown_F",[-3.74268,-24.5752,0],296.261],
	["Land_Football_01_F",[-7.93848,25.7549,0],290.076],
	["Land_ConnectorTent_01_white_closed_F",[27.459,3.35645,0],98.6569],
	["Land_ConnectorTent_01_white_closed_F",[0.259766,-27.9912,0],165.137],
	["Land_Football_01_F",[21.2261,24.8984,0],238.492],
	["Land_Football_01_F",[-27.7437,-26.3066,0],353.593],
	["Land_Football_01_F",[-21.666,-31.9082,0],136.093],
	["Land_Football_01_F",[-43.6577,-39.7598,0],74.1025],
	["Land_BagFence_Round_F",[-3.51563,-0.641602,0],81.7186],
	["Land_BagFence_Round_F",[-0.655762,3.68457,0],168.587],
	["Land_BagFence_Round_F",[0.890137,-3.69629,0],348.374],
	["Land_BagFence_Round_F",[3.91016,0.682617,0],261.506],
	
	["B_GEN_Van_02_vehicle_F",[34.728,-19.8984,0],146.807],
	//["B_GEN_Van_02_vehicle_F",[34.728,-19.8984,0],146.807,/* { if (random 1 < 0.5) exitWith { deleteVehicle _this };*/ [_this] call vehicleSetup /*}*/],
	
	["I_HMG_02_high_F",[-37.5698,32.4629,11.780],89.9879],
	["I_HMG_02_high_F",[-40.7744,28.9688,11.628],167.154],
	["O_GMG_01_high_F",[-22.9619,66.3867,0.376],156.132],
	["O_GMG_01_high_F",[-70.9663,7.90039,0.638],92.2348],
	["I_HMG_02_high_F",[-68.1938,55.4209,-0.0771675],130.532],
	["I_HMG_02_high_F",[-38.7163,31.8525,15.352],88.91],
	["I_HMG_02_high_F",[-40.2744,30.5029,15.337],171.306],
	["I_HMG_02_high_F",[27.4282,3.60254,0],280.019],
	["I_HMG_02_high_F",[0.494141,-27.8252,0],344.79]
]
