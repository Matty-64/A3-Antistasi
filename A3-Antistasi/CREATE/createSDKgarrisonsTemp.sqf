_markerX = _this select 0;
_tipo = _this select 1;
_positionX = getMarkerPos _markerX;
if (_tipo isEqualType "") then
	{
	_grupos = if (_tipo == staticCrewTeamPlayer) then {[]} else {allGroups select {(leader _x getVariable ["markerX",""] == _markerX) and (count units _x < 8) and (vehicle (leader _x) == leader _x)}};
	_grupo = if (_grupos isEqualTo []) then
		{
		createGroup buenos
		}
	else
		{
		_grupos select 0;
		};
	_unit = _grupo createUnit [_tipo, _positionX, [], 0, "NONE"];
	//if (_tipo in SDKSL) then {_grupo selectLeader _unit};
	[_unit,_markerX] call A3A_fnc_FIAinitBases;
	if (_tipo == staticCrewTeamPlayer) then
		{
		private _veh = SDKMortar createVehicle _positionX;
		_nul=[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
		_unit assignAsGunner _veh;
		_unit moveInGunner _veh;
		[_veh] call A3A_fnc_AIVEHinit;
		};
	if (_grupos isEqualTo []) then
		{
		_nul = [leader _grupo, _markerX, "SAFE","SPAWNED","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		};
	[_unit,_markerX] spawn
		{
		private _unit = _this select 0;
		private _markerX = _this select 1;
		waitUntil {sleep 1; (spawner getVariable _markerX == 2)};
		if (alive _unit) then
			{
			private _grupo = group _unit;
			if (typeOf _unit == staticCrewTeamPlayer) then {deleteVehicle (vehicle _unit)};
			deleteVehicle _unit;
			if (count units _grupo == 0) then {deleteGroup _grupo};
			};
		};
	};