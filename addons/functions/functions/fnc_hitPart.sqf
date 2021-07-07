#include "script_component.hpp"
/*
 * Author: nomisum
 * Server receives hitPart Events from Clients and calculates
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Splash Damage <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [TrenchObj, 5] call grad_trenches_functions_fnc_hitPart;
 *
 * Public: No
 */


params ["_trench", "_position", "_splashDamage"];

// send fx to clients
[QGVAR(hitFX), [vectorDir _trench, ASLToAGL (_position)]] call CBA_fnc_globalEvent;

private _progress = _trench getVariable ["ace_trenches_progress", 0];
private _multiplier = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeOf _trench) >> QGVAR(damageMultiplier)), -1];
private _globalMultiplier = missionNamespace getVariable [QGVAR(hitDecayMultiplier), 1];
private _damage = (_splashDamage*_multiplier*_globalMultiplier);
_progress = _progress - _damage;

if (_progress > 0) then {
    [_trench, _progress, 0] call FUNC(setTrenchProgress);
} else {
    [_trench, objNull] call FUNC(deleteTrench);
};
