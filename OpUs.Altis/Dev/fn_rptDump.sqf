/*--------------------------------------------------------------------------------
    example: [_Data,_Root,_Info,true] call DEV_fnc_rptDump
	
	PARAMETERS:
	0: Useful data related to error, exception, logged script task, such as unit type, positon etc.
	1: Logged script name and or location
	2: Intended function, resulting function.
	3: False if Log, true if Error.

--------------------------------------------------------------------------------*/


_Data = param[0,"Unknown Error",[[],""]];
_Root = param[1,"Undefined Path",[""]];
_Info = param[2,"No Info Provided",[""]];
_Bool = param[3,true,[true]];
_Hint = param[4,true,[true]];

if (_Bool) then 
{
    _Error = format ["[!!^------------------OpUs ERROR HANDLER------------------^!!] Info: %2, Data: %1 Script: %3",_Data,_Info,_Root];
    diag_log _Error;
//    copyToClipboard _Error;
    if (_Hint) then {hint format ["An error occured in %1, check ClipBoard and RPT",_Root]};
}
else
{
    _Log = format ["[-------<>{OpUs__Script__Dump}</>-------] Info: %2, Data: %1 Script: %3",_Data,_Info,_Root];
    diag_log _Log;
};