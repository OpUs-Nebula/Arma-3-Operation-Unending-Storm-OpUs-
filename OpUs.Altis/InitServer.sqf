ConfigDB = "LocalInstanceMySQL";
InnerDB  = "opus_dev";

_result = "extDB3" callExtension "9:LOCK_STATUS";


sv_db_id = "";

if !(isNil {uiNamespace getVariable "sv_db_id"}) then {sv_db_id = uiNamespace getVariable "sv_db_id"};
 
sv_db_connected = false;
missionNamespace setVariable ["sv_db_connected",sv_db_connected,true];

if (_result == "[0]") then
{
    
    if (sv_db_id isEqualTo "") then {sv_db_id = round(random(999999)); uiNamespace setVariable ["sv_db_id",sv_db_id]};
    [ConfigDB,InnerDB] spawn DBS_fnc_Connect;
	
	/*
	Use eventHandler for update of structure states.
	Store Building positions, gdp etc in nations table, along with nations variable.
	Update States only on events.
	*/
	
	Zones = ["zones",[["worldname",str worldname],"worlds"],[]] call DBS_fnc_GetData;
	if (Zones isEqualTo "NO DATA") then
	{
	    //Resistance,BlueFor,OpFor, order matters.
		Nations = ["AAF","NATO","CSAT"];
		
		//Will most likely need bottom part of DefaultNatParam regardless,
		//But will at least store Variables on DB.
	    Nations call server_fnc_DefaultNatParams;
	
	    
	    [] spawn server_fnc_Init;
		SystemChat "Calculating Zones....";
	}
	else
	{
	    systemchat "Loading Zones from Database....";
		[Zones] spawn PI_fnc_Boot;
		Zones = Zones param[0];
		//TOOK SO LONG TO GET WORKING!!!!//
	};
}
else
{
    //["Warning: Already connected, the extDB extension might be blocked on the system"] spawn server_fnc_log;
	//["extDB3" callExtension "9:LOCK_STATUS","InitServer.sqf","InitLog",false] spawn dev_fnc_rptDump;
    //[] spawn server_fnc_SpawnMarkers;
	
	//Resistance,BlueFor,OpFor, order matters.
	Nations = ["AAF","NATO","CSAT"];
    Nations call server_fnc_DefaultNatParams;
	
    [] spawn server_fnc_Init;
};

/*
publicVariable "CountDown";

while {CountDown > -1} do {
CountDown = CountDown - 1;
publicVariable "CountDown";

sleep 1;
};
*/