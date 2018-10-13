
params ["_Veh","_Occup","_Id"];

if ((typeOf _Veh) isEqualTo "Land_DataTerminal_01_F") then 
{ 
    [ 
        _Veh,                                                                            
        "Upload Intel",                                                                       
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                      
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                       
        "_this distance _target < 3",                                                         
        "_caller distance _target < 3",                                                      
        {[_target, 3] call BIS_fnc_DataTerminalAnimate; hint "Uploading..."},                                                                                   
        {},                                                                                   
        {[_target, 0] call BIS_fnc_DataTerminalAnimate; hint "Intel Uploaded!";},                                                
        {
		    [_target, 0] call BIS_fnc_DataTerminalAnimate; 
		     hint "Upload Interrupted";
			 sleep 1;
			 deleteVehicle _target;
		},                                                                                   
        [],                                                                                   
        12,                                                                                   
        0,                                                                                    
        true,                                                                                 
        false                                                                                 
    ] remoteExec ["BIS_fnc_holdActionAdd",0,_Veh];
} 
else 
{
    [ 
        _Veh,                                                                     
        "Gather Intel",                                                           
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",           
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",           
        "_this distance _target < 3",                                             
        "_caller distance _target < 3",                                           
        {hint "Searching...";},                          
        {},                                                                       
        {
		    hint "Intel Found!";
			deleteVehicle _target;
		},                          
        {hint "Search Interrupted";},
        [],                                                                       
        2,                                                                       
        0,                                                                        
        true,                                                                     
        false                                                                     
    ] remoteExec ["BIS_fnc_holdActionAdd",0,_Veh];
};