params ["_Nat"];

private ["_Uni",     
        "_SecAmmo",
        "_Grends",
        "_PrimAmmo",
        "_BkPak",
        "_LnchrAmmo",
        "_PrimWpn",
        "_PrimAttch",
        "_Lnchr",
        "_Second",
        "_Bino",
        "_Links",
        "_Insig",
        "_Helm",
        "_Goggl",
		"_Vest"];
_Ret = "";
		
if (_Nat isEqualTo "AAF") then 
{
    _RflMn = 
    ["U_I_CombatUniform",
     "9Rnd_45ACP_Mag",
     ["HandGrenade","HandGrenade"],
	 "30Rnd_556x45_Stanag",
	 "",
	 "",
	 "arifle_Mk20_F",
	 ["acc_pointer_IR","optic_MRCO"],
	 "",
	 "hgun_ACPC2_F",
	 "Binocular",
	 ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles_INDEP"],
	 "AAF_3rdRegiment",
	 "H_HelmetIA",
	 "",
	 "V_PlateCarrierIA1_dgtl"];
	 
	 _SFrfl =
	 ["U_I_CombatUniform",
     "9Rnd_45ACP_Mag",
     ["MiniGrenade","SmokeShell"],
	 "20Rnd_762x51_Mag",
	 "B_AssaultPack_dgtl",
	 "",
	 "srifle_EBR_F",
	 ["acc_pointer_IR","optic_MRCO","bipod_03_F_blk","muzzle_snds_B"],
	 "",
	 "hgun_ACPC2_F",
	 "Rangefinder",
	 ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles_INDEP"],
	 "AAF_3rdRegiment",
	 "H_HelmetIA",
	 "G_Balaclava_blk",
	 "V_PlateCarrierIAGL_dgtl"];
	 
	 _Staff  =
	 ["U_I_CombatUniform",
     "9Rnd_45ACP_Mag",
     ["",""],
	 "",
	 "",
	 "",
	 "",
	 [],
	 "",
	 "hgun_ACPC2_F",
	 "",
	 ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS",""],
	 "AAF_3rdRegiment",
	 "H_MilCap_dgtl",
	 "",
	 ""];
	 
	_Ret = [[_RflMn,_SFrfl],_Staff];
};

if (_Nat isEqualTo "CSAT") then
{
    _RflMn = 
    ["U_O_CombatUniform_ocamo",
	 "16Rnd_9x21_Mag",
	 ["HandGrenade","HandGrenade"],
	 "30Rnd_65x39_caseless_green",
	 "",
	 "",
	 "arifle_Katiba_F",
	 ["acc_pointer_IR","optic_Arco_blk_F"],
	 "",
	 "hgun_Rook40_F",
	 "Binocular",
	 ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles_OPFOR"],
	 "GryffinRegiment",
	 "H_HelmetO_ocamo",
	 "",
	 "V_TacVest_khk"];
	 
    _SFrfl =
    ["U_O_V_Soldier_Viper_hex_F",
    "16Rnd_9x21_Mag",
    ["HandGrenade","Laserbatteries"],
    "30Rnd_65x39_caseless_green",
    "B_ViperLightHarness_hex_F",
    "10Rnd_50BW_Mag_F",
    "arifle_ARX_hex_F",
    ["acc_pointer_IR","optic_Arco","muzzle_snds_65_TI_hex_F"],
    "",
    "hgun_Rook40_F",
    "Laserdesignator_02",
    ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS",""],
    "GryffinRegiment",
    "H_HelmetO_ViperSP_hex_F",
    "",
    ""];
	 
	_Staff =
	["U_O_CombatUniform_ocamo",
	"16Rnd_9x21_Mag",
	["",""],
	"",
	"",
	"",
	"",
	[],
	"",
	"hgun_Rook40_F",
	"",
	["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS",""],
	"GryffinRegiment",
	"H_MilCap_ocamo",
	"",
	""];
     	 
	 
	_Ret = [[_RflMn,_SFrfl],_Staff];
};

if (_Nat isEqualTo "NATO") then
{
    _RflMn = 
    ["U_B_CombatUniform_mcam",
	 "11Rnd_45ACP_Mag",
	 ["HandGrenade","HandGrenade"],
	 "30Rnd_65x39_caseless_mag",
	 "",
	 "",
	 "arifle_MX_F",
	 ["acc_pointer_IR","optic_Hamr"],
	 "",
	 "hgun_Pistol_heavy_01_F",
	 "Binocular",
	 ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles"],
	 "TFAegis",
	 "H_HelmetB_sand",
	 "",
	 "V_PlateCarrier2_rgr"];
	 
	 _SFrfl =
	 ["U_B_CTRG_Soldier_F",
	 "16Rnd_9x21_Mag",
	 ["MiniGrenade","SmokeShell"],
	 "30Rnd_556x45_Stanag",
	 "",
	 "",
	 "arifle_SPAR_01_blk_F",
	 ["acc_pointer_IR","optic_ERCO_blk_F","muzzle_snds_M"],
	 "",
	 "hgun_P07_khk_F",
	 "Laserdesignator_01_khk_F",
	 ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGogglesB_grn_F"],
	 "CTRG14",
	 "H_HelmetB_TI_tna_F",
	 "G_Balaclava_TI_tna_F",
	 "V_TacVest_oli"];
	 
	 _Staff =
	 ["U_B_CombatUniform_mcam",
	 "11Rnd_45ACP_Mag",
	 ["",""],
	 "",
	 "",
	 "",
	 "",
	 [],
	 "",
	 "hgun_Pistol_heavy_01_F",
	 "",
	 ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS",""],
	 "TFAegis",
	 "H_MilCap_mcamo",
	 "",
	 ""];
	 
	_Ret = [[_RflMn,_SFrfl],_Staff];
};

_Ret