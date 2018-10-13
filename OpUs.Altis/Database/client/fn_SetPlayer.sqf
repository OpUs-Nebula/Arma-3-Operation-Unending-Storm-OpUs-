_sUID    = param[0];
_Column = param[1];
_Data   = param[2];
_Player = param[3];
_Table  = "playerinfo";

if (_sUID == "") exitwith {};

[["SteamID",_sUID],_Column,_Data,_Table] remoteExec ["DBS_fnc_SetData",2]; 
