#include "script_component.hpp"
/*
* Author: nomisum
* Animates a trench to correct progress position. Always instant.
*
* Arguments:
* 0: Trench <OBJECT>
* 1: Progress <NUMBER 0-1>
* 2: Duration <NUMBER 0-1>
*
* Return Value:
* None
*
* Example:
* [TrenchObj, 0.5] call grad_trenches_functions_fnc_setTrenchProgress
*
* Public: No
*/

params ["_trench", "_progress", ["_animationSpeedMultiplier", 0]];

private _offset = [configFile >> "CfgVehicles" >> typeOf _trench >> QGVAR(offset), "NUMBER", 2] call CBA_fnc_getConfigEntry;

private _lift = (linearConversion 
    [0, 1, 
    _progress, 
    -_offset, 
    0,
    true
    ]);

if (_animationSpeedMultiplier > 0) then {
    _trench animateSource ["rise", _lift, _animationSpeedMultiplier];
} else {
    _trench animateSource ["rise", _lift, true];
};

_trench setVariable ["ace_trenches_progress", _progress, true];

TRACE_4("_lift: %1, _offset: %2, _position: %3, _progress: %4", _lift, _offset, getpos _trench, _progress);
