_Fltr = param[0,"",["",[]]];

//[Classname, FANDOM rip(Or your own if you have the time)]

if (_Fltr isEqualTo "") exitWith {"WRONG DATATYPE FOR FLTR"};

_Ret = "";

_Txts = 
[
    ["arifle_Mk20_F","The Mk20 is a gas operated, selective-fire assault rifle that is chambered to fire the 5.56×45 mm NATO round. It loads from 30 round STANAG magazines and can attain a rate of fire of up to roughly ~857 rounds per minute, with a muzzle velocity of 900 m/s. The top and side rails support being mounted with accessories, while the muzzle can also be fitted with attachments. The Mk20 serves as the standard issue service weapon of the AAF, and is also used by FIA marksmen as a stand-in for heavier battle rifles. Similar to the TRG-21 used by the FIA, it is also a bullpup rifle that that is ideal for use in both short-medium ranged firefights due to its compact layout. Compared to the TRG-21, the Mk20's recoil is easier to manage (for a 5.56 mm weapon) and has a much higher rate of fire of 857 rounds per minute versus the TRG's 750. But just like the TRG-21, the Mk20's usage of 5.56 mm ammunition means that it pales in terms of performance compared to other assault rifles that are chambered in larger calibres, such as the MX series which fires the 6.5 mm round. As a result, while the Mk20 does have a higher muzzle velocity, it does somewhat less damage due to its smaller calibre. Both the weapon and its magazines are lighter to carry as well, but it also means that the operator needs to expend more ammunition in order to take down an armoured target."],
    []
];

if (_Fltr isEqualType "") then
{
    if !(isNil {(_Txts select {_Fltr in _x}) param[0] param[1]}) then
	{
        _Ret = (_Txts select {_Fltr in _x}) param[0] param[1];
    };		
}
else
{
    if !(isNil {_Txts select {(_x param[0]) in _Fltr}}) then
	{
        _Ret = _Txts select {(_x param[0]) in _Fltr};
	};
};

_Ret