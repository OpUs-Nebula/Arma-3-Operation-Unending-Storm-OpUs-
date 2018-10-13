_Nat  = param[0,"",[""]];
_Fltr = param[1,"",[[],""]];
_WpnArr  = param[2,"",[[]]];

//Each Equipment tier has String with TierName, and integer with nr of tier slots it occupies.
//To use said weapons, each tier needs to be in players TierKit. Else weapons in it cannot be
//Used by player. How many tiers each player can use in their TierKit is determined in Description.ext
//2 slot max by default.

//Classes will allow for Ammo Bearer(Higher stamina)/Medic/Engineer/Recon(Higher camocoefficnet), not tiers.
//might be limited by occupied tiers though. 
//structure: [DisplayName,Image(optional),integer];
//ItemParams: [Classname,Cost,Category]
//Template: [["SniperRifle",["Variant1","price1"...],],[["Ammo1","Price1"],["Ammo2","Price2"]....["AmmoN","PriceN"]],"12K","Primary",Required Level(Int)]
//Ex: [["FN2000"],["5.56","20§"],"2.7k","Primary",1];
//if only one ammo exists, with empty ammo classname, but only price, config rip of all compatible mags
//Will be used, with price1 as price for all.
//Only variants needed, if price == "" then standard price will be used.
//Categories: Primary,Secondary,Vest,Uniform,Backpack,Special
//Use external leveling for access to Rifleman, Marksman as param etc, instead of putting in variables here.

//Commons Mag Array: ["MagazineClass","Price","Category",Required Level(int)],

//Use "ALL"(Case-Sensitive) for using same price for all compatible mags for weapon available ingame,
//That have not been defined in commons using above mentioned template.

//["Category","Image"]

//Conflicts: Dont use ConfigRip and TBI "ALL" nation call, will yield unreliable output
//as not all common arrays will get magazines added to them.
//Alt disabling of magrip when nation == "ALL"

//Store Active Tiers in CurrentLoadout in playerinfo DB, for Arsenal/WeaponEH to
//Detect allowed weapons/Equipment reliably.
/*
_Cats = 
		[["Primary",""],
		["Secondary",""],
		["Launcher",""],
		["Uniform",""],
		["Vest",""],
		["Backpack",""],
		["Items",""]
		["Attachments",""],
		["Magazines",""]];
*/
_CfgArray = "";
_RipInt   = ["NebsMagRip",0] call BIS_fnc_getParamValue;

if (_RipInt isEqualTo 1) then
{
    _cfgArray = 
    '(
        !(configName _x isKindOf ["VehicleMagazine",configFile >> "CfgMagazines"])
    	&&
    	(
    	    (configName _x isKindOf ["CA_Magazine",configFile >> "CfgMagazines"])
    		&&
    		!(
    		    (ConfigName _x == "CA_Magazine") or (ConfigName _x == "CA_LauncherMagazine")
    		)
    	)
    )'
    configClasses
    (ConfigFile >> "CfgMagazines");
    
    _MgRip = [];
    
	//Can be adjusted for more/less expensive magazines
    _Const = 2.466;
     
    {
        _Mass = getNumber (configFile >> "CfgMagazines" >> (configName _x) >> "Mass");
    	_MgCnt = getNumber (configFile >> "CfgMagazines" >> (configName _x) >> "Count");
    	_Price = floor ((_Const * _Mass) + ln _MgCnt);
    	
    	_CfgArray set [_ForEachIndex,[[configName _x],[],str _Price,"Magazines",0]];
    } forEach _cfgArray;
}; 

_Ret = "";
_Dta = [];

