#include "script_component.hpp"
/*
 * Author: nomisum
 * Displaying Destruction FX on Impact
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Position <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, [worldSize/2, worldsize/2]] call grad_trenches_functions_fnc_hitFX;
 *
 * Public: No
 */

 params ["_vectorDir", "_position"];

private _vectorDir = _vectorDir vectorMultiply 1;
private _ps1 = "#particlesource" createVehicleLocal [0,0,0]; 
_ps1 setPos _position;
_ps1 setParticleParams [   
 "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",   
 1, 10, [0,0,0], _vectorDir, 1, 10, 1, 0.2, [0.1, 0.1],   
 [[1, 1, 1 ,1]],   
 [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
_ps1 setParticleRandom [2, [4, 4, 4], [2, 2, 4], 0, 1, [0, 0, 0, 0], 0, 0];
_ps1 setDropInterval 0.001;  
[{ deleteVehicle (_this select 0); }, [_ps1], 0.1] call CBA_fnc_waitAndExecute; 