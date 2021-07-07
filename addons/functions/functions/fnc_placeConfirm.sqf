#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support and esteldunedain
 * Confirms trench dig
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call grad_trenches_functions_fnc_placeConfirm
 *
 * Public: No
 */

params ["_unit"];

// enable running again
[_unit, "forceWalk", "ACE_Trenches", false] call ace_common_fnc_statusEffect_set;
[_unit, "blockThrow", "ACE_Trenches", false] call ace_common_fnc_statusEffect_set;

// remove dig pfh
[ace_trenches_digPFH] call CBA_fnc_removePerFrameHandler;
ace_trenches_digPFH = -1;

// remove mouse button actions
call ace_interaction_fnc_hideMouseHint;

[_unit, "DefaultAction", _unit getVariable ["ace_trenches_Dig", -1]] call ace_common_fnc_removeActionEventHandler;
_unit setVariable ["ace_trenches_isPlacing", false, true];

// Delete placement dummy and create real trench
if (isNull ace_trenches_trench) exitWith {};

//Get the placment data and other important values from the preview trench
private _trenchClass = typeOf ace_trenches_trench;
private _posDiff = [configFile >> "CfgVehicles" >> _trenchClass >> QGVAR(offset), "NUMBER", 2] call CBA_fnc_getConfigEntry;
private _pos = ace_trenches_trench modelToWorldWorld [0,0,0];
private _vecDirAndUp = [(vectorDir ace_trenches_trench), (vectorUp ace_trenches_trench)];

//Delete preview trench
deleteVehicle ace_trenches_trench;

[QGVAR(spawnTrench), [_trenchClass, _posDiff, _pos, _vecDirAndUp, _unit]] call CBA_fnc_serverEvent;
