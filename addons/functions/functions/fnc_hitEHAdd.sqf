#include "script_component.hpp"
/*
 * Author: nomisum
 * Receiving and calculating Damage
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Multiplier <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, 1] remoteExec ["grad_trenches_functions_fnc_hitEHAdd"];
 *
 * Public: No
 */

params ["_trench", "_multiplier"];

if (_trench getVariable [QGVAR(hitHandler), false]) exitWith { 
    TRACE_1("hitEH","not adding hit handler, already there");
};

_trench setVariable [QGVAR(hitHandler), true];

// only fires on shooters client
_trench addEventHandler ["HitPart", {
    (_this select 0) params ["_trench", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];

    // filter locally and broadcast only when necessary
    if (!_isDirect) then {
        // add cooldown after indirect
        if (!(_trench getVariable [QGVAR(hitCoolDown),false])) then {
            _ammo params ["_hitValue", "_indirectHitValue", "_splashDamage", "", "_type"];
 
            _trench setVariable [QGVAR(hitCoolDown), true];

            [{
                params ["_trench"];

                if (!isNull _trench) then {
                    _trench setVariable [QGVAR(hitCoolDown), false];
                };

            }, [_trench], 1] call CBA_fnc_waitAndExecute;

            if (_splashDamage > 1) then {

                // larger HE shells should do way more damage than e.g. HE ammo of an APC that has higher cadency
                private _damageNormalized = ((_hitValue + _indirectHitValue + _splashDamage)/3000); // 300 is arbitrary value

                // reduce effect for grenades
                if (_projectile isKindOf "Grenade") then {
                    _damageNormalized = _damageNormalized*0.1;
                };
                [QGVAR(hitPart), [_trench, _position, _damageNormalized]] call CBA_fnc_serverEvent;
            };
        };
    };
}];