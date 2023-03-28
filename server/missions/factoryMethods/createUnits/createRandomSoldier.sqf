//	@file Name: createRandomSoldier.sqf
/*
 * Creates a random civilian soldier.
 *
 * Arguments: [ position, group, init, skill, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    init: String - (optional, default "") Command to be executed upon creation of unit. Parameter this is set to the created unit and passed to the code.
 *    skill: Number - (optional, default 0.5)
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};

private ["_soldierTypes", "_uniformTypes", "_vestTypes", "_BackpackTypes", "_weaponTypes", "_launcherTypes", "_group", "_position", "_rank", "_soldier"];

_soldierTypes = ["C_Man_1_enoch_F", "C_Man_2_enoch_F", "C_Man_3_enoch_F", "C_Man_4_enoch_F", "C_Man_5_enoch_F", "C_Man_6_enoch_F"];
_uniformTypes = ["U_B_CTRG_Soldier_F", "U_B_CTRG_Soldier_F", "U_B_CTRG_Soldier_F"];
_vestTypes = ["V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_dgtl"];
_BackpackTypes = ["B_Carryall_green_F", "B_Carryall_green_F", "B_Carryall_green_F"];
_weaponTypes = ["srifle_DMR_06_camo_F", "LMG_Mk200_F", "LMG_Zafir_F", "LMG_03_F"];
_launcherTypes = ["launch_I_Titan_eaf_F", "launch_O_Vorona_green_F", "launch_NLAW_F", "launch_RPG32_green_F"];


_group = _this select 0;
_position = _this select 1;
_rank = param [2, "", [""]];

_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
_soldier addUniform (_uniformTypes call BIS_fnc_selectRandom);
_soldier addVest (_vestTypes call BIS_fnc_selectRandom);
_soldier addBackpack (_BackpackTypes call BIS_fnc_selectRandom);

[_soldier, _weaponTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;
[_soldier, _launcherTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;


if (_rank != "") then
{
	_soldier setRank _rank;
};

_soldier spawn refillPrimaryAmmo;
_soldier spawn addMilCap;
_soldier call setMissionSkill;

_soldier addEventHandler ["Killed", server_playerDied];

_soldier
