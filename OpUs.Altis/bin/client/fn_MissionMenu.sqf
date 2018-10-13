/*
Mission Variable Data Structure:
[[Side That Can Join(East, West, Independant),[Array of missions and necessary data]]....]
It allows for multiple nations to cooperate on objective easier. Can be restricted
via placement of nation instead of side.

ex:
if (param[0] == (side player)) then
{
    code for joining mission....
}
else
{
    if (param[0] in Nations && {player getVariable "NATION" == param[0]}) then
	{
	    code for joining mission....
	}	
}
*/

createDialog "MissionMenu_Main"