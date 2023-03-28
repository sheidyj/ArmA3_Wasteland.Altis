// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_headgear", "_goggles"];
_player = _this;

// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_vest = [_player, "vest"] call getDefaultClothing;
_headgear = [_player, "headgear"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;

if (_uniform != "") then { _player addUniform _uniform };
if (_vest != "") then { _player addVest _vest };
if (_headgear != "") then { _player addHeadgear _headgear };
if (_goggles != "") then { _player addGoggles _goggles };

sleep 0.1;

// Remove GPS
//_player unlinkItem "ItemGPS";

// Remove radio
//_player unlinkItem "ItemRadio";

// Remove NVG
if (hmd _player != "") then { _player unlinkItem hmd _player };

// Add NVG
//_player linkItem "NVGoggles";

//_player addMagazine "9Rnd_45ACP_Mag";
//_player addWeapon "hgun_ACPC2_F";
//_player addMagazine "9Rnd_45ACP_Mag";
//_player addItem "FirstAidKit";
//_player selectWeapon "hgun_ACPC2_F";

switch (true) do
{
	case (["_medic_", typeOf _player] call fn_findString != -1):
	{
		removeBackpack _player;
		removeAllWeapons _player;
		_player addBackpack "B_Carryall_cbr";
		_player addVest "V_TacVestIR_blk";
		_player addMagazine "100Rnd_65x39_caseless_mag";
		_player addMagazine "100Rnd_65x39_caseless_mag";
		_player addWeapon "B_Patrol_Soldier_Medic_weapon_F";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addItem "Medikit";
	};
	case (["_engineer_", typeOf _player] call fn_findString != -1):
	{
		removeBackpack _player;
		removeAllWeapons _player;
		_player addBackpack "B_Carryall_cbr";
		_player addMagazine "30Rnd_556x45_Stanag";
		_player addMagazine "30Rnd_556x45_Stanag";
		_player addMagazine "30Rnd_556x45_Stanag";
		_player addMagazine "30Rnd_556x45_Stanag";
		_player addWeapon "arifle_MXC_Holo_pointer_F";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addItem "Toolkit";
		_player addItem "MineDetector";
		_player addWeapon "Binoculars";
		_player addItem "FirstAidKit";
		_player addItem "FirstAidKit";
	};
	case (["_sniper_", typeOf _player] call fn_findString != -1):
	{
		removeBackpack _player;
		removeAllWeapons _player;
		_player addBackpack "B_Carryall_cbr";
		_player addMagazine "20Rnd_762x51_Mag";
		_player addMagazine "20Rnd_762x51_Mag";
		_player addMagazine "20Rnd_762x51_Mag";
		_player addMagazine "20Rnd_762x51_Mag";
		_player addMagazine "20Rnd_762x51_Mag";
		_player addWeapon "srifle_DMR_03_tan_AMS_LP_F";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addWeapon "Rangefinder";
		_player addItem "FirstAidKit";
		_player addItem "FirstAidKit";	
	};
};

if (_player == player) then
{
	thirstLevel = 100;
	hungerLevel = 100;
};
