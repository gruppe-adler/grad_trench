#include "script_component.hpp"

if (isServer) then {
    [QGVAR(addDigger), {_this call FUNC(addDigger);}] call CBA_fnc_addEventHandler;
    [QGVAR(handleDiggerToGVAR), {_this call FUNC(handleDiggerToGVAR);}] call CBA_fnc_addEventHandler;
    [QGVAR(addTrenchToDecay), {_this call FUNC(decayPFH);}] call CBA_fnc_addEventHandler;
    [QGVAR(resetDecay), {_this call FUNC(resetDecay);}] call CBA_fnc_addEventHandler;
    [QGVAR(hitPart), {_this call FUNC(hitPart);}] call CBA_fnc_addEventHandler;
    [QGVAR(hitEHAdd), {_this call FUNC(hitEHAdd);}] call CBA_fnc_addEventHandler;
    [QGVAR(spawnTrench), {_this call FUNC(spawnTrench);}] call CBA_fnc_addEventHandler;

    // add hit EH to preplaced trenches
    {
        // hitpart is local args, so must be applied everywhere
        if (GVAR(allowHitDecay)) then {
            [QGVAR(hitEHAdd), [_object, GVAR(hitDecayMultiplier)]] call CBA_fnc_globalEventJIP;
        };
    } forEach (entities "ACE_envelope_small");
};

if (hasInterface) then {
    [QGVAR(hitFX), {_this call FUNC(hitFX);}] call CBA_fnc_addEventHandler;
    [QGVAR(applyFatigue), {_this call FUNC(applyFatigue);}] call CBA_fnc_addEventHandler;
    [QGVAR(digFX), {_this call FUNC(digFX);}] call CBA_fnc_addEventHandler;
    [QGVAR(hitEHAdd), {_this call FUNC(hitEHAdd);}] call CBA_fnc_addEventHandler;
    [QGVAR(continueDiggingTrench), {_this call FUNC(continueDiggingTrench);}] call CBA_fnc_addEventHandler;
};
