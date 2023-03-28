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
//	@file Name: Outpost2.sqf
//	@file Author: JoSchaap, AgentRev, [IT42O] MjDoc
//	@file embellished by [IT42O] MjDoc

[
	// Class, Position, Direction, Init /*(optional X, Y, heit, turn)*/
	["Land_Shed_05_F",[-0.5,0.5,0],316.486], 
	["Land_BagFence_Corner_F",[4.00366,0.436768,-0.201],46.704], 
	["Land_BagFence_Corner_F",[-0.833008,-4.06421,-0.201],136.562], 
	["Land_BagFence_Corner_F",[0.63501,4.13574,-0.201],320.418], 
	["Land_BagFence_Corner_F",[-4.2561,-0.458496,-0.201],227.909], 
	["Land_ClothShelter_02_F",[3.65356,-3.43408,0],129.249], 
	["Land_ClothShelter_02_F",[3.56592,3.97827,0],48.43], 
	["Land_ClothShelter_02_F",[-3.86401,-3.70728,0],223.226], 
	["Flag_Altis_F",[3.91113,0.395996,-0.61366],0], 
	["Land_ClothShelter_02_F",[-4.00342,4.00879,0],315.542], 
	["Box_Syndicate_WpsLaunch_F",[1.7749,1.5835,-0.000999928],234.52, { [_this, "mission_USLaunchers"/*, "mission_Main_A3snipers"*/]/* call BIS_fnc_selectRandom]*/ call fn_refillbox }],
	["Box_Syndicate_Wps_F",[-1.83472,-1.61523,/*-0.00100136*/-0.000999928],51.1088, { [_this, "mission_USSpecial"] call fn_refillbox }],
	["I_HMG_02_high_F",[3.52368,-3.82178,-0.0305505],126.901, [_this] call vehicleSetup], 
	["I_HMG_02_high_F",[3.823,3.9436,-0.0305505],2.37684, [_this] call vehicleSetup], 
	["I_HMG_02_high_F",[-4.12646,-3.64697,-0.0305591],225.397, [_this] call vehicleSetup], 
	["I_HMG_02_high_F",[-3.90601,4.21704,-0.0305486],313.802, [_this] call vehicleSetup], 
	["Land_SandbagBarricade_01_half_F",[6.24072,-1.55933,-0.2],87.53], 
	["Land_SandbagBarricade_01_half_F",[1.72144,-6.37573,-0.2],180.251], 
	["Land_SandbagBarricade_01_half_F",[6.31763,2.06079,-0.2],92.075], 
	["Land_SandbagBarricade_01_half_F",[-2.01392,-6.37158,-0.2],178.99], 
	["Land_SandbagBarricade_01_half_F",[-6.63745,1.97192,-0.2],267.894], 
	["Land_SandbagBarricade_01_half_F",[1.64819,6.73169,-0.2],359.354], 
	["Land_SandbagBarricade_01_half_F",[-6.71387,-1.73071,-0.2],271.711], 
	["Land_SandbagBarricade_01_half_F",[-2.08813,6.76001,-0.2],0.615], 
	["Land_SandbagBarricade_01_hole_F",[6.27417,-3.70874,-0.2],90.514], 
	["Land_SandbagBarricade_01_hole_F",[3.90771,-6.25537,-0.2],171.374], 
	["Land_SandbagBarricade_01_hole_F",[6.26709,4.25049,-0.2],83.198], 
	["Land_SandbagBarricade_01_hole_F",[-4.16406,-6.3501,-0.2],181.974], 
	["Land_SandbagBarricade_01_hole_F",[3.79761,6.69653,-0.2],2.338], 
	["Land_SandbagBarricade_01_hole_F",[-6.64917,-3.91943,-0.2],262.834], 
	["Land_SandbagBarricade_01_hole_F",[5.50537,-5.44531,-0.2],133.319], 
	["Land_SandbagBarricade_01_hole_F",[-6.65723,4.12158,-0.2],270.878], 
	["Land_SandbagBarricade_01_hole_F",[-4.27417,6.65283,-0.2],351.738], 
	["Land_SandbagBarricade_01_hole_F",[5.50903,5.87256,-0.2],45.143], 
	["Land_SandbagBarricade_01_hole_F",[-5.88086,-5.53784,-0.2],224.779], 
	["Land_SandbagBarricade_01_hole_F",[-5.8772,5.85278,-0.2],313.683]
]
