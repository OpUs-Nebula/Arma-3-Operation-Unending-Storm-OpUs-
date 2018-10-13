
//Will most likely need parameter that checks if standard nat, for compatibility
//Of different nat structure. else use empty arrays for user nats for simplicity.
_Ret = "";
_Flag = compile ((missionNamespace getVariable (player getVariable "Nation")) param[8]);
_Ret = _Flag;
_Ret