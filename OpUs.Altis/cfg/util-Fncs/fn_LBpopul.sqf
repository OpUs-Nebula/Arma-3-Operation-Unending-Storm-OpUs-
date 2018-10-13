disableSerialization;
params["_Desc","_Txt"];

_Bool = param[2,true,[false]];
_Wdh  = param[3,30,[0]];

if (_Bool) then
{
    lbClear _Desc;
};

_Splt = _Txt splitString " ";

_RowCnt = 0;
_AddRow = [];
//35 char seems like secure nr, within borders. + 1 in rowcnt includes added space from spacebar.
{
        if ((_RowCnt >= 0) && ((_RowCnt + ((count _x) + 1)) < _Wdh)) then
	    {
	        _AddRow append [_x];
	    	_RowCnt = _RowCnt + ((count _x) + 1);
			if (((count _Splt) - (_foreachindex + 1)) == 0) then
			{
                _FinRow = _AddRow joinString " ";
                _Desc lbAdd (_FinRow);				
			};
	    }
	    else
	    {
	        _FinRow = _AddRow joinString " ";
            _Desc lbAdd (_FinRow);
	    	_AddRow = [];
	    	
	    	_AddRow append [_x];
			_RowCnt = 0 + ((count _x) + 1);
			if (((count _Splt) - (_foreachindex + 1)) == 0) then
			{
                _FinRow = _AddRow joinString " ";
                _Desc lbAdd (_FinRow);				
			};
	    };
} forEach _Splt;