#include "script_component.hpp"
/*
 * Author: nomisum
 * Displaying Dig FX on Digging
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call grad_trenches_functions_fnc_digFX;
 *
 * Public: No
 */

params ["_vehicle"];

private _selections = (_vehicle selectionNames "Memory") select {(_x find "fxsource") isEqualTo 0};

{
    private _selectionName = _x;

    private _particleSource = "#particlesource" createVehicleLocal [0,0,0];
    private _position = (_vehicle modelToWorld (_vehicle selectionPosition _selectionName));
    _particleSource setPos _position;
    _particleSource setParticleParams [   
     "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",   
     1, 10, [0,0,0], [0,0,1], 1, 10, 1, 0.2, [0.05],   
     [[1, 1, 1 ,1]],   
     [0, 1], 1, 0, "", "", _particleSource, 0, true, .1];   
    _particleSource setParticleRandom [2, [0.5, 0.5, 0.1], [0.1, 0.1, 0.2], 0, 2, [0, 0, 0, 0], 0, 0];   
    _particleSource setParticleCircle [0.3, [0,0,0.3]];
    _particleSource setDropInterval 0.005;

    [{ deleteVehicle (_this select 0); }, [_particleSource], 0.1] call CBA_fnc_waitAndExecute; 
    
} forEach _selections;
