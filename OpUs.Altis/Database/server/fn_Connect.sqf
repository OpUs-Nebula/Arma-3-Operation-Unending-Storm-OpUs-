_conDB  = param[0,"",[""]];
_nameDB = param[1,"",[""]];

_result = "extDB3" callExtension format["9:ADD_DATABASE:%1:%2",_conDB,_nameDB];
_script = "DBS_fnc_Connect";

if(_result != "[1]") then 
{
    ["Config already loaded",_script,"extDB3 config.ini DB already loaded"] spawn dev_fnc_rptDump;
    sv_db_id = uiNamespace getVariable "sv_db_id";
    _result = "extDB3" callExtension format
        ["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2:TEXT",
            _nameDB,
            (sv_db_id)
        ];

    sv_db_connected = true;
	missionNamespace setVariable ["sv_db_connected",sv_db_connected,true];
} 
else 
{
    _result = "extDB3" callExtension format
        ["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2:TEXT",
            _nameDB,
            (sv_db_id)
        ];

    if(_result != "[1]") exitWith 
	{
	    _Error = format ["Error: %1 %2", _result param[0], _result param[1]];
	    
    	["The database could not be loaded",_script,""] spawn dev_fnc_rptDump;
        ["Failed at enabling raw statements",_script,""] spawn dev_fnc_rptDump;
		[_Error, _script, "Connection Issue"] spawn dev_fnc_rptDump;
    };

    //"extDB3" callExtension "9:LOCK";
    ["No errors",_script,"",false] spawn dev_fnc_rptDump;

    sv_db_connected = true;
	missionNamespace setVariable ["sv_db_connected",sv_db_connected,true];
}; 