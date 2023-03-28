//	@file Name: createRandomSoldierC.sqf

if (!isServer) exitWith {};

private ["_soldierTypes", "_vestTypes", "_weaponTypes", "_group", "_position", "_soldier"];

_soldierTypes = ["C_Man_1_enoch_F", "C_Man_2_enoch_F", "C_Man_3_enoch_F", "C_Man_4_enoch_F", "C_Man_5_enoch_F", "C_Man_6_enoch_F"];
_vestTypes = ["V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_dgtl"];
_weaponTypes = ["srifle_DMR_06_camo_F", "LMG_Mk200_F", "LMG_Zafir_F", "LMG_03_F"];
_group = _this select 0;
_position = _this select 1;
_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
_soldier addUniform "U_B_CTRG_Soldier_F";
_soldier linkItem "ItemGPS";
_soldier linkItem "ItemRadio";
_soldier linkItem "ItemCompass";
_soldier addHeadgear "H_HelmetO_ViperSP_ghex_F";
_soldier addVest (_vestTypes call BIS_fnc_selectRandom);
[_soldier, _weaponTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;

_soldier spawn refillPrimaryAmmo;
_soldier call setMissionSkill;

_soldier addEventHandler ["Killed", server_playerDied];

_soldier