//NATION ARMORYS
if (_Nat == "AAF" or _Nat == "ALL") then
{
    _Cmmn = 
	[
	    ["Common","",0],
	    [
		    [["U_I_CombatUniform"],[],"100","Uniform",0],
			[["H_HelmetIA"],[],"20","Uniform",0],
			[["H_HelmetIA_camo"],[],"20","Uniform",0],
			[["B_AssaultPack_dgtl"],[],"70","Backpack",0],
			[["U_I_CombatUniform_shortsleeve"],[],"20","Uniform",0],
		    [["V_PlateCarrierIA1_dgtl"],[],"600","Vest",0],
            [["V_PlateCarrierIA2_dgtl"],[],"1.1k","Vest",0],
			[["NVGoggles_INDEP"],[],"700","Items",0],
			[["FirstAidKit"],[],"67","Items",0],
			[["ItemWatch"],[],"79","Items",0],
			[["ItemCompass"],[],"18","Items",0],
			[["ItemGPS"],[],"1.4k","Items",0],
			[["ItemRadio"],[],"79","Items",0],
			[["ItemMap"],[],"10","Items",0],
			[["Binocular"],[],"100","Items",0],
			[["ToolKit"],[],"35","Items",0]	
		]
	];
    _Dta append [_Cmmn];
	
    _Rflmn = 
	[   
	    ["Rifleman","",1],
	    [
		    [["arifle_Mk20_F"],[],"2.7k","Primary",1],
	        [["srifle_EBR_F"],[],"7.8k","Primary",1],
			[["hgun_PDW2000_F"],[],"1.1k","Primary",1],
			[["hgun_ACPC2_F"],[],"900","Secondary",1],
			[["optic_MRCO"],[],"1k","Attachments",1],
			[["acc_flashlight"],[],"300","Attachments",1],
			[["optic_Holosight"],[],"500","Attachments",1]
	    ]
	];
	_Dta append [_Rflmn];
	
	_Auto = 
	[
	    ["AutoRifleman","",1],
	    []
	];
	_Dta append [_Auto];
	
	_Mrksmn = 
	[   
	    ["Marksman","",1],
	    []
	];
	_Dta append [_Mrksmn];
	
	_AT = 
	[
	    ["AT","",1],
	    []
	];
	_Dta append [_AT];
	
	_HeavyGunner = 
	[
	    ["Heavy Gunner","",2],
	    []
	];
	_Dta append [_HeavyGunner];
	
	_Sniper = 
	[
	    ["Sniper","",2],
	    []
	];
	_Dta append [_Sniper];
};
if (_Nat == "NATO" or _Nat == "ALL") then
{
    _Cmmn = 
	[
	    ["Common","",0],
	    [
		    [["U_B_CombatUniform_mcam"],[],"130","Uniform",0],
			[["U_B_CombatUniform_mcam_tshirt"],[],"130","Uniform",0],
			[["V_PlateCarrier1_rgr"],[],"900","Vest",0],
			[["V_PlateCarrier2_rgr"],[],"1.6k","Vest",0],
			[["V_PlateCarrier2_blk"],[],"1.6k","Vest",0],
			[["H_HelmetB"],[],"50","Uniform",0],
			[["H_HelmetB_light"],[],"20","Uniform",0],
			[["B_AssaultPack_rgr"],[],"70","Backpack",0],
			[["B_AssaultPack_mcamo"],[],"70","Backpack",0],
			[["B_TacticalPack_rgr"],[],"130","Backpack",0],
			[["B_TacticalPack_mcamo"],[],"130","Backpack",0],
			[["FirstAidKit"],[],"67","Items",0],
			[["ItemWatch"],[],"79","Items",0],
			[["ItemCompass"],[],"18","Items",0],
			[["ItemGPS"],[],"1.4k","Items",0],
			[["ItemRadio"],[],"79","Items",0],
			[["ItemMap"],[],"10","Items",0],
			[["Binocular"],[],"100","Items",0],
			[["ToolKit"],[],"35","Items",0]	
		]
	];
    _Dta append [_Cmmn];
	
    _Rflmn = 
	[   
	    ["Rifleman","",1],
	    [
		    [["arifle_MX_F"],[],"4.2k","Primary",1],
	        [["srifle_DMR_03_F"],[],"8.9k","Primary",1],
	        [["arifle_SPAR_01_blk_F"],[],"3k","Primary",1],
			[["arifle_SPAR_01_snd_F"],[],"3k","Primary",1],
			[["acc_flashlight"],[],"300","Attachments",1],
			[["optic_Hamr"],[],"1.2k","Attachments",1],
			[["optic_ACO"],[],"800","Attachments",1]
	    ]
	];
	_Dta append [_Rflmn];
	
	_Auto = 
	[
	    ["AutoRifleman","",1],
	    []
	];
	_Dta append [_Auto];
	
	_Mrksmn = 
	[   
	    ["Marksman","",1],
	    []
	];
	_Dta append [_Mrksmn];
	
	_AT = 
	[
	    ["AT","",1],
	    []
	];
	_Dta append [_AT];
	
	_HeavyGunner = 
	[
	    ["Heavy Gunner","",2],
	    []
	];
	_Dta append [_HeavyGunner];
	
	_Sniper = 
	[
	    ["Sniper","",2],
	    []
	];
	_Dta append [_Sniper];
};
if (_Nat == "CSAT" or _Nat == "ALL") then
{
    _Cmmn = 
	[
	    ["Common","",0],
	    [
			[["V_TacVest_brn"],[],"600","Vest",0],
		    [["V_HarnessO_brn"],[],"350","Vest",0],
			[["H_HelmetLeaderO_ocamo"],[],"190","Uniform",0],
			[["H_HelmetO_ocamo"],[],"100","Uniform",0],
		    [["U_O_CombatUniform_ocamo"],[],"1.2k","Uniform",0],
			[["B_TacticalPack_ocamo"],[],"130","Backpack",0],
		    [["B_AssaultPack_khk"],[],"70","Backpack",0],
			[["B_FieldPack_cbr_HAT"],[],"40","Backpack",0],
			[["FirstAidKit"],[],"67","Items",0],
			[["ItemWatch"],[],"79","Items",0],
			[["ItemCompass"],[],"18","Items",0],
			[["ItemGPS"],[],"1.4k","Items",0],
			[["ItemRadio"],[],"79","Items",0],
			[["ItemMap"],[],"10","Items",0],
			[["Binocular"],[],"100","Items",0],
			[["ToolKit"],[],"35","Items",0]	
		]
	];
    _Dta append [_Cmmn];
	
    _Rflmn = 
	[   
	    ["Rifleman","",1],
	    [
		    [["arifle_Katiba_F"],[],"3.9k","Primary",1],
	        [["srifle_DMR_01_F"],[],"6.8k","Primary",1],
	        [["hgun_P07_F"],[],"1.2k","Secondary",1],
			[["arifle_CTAR_blk_F"],[],"2.8k","Primary",1],
			[["SMG_02_F"],[],"1.6k","Primary",1],
			[["optic_ACO_grn"],[],"800","Attachments",1],
			[["optic_Arco"],[],"1.4k","Attachments",1],
			[["acc_flashlight"],[],"300","Attachments",1],
			[["optic_Arco_blk_F"],[],"1.4k","Attachments",1]
	    ]
	];
	_Dta append [_Rflmn];
	
	_Auto = 
	[
	    ["AutoRifleman","",1],
	    []
	];
	_Dta append [_Auto];
	
	_Mrksmn = 
	[   
	    ["Marksman","",1],
	    []
	];
	_Dta append [_Mrksmn];
	
	_AT = 
	[
	    ["AT","",1],
	    []
	];
	_Dta append [_AT];
	
	_HeavyGunner = 
	[
	    ["Heavy Gunner","",2],
	    []
	];
	_Dta append [_HeavyGunner];
	
	_Sniper = 
	[
	    ["Sniper","",2],
	    []
	];
	_Dta append [_Sniper];
};
if (_Nat == "ALL") then
{
    _tmp = [];
    {
	    _Main = _x;
	    _Tag  = _x param[0];

	    if !(count (_tmp select {_Tag in _x}) > 0) then
        {
		    _tmp append [_Main];
        }
		else
		{
		    ((_tmp select {(_Tag in _x) && !(_Main isEqualTo _x)}) param[0] param[1]) append (_Main param[1]);
		};
	} forEach _Dta;
	_Dta = _tmp;
};

