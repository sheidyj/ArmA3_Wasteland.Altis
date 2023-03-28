//	@file Name: customGroup.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

_unitTypes =
[
	"C_Man_1_enoch_F", "C_man_polo_1_F_euro", "C_man_polo_1_F_afro", "C_man_polo_1_F_asia",
	"C_Man_2_enoch_F", "C_man_polo_2_F_euro", "C_man_polo_2_F_afro", "C_man_polo_2_F_asia",
	"C_Man_3_enoch_F", "C_man_polo_3_F_euro", "C_man_polo_3_F_afro", "C_man_polo_3_F_asia",
	"C_Man_4_enoch_F", "C_man_polo_4_F_euro", "C_man_polo_4_F_afro", "C_man_polo_4_F_asia",
	"C_Man_5_enoch_F", "C_man_polo_5_F_euro", "C_man_polo_5_F_afro", "C_man_polo_5_F_asia",
	"C_Man_6_enoch_F", "C_man_polo_6_F_euro", "C_man_polo_6_F_afro", "C_man_polo_6_F_asia"
];

for "_i" from 1 to _nbUnits do
{
	_uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;

	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	_unit addVest "V_PlateCarrierIAGL_dgtl";
	_unit addMagazine "200Rnd_65x39_cased_Box";
	_unit addMagazine "200Rnd_65x39_cased_Box";
	_unit addMagazine "200Rnd_65x39_cased_Box";
	_unit addItem "MiniGrenade";
	_unit addItem "MiniGrenade";
	_unit addItem "MiniGrenade";
	_unit linkItem "ItemGPS";
	_unit linkItem "ItemRadio";

	switch (true) do
	{
		// Grenadier every 3 units, starting from #2
		case ((_i + 4) % 3 == 0):
		{
			_unit addUniform "U_B_CTRG_Soldier_F";
			_unit addBackpack "B_Carryall_green_F";
			//_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addWeapon "LMG_Mk200_F";
			//_unit addMagazine "1Rnd_HE_Grenade_shell";
			//_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addMagazine "Vorona_HEAT";
			_unit addWeapon "launch_O_Vorona_green_F";
			_unit addMagazine "Vorona_HEAT";
			_unit addMagazine "Vorona_HEAT";
			_unit addItem "FirstAidKit";
			_unit addItem "FirstAidKit";
		};
		// PCML every 6 units, starting from #6
		case (_i % 6 == 0):
		{
			_unit addUniform "U_B_CTRG_Soldier_F";
			_unit addBackpack "B_Carryall_green_F";
			_unit addWeapon "LMG_Mk200_F";
			_unit addMagazine "NLAW_F";
			_unit addWeapon "launch_NLAW_F";
			_unit addMagazine "NLAW_F";
			_unit addMagazine "NLAW_F";
			_unit addItem "FirstAidKit";
			_unit addItem "FirstAidKit";
		};
		// RPG-42 every 6 units, starting from #3
		case ((_i + 3) % 6 == 0):
		{
			_unit addUniform "U_B_CTRG_Soldier_F";
			_unit addBackpack "B_Carryall_green_F";
			_unit addWeapon "LMG_Mk200_F";
			_unit addMagazine "RPG32_F";
			_unit addWeapon "launch_RPG32_green_F";
			_unit addMagazine "RPG32_F";
			_unit addMagazine "RPG32_F";
			_unit addItem "FirstAidKit";
			_unit addItem "FirstAidKit";
		};
		// Rifleman
		default
		{
			_unit addUniform "U_B_CTRG_Soldier_F";
			_unit addBackpack "B_Carryall_green_F";

			if (_unit == leader _group) then
			{
				_unit addWeapon "LMG_Mk200_black_F";
				_unit addMagazine "Titan_AA";
				_unit addWeapon "launch_I_Titan_eaf_F";
				_unit addMagazine "Titan_AA";
				_unit addMagazine "Titan_AA";
				_unit setRank "SERGEANT";
				_unit addItem "FirstAidKit";
				_unit addItem "FirstAidKit";
			}
			else
			{
				_unit addWeapon "LMG_Mk200_black_F";
				_unit addMagazine "Titan_AA";
				_unit addWeapon "launch_I_Titan_eaf_F";
				_unit addMagazine "Titan_AA";
				_unit addMagazine "Titan_AA";
				_unit addItem "FirstAidKit";
				_unit addItem "FirstAidKit";
			};
		};
	};

	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit enablegunlights "Auto";
	_unit addPrimaryWeaponItem "optic_MRCO";

	_unit addRating 1e11;
	_unit spawn addMilCap;
	_unit spawn refillPrimaryAmmo;
	_unit call setMissionSkill;
	_unit addEventHandler ["Killed", server_playerDied];
};

[_group, _pos] call defendArea;
