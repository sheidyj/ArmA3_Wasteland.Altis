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
//	@file Name: createMissionMarker2.sqf
//	@file author inspiration: this is done for my only princess Margot, love charges me with energy giving this opportunity ...
//	@file Author: [IT42O] MjDoc

private ["_text", "_pos", "_marker", "_marker2", "_marker3"];

_text = _this select 0;
_pos = _this select 1;


_marker = format ["mission_%1_%2", [_text] call fn_filterString, call A3W_fnc_generateKey];
_marker = createMarker [_marker, _pos];
_marker setMarkerType "selector_selectedEnemy";
_marker setMarkerSize [0.93, 0.93];
_marker setMarkerColor "ColorOrange";
_marker setMarkerText _text;

_marker




