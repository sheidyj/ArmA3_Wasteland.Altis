// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupStart.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private "_player";
_player = _this;

_player setSkill 0;
//{_player disableAI _x} foreach ["move","anim","target","autotarget"];
_player setVariable ["BIS_noCoreConversations", true];
_player setVariable ["A3W_corpseEjected", nil, true];
_player allowDamage false;
[_player, true] call fn_hideObjectGlobal;
//_player enableSimulation false;

if (["A3W_unlimitedStamina"] call isConfigOn) then
{
	_player enableFatigue false;
	_player enableStamina false;
};

enableSentences false;

_player enableFatigue false; // disable player fatigue (no fatigue)
_player enableStamina false; // disable player stamina (unlimited stamina)

_player setCustomAimCoef 0.1; // drastically reduce weapon sway
_player addEventhandler ["Respawn", {_player setCustomAimCoef 0.1;}];  // drastically reduce weapon sway upon respawn

removeAllWeapons _player;
removeUniform _player;
removeVest _player;
removeBackpack _player;
removeGoggles _player;
removeHeadgear _player;
