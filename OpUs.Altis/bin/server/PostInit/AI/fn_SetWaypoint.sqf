/*
For new curious scripters:
Why do i use param[index,defaultValue,[Array of acceptable data types]]?

only if i expect to use it in dynamic situations, in debug or other places
where im not sure if i can garantee correct input values, or for not allowing
script to fail.
*/

_Wp    = param[0];
_Type  = param[1,"",[""]];
_Spd   = param[2,"",[""]];

_Wp setWaypointType _Type;
_Wp setWaypointSpeed _Spd;
