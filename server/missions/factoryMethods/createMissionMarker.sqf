//	@file Name: createMissionMarker.sqf
//	@file Author: AgentRev, [IT42O] MjDoc


private ["_text", "_pos", "_marker", "_marker2", "_marker3"];

_text = _this select 0;
_pos = _this select 1;


_marker = format ["mission_%1_%2", [_text] call fn_filterString, call A3W_fnc_generateKey];



_marker = createMarker [_marker, _pos];

_marker setMarkerType "selector_selectedMission";

_marker setMarkerSize [0.93, 0.93];

_marker setMarkerColor "ColorRed";

_marker setMarkerText _text;

_marker