//-------------CONFIGRIP START------------//
//Note: Dont use if all nations are gathered at once. will break magrip functionality,
//as it relies on only one "Commons" tier array being present.
//Else, All Nations Variable could induce combination of all arrays under the same category.(Most likely implimentation) 

if !(_CfgArray isEqualTo "") then
{
    _Cmmns = (_Dta select {(_x param[0] param[0]) == "Common"}) param[0];
    (_Cmmns param[1]) append (_CfgArray select 
	{
	    _Mag = _x param[0] param[0];
	    count (_Dta select 
		{
		    count ((_x param[1]) select 
			{
			    if !(isNil {_x param[0] param[0]}) then
				{
			        _Wp = (_x param[0] param[0]);
			        _Mag in (getArray (configFile >> "CfgWeapons" >> _Wp >> "Magazines"))
				}
				else
				{
				    false
				}
			}) > 0      
		}) > 0
	}); 
};
//-------------CONFIGRIP END--------------//

//End of script, combining and formatting output
//Array with tiers as input for first condition
if !(_Fltr isEqualType "") then
{
	_Ret = _Dta select {(_x param[0] param[0]) in _Fltr};
}
else
{
    if !(_WpnArr isEqualTo "") then
	{
	    _Wpns = [];
		{
		    _Wpns append ((_x param[1]) select 
			{
			    if !(isNil {_x param[0] param[0]}) then
				{
			        _Wepn = _x param[0] param[0];				
			        (_Wepn in _WpnArr) 
			        or 
			        (count (_WpnArr select {_x in (getArray (configFile >> "CfgWeapons" >> _Wepn >> "Magazines"))} ) > 0)
				}
				else
				{
				    false
				}
			});
		} forEach _Dta;
		
		_Cmmn = (_Dta select {(_x param[0] param[0]) == "Common"}) param[0];
		
		{
		    _Wepn = _x param[0] param[0];
		    _AmmoArr = _x param[1];
			if (_AmmoArr param[0] isEqualTo "ALL") then
			{
			    _Price = _AmmoArr param[1];		
			    _Prep  = getArray (configFile >> "CfgWeapons" >> _Wepn >> "Magazines");
			
			    {
				    _SetP = _Price;
					_Mag = _x;
				    if (count (_Cmmn select {_Mag in _x}) > 0) then
					{
					    _SetP = (_Cmmn select {_Mag in _x}) param[0] param[1];
					};
				    _Prep set [_foreachindex,[_Mag,_SetP]];
				} forEach _Prep;
				_AmmoArr resize 0;
				_AmmoArr append _Prep;
			};
		} forEach _Wpns;
		_Ret = _Wpns;
	}
	else
	{
        _Ret = _Dta;
	};
};

_Ret