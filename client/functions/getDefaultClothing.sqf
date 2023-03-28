// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: getDefaultClothing.sqf
//	@file Author: AgentRev
//	@file Created: 22/12/2013 22:04

private ["_unit", "_item", "_side", "_isSniper", "_isDiver", "_defaultVest", "_defaultHeadgear", "_result"];

_unit = _this select 0;
_item = _this select 1;

if (typeName _unit == "OBJECT") then
{
	_side = if (_unit == player) then { playerSide } else { side _unit };
	_unit = typeOf _unit;
}
else
{
	_side = _this select 2;
};

_isMedic = (["_medic_", _unit] call fn_findString != -1);
_isEngineer = (["_engineer_", _unit] call fn_findString != -1);
_isSniper = (["_sniper_", _unit] call fn_findString != -1);

_defaultVest = "V_TacVest_brn";
_defaultHeadgear = "H_HelmetB";

_result = "";

switch (_side) do
{
	case BLUFOR:
	{
		switch (true) do
		{
			case (_isMedic):
			{
				if (_item == "uniform") then { _result = "U_B_CombatUniform_mcam" };
				if (_item == "vest") then { _result = _defaultVest };
			};
			case (_isEngineer):
			{
				if (_item == "uniform") then { _result = "U_B_CombatUniform_mcam" };
				if (_item == "vest") then { _result = _defaultVest };
			};
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_B_Ghilliesuit" };
				if (_item == "vest") then { _result = _defaultVest };
			};			
			default
			{
				if (_item == "uniform") then { _result = "U_B_CombatUniform_mcam" };
				if (_item == "vest") then { _result = _defaultVest };
			};
		};

		if (_item == "headgear") then { _result = _defaultHeadgear };
	};
	case OPFOR:
	{
		switch (true) do
		{
			case (_isMedic):
			{
				if (_item == "uniform") then { _result = "U_O_CombatUniform_ocamo" };
				if (_item == "vest") then { _result = _defaultVest };
			};
			case (_isEngineer):
			{
				if (_item == "uniform") then { _result = "U_O_CombatUniform_ocamo" };
				if (_item == "vest") then { _result = _defaultVest };
			};
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_O_GhillieSuit" };
				if (_item == "vest") then { _result = _defaultVest };
			};			
			default
			{
				if (_item == "uniform") then { _result = "U_O_CombatUniform_ocamo" };
				if (_item == "vest") then { _result = _defaultVest };
			};
		};

		if (_item == "headgear") then { _result = _defaultHeadgear };
	};
	default
	{
		switch (true) do
		{
			case (_isMedic):
			{
				if (_item == "uniform") then { _result = "U_I_CombatUniform" };
				if (_item == "vest") then { _result = _defaultVest };
			};
			case (_isEngineer):
			{
				if (_item == "uniform") then { _result = "U_I_CombatUniform" };
				if (_item == "vest") then { _result = _defaultVest };
			};
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_I_GhillieSuit" };
				if (_item == "vest") then { _result = _defaultVest };
			};			
			default
			{
				if (_item == "uniform") then { _result = "U_I_CombatUniform" };
				if (_item == "vest") then { _result = _defaultVest };
			};
		};

		if (_item == "headgear") then { _result = _defaultHeadgear };
	};
};

_result
