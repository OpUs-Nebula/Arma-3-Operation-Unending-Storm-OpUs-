params ["_Fort","_Supplies","_Nat"];


//Happy note: Can most likely convert this with ease into general script for Objectives aswell, with
//Param defining source of resource, if base etc.
//Max: 5000 steel, 4000 oil, 3000 wood for lvl 3.
//StkPl = StockPile

_Lvl3 = ["Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V4_F"];

if ((typeOf _Fort) in _Lvl3) then 
{
    _Wood  = [];
	_Steel = [];
	_Oil   = [];
	_StkPl = [];
	
	_Recs  = [_Wood,_Steel,_Oil,_StkPl];
	_Flt   = ["Land_WoodPile_F","Land_Pipes_small_F","FlexibleTank_01_sand_F"];
	
	_Comp = 
	{
	    params ["_Type"];
		_Fort getVariable _Type;
	};
	
	diag_Log "Condition to be Checked";
    while { Alive _Fort } do 
	{
	     diag_Log "Loop start";
	    {
		    if !(isNil { [_x] call _Comp }) then 
			{
			    diag_Log format ["Checking %1",_x];
				 
			    _Cnt = floor ((([_x] call _Comp) param[0]) / 1000);
			    _Ind = "";
				
			    switch (_x) do
                {
			       case "Wood": {_Ind = 0;};
				   case "Steel": {_Ind = 1;};
				   case "Oil": {_Ind = 2;};
//				   case "StockPile": {_Ind = 3;};
			    };			   
			    
				_OldLst = count (_Recs param[_Ind]);
		        if !(_Cnt isEqualTo _OldLst) then 
               	{
				    if (_Cnt < _OldLst) then 
					{
					    while { _Cnt < (count (_Recs param[_Ind])) } do 
						{
                            _Del = selectRandom (_Recs param[_Ind]);
                            _Loc = _Recs find _Del;
                            deleteVehicle _Del;
                            _Recs deleteAt _Loc;
                        };						
				    }
					else
					{
					    _TotPar = (count _Supplies) - 1;
					    while { (_Cnt > (count (_Recs param[_Ind]))) && (_TotPar >= 0) } do 
						{
						    
						    _Clss = _Flt param[_Ind];
							_Ent  = _Supplies param[_TotPar];
							if (_Ent param[2] isEqualTo _Clss) then 
							{
							    diag_Log format ["Checking Vehicle %1 being created",_Clss];
								
	                            _Pos  = _Fort modelToWorld (_Ent param[0]);
	                            _Dir  = (_Ent param[1]) + (getDir _Fort);
                                _Veh = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
	                            _Veh setPosATL _Pos;
	                            _Veh setDir _Dir;
	                            [_Veh,_Fort] spawn BAS_fnc_AliveHandler;
								
								_Veh enableSimulationGlobal false;
								_Veh allowDamage false;
								
								(_Recs param[_Ind]) append [_Veh];
								_TotPar = _TotPar - 1;
						    }
							else
							{
							    _TotPar = _TotPar - 1;
							};
						};
					};
				};	
		    };
		} forEach ["Wood","Steel","Oil"];   
	};
    sleep 1;
};


hint "BASE STORAGE INITIALIZED";