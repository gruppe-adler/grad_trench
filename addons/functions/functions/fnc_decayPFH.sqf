#include "script_component.hpp"
/*
 * Author: Salbei
 * Starts removing trenches after a given time
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Timeout To Decay <NUMBER>
 * 2: Decay Time <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [TrenchObj, 7200, 1800] call grad_trenches_functions_fnc_decayPFH;
 *
 * Public: No
 */

params ["_trench", ["_timeoutToDecay", 7200], ["_decayTime", 1800]];

if (
	!isServer ||
	{isNull _trench} ||
	{!GVAR(allowTrenchDecay)}
) exitWith {};

if (isNil QGVAR(decayArray)) then {
	GVAR(decayArray) = [[_trench, _timeoutToDecay, _decayTime, _decayTime]];
} else {
	GVAR(decayArray) pushBack [_trench, _timeoutToDecay, _decayTime, _decayTime];
};

if (isNil QGVAR(decayPFH)) then {
	GVAR(decayPFH) = [{

		if (GVAR(decayArray) isEqualTo []) exitWith {
			[GVAR(decayPFH)] call CBA_fnc_removePerframeHandler;
			GVAR(decayPFH) = nil;
		};

		private _newArray = [];

		{
			_x params ["_trench", "_timeoutToDecay", "_decayTime", "_decayTimeMax"];

			if (count (_trench getVariable [QGVAR(diggers),[]]) >= 1) then {
				_newArray pushBack [_trench, _timeoutToDecay, _decayTime, _decayTimeMax];
			} else {
				if !(isNull _trench) then {
					if (_timeoutToDecay <= 10) then {
						_timeoutToDecay = 0;
						if (_decayTime <= 10) then {
							_decayTime = 0;
						} else {
							_decayTime = _decayTime - 10;
						};

						private _progress = _trench getVariable ["ace_trenches_progress", 0];	
						_progress = _progress - (1 / (((_decayTimeMax - (_decayTimeMax - _decayTime)) * _decayTime)/ 10));

						if (
							_progress <= 0 || 
							{_decayTime <= 0}
						) then {
							deleteVehicle _trench;
						} else {
							[_trench, _progress, 1] call FUNC(setTrenchProgress);

							_newArray pushBack [_trench, _timeoutToDecay, _decayTime, _decayTimeMax];
						};
					} else {
						_timeoutToDecay = _timeoutToDecay - 10;
						_newArray pushBack [_trench, _timeoutToDecay, _decayTime, _decayTimeMax];
					};
				};
			};
		}forEach GVAR(decayArray);

		GVAR(decayArray) = _newArray;
	}, 10, []] call CBA_fnc_addPerFrameHandler;
};