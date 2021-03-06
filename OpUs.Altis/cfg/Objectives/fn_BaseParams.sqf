params ["_Fort"];
Private ["_Ret"];

_Clss = typeOf _Fort;

_Twrs = ["Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V4_F"];
//CARGP HQ, LVL 3 FOB/BASE.
if (_Clss in _Twrs) then 
{
	
    _GrdsExt  = 
	[[[6.62891,-0.634766,4.94711],90.9228],
    [[-4.60938,-5.71484,4.92951],228.137],
    [[-4.86523,5.62891,5.00186],326.905],
    [[5.23828,4.59961,5.00477],46.1011],
    [[5.07813,-3.36914,4.98879],158.596],
    [[-3.28906,-0.78125,-12.8612],273.039],
    [[-3.06055,3.2793,-12.8355],262.692]];
	
	_GrdsInt  = 
	[[[0.435547,-0.365234,2.5772],85.2796],
    [[-0.945313,5.82422,2.61547],182.24],
    [[-4.25391,5.74414,2.61559],180.215]];
	
	_Supplies = 
	[[[5.54102,2.30273,2.46727],-1.35393,"FlexibleTank_01_sand_F"],
    [[5.55664,1.60156,2.47672],-1.35393,"FlexibleTank_01_sand_F"],
    [[4.77344,1.67773,2.49763],-1.35393,"FlexibleTank_01_sand_F"],
    [[4.83008,2.3125,2.48952],-1.35393,"FlexibleTank_01_sand_F"],
    [[3.26953,-2.87891,-0.14526],91.3325,"Land_Pipes_small_F"],
    [[1.50977,-2.83008,-0.134823],91.3325,"Land_Pipes_small_F"],
    [[0.884766,-2.86328,-0.148666],91.3325,"Land_Pipes_small_F"],
    [[2.12305,-2.8457,-0.141682],91.3325,"Land_Pipes_small_F"],
    [[2.7168,-2.85547,-0.134834],91.3325,"Land_Pipes_small_F"],
    [[-5.1875,0.132813,-0.122812],-1.35393,"Land_WoodPile_F"],
    [[-5.30078,2.40039,-0.131107],-1.35393,"Land_WoodPile_F"],
    [[-4.96094,-2.08594,-0.0123634],-1.35393,"Land_WoodPile_F"]];
	
    _Furn     = 
	[[[-1.48047,-2.77539,2.48039],90.6461,"Land_OfficeChair_01_F"],
    [[-3.49414,-2.33398,2.55029],270.638,"Land_OfficeChair_01_F"],
    [[-3.48438,-1.00586,2.54356],270.442,"Land_OfficeChair_01_F"],
    [[-1.47266,-1.45117,2.47571],90.6461,"Land_OfficeChair_01_F"]];
	
	_Props    = 
	[[[-2.94141,-5.0957,0.797403],40.1425,"Land_DrillAku_F"],
    [[-5.26953,-3.75781,0.816448],268.002,"Box_I_UAV_06_F"],
    [[-5.49023,5.02148,0.721933],268.002,"Box_I_UAV_06_F"],
    [[-5.49609,4.52539,0.728811],268.002,"Box_I_UAV_06_F"],
    [[0.458984,-1.95117,2.68743],89.9555,"Land_New_WiredFence_5m_F"],
    [[3.32227,-2.78711,2.76396],-1.35393,"Land_NetFence_02_m_2m_F"],
    [[4.48047,-3.42773,2.77501],268.408,"Land_NetFence_02_m_2m_F"],
    [[-1.98633,0.40625,2.45735],-0.92193,"Land_NetFence_02_m_4m_F"],
    [[2.42578,-3.62305,2.47267],90.5279,"Land_NetFence_02_m_gate_v1_F"],
    [[-5.16797,0.451172,2.53133],-1.35393,"Land_NetFence_02_m_gate_v1_F"],
    [[-4.10938,0.376953,2.47928],-1.35393,"Land_NetFence_02_m_pole_F"],
    [[-4.29883,0.371094,2.48342],-1.35393,"Land_NetFence_02_m_pole_F"],
    [[-4.47852,0.369141,2.48437],-1.35393,"Land_NetFence_02_m_pole_F"],
    [[-3.97266,0.384766,2.47793],-1.35393,"Land_NetFence_02_m_pole_F"],
    [[-5.64844,4.80273,0.0291138],-1.35393,"Land_Crowbar_01_F"],
    [[-5.51563,4.92773,0.0328598],-1.35393,"Land_File_F"],
    [[-2.25781,-4.64453,-0.0153027],-1.35393,"Land_File_F"],
    [[-0.136719,-4.23047,-0.127499],178.938,"Land_FireExtinguisher_F"],
    [[-3.29688,-5.20508,-0.0168381],198.792,"Land_GasTank_01_yellow_F"],
    [[-5.46875,4.73633,0.372194],-1.35393,"Land_Grinder_F"],
    [[-2.30078,-5.30273,0.798086],-1.35393,"Land_Hammer_F"],
    [[-5.57031,4.52344,0.0308304],-1.35393,"Land_MultiMeter_F"],
    [[-1.54688,-3.63867,-0.132542],179.426,"Land_Pallet_F"],
    [[-3.10742,-3.63867,-0.136497],180.26,"Land_Pallet_F"],
    [[-2.21289,-2.04883,3.34146],271.425,"Land_PCSet_01_case_F"],
    [[-2.20508,-0.726563,3.29932],271.425,"Land_PCSet_01_case_F"],
    [[-2.76172,-3.06055,3.3131],91.4171,"Land_PCSet_01_case_F"],
    [[-2.74805,-1.72852,3.30828],91.2212,"Land_PCSet_01_case_F"],
    [[-2.08594,-1.62891,3.33156],270.646,"Land_PCSet_01_keyboard_F"],
    [[-2.09375,-2.95117,3.33624],270.646,"Land_PCSet_01_keyboard_F"],
    [[-2.88086,-2.1582,3.34284],90.6379,"Land_PCSet_01_keyboard_F"],
    [[-2.87109,-0.826172,3.336],90.442,"Land_PCSet_01_keyboard_F"],
    [[-2.00977,-1.14844,3.32573],90.436,"Land_PCSet_01_mousepad_F"],
    [[-2.01758,-2.4707,3.33041],90.436,"Land_PCSet_01_mousepad_F"],
    [[-2.95703,-2.63672,3.34828],270.428,"Land_PCSet_01_mousepad_F"],
    [[-2.94336,-1.30664,3.34136],270.232,"Land_PCSet_01_mousepad_F"],
    [[-2.03906,-1.1875,3.33481],271.508,"Land_PCSet_01_mouse_F"],
    [[-2.04688,-2.50977,3.33948],271.508,"Land_PCSet_01_mouse_F"],
    [[-2.92578,-2.59766,3.35409],91.5003,"Land_PCSet_01_mouse_F"],
    [[-2.91406,-1.26758,3.34725],91.3045,"Land_PCSet_01_mouse_F"],
    [[-2.20313,-2.75781,3.32104],270.646,"Land_PCSet_01_screen_F"],
    [[-2.77148,-2.35156,3.31241],90.6379,"Land_PCSet_01_screen_F"],
    [[-2.75977,-1.01953,3.30693],90.442,"Land_PCSet_01_screen_F"],
    [[-2.19531,-1.43555,3.30749],270.646,"Land_PCSet_01_screen_F"],
    [[-1.53711,-5.14844,0.798288],0.160143,"Land_Portable_generator_F"],
    [[-2.06641,-4.62305,-0.00895691],272.719,"Land_Rope_01_F"],
    [[-2.71875,-5.31836,0.793505],-1.35393,"Land_Saw_F"],
    [[-2.17773,-4.60938,-0.0145149],-1.35393,"Land_Screwdriver_V2_F"],
    [[-5.51563,3.5332,-0.120522],-1.35393,"Land_Sleeping_bag_folded_F"],
    [[-5.54883,3.80469,-0.121563],-1.35393,"Land_Sleeping_bag_folded_F"],
    [[-5.56641,4.0625,-0.120686],-1.35393,"Land_Sleeping_bag_folded_F"],
    [[-5.20508,3.67578,-0.124474],267.244,"Land_Sleeping_bag_folded_F"],
    [[-5.10352,4.07617,-0.123657],-1.35393,"Land_Sleeping_bag_folded_F"],
    [[-4.93945,3.67383,-0.121929],266.359,"Land_Sleeping_bag_folded_F"],
    [[-0.576172,-5.39648,0.804899],0.41234,"Land_Meter3m_F"],
    [[-5.20313,-4.88867,-0.0130539],90.3119,"Land_WeldingTrolley_01_F"],
    [[-0.640625,-5.17188,0.799654],-1.35393,"Land_Wrench_F"],
    [[-0.728516,-5.17773,0.800821],179.684,"Land_Wrench_F"],
    [[-2.3418,-4.63672,-0.0131016],-1.35393,"Land_Wrench_F"]];
	
	_Intel    = 
	[[[-1.10352,-5.39258,2.62666],317.46,"Land_TripodScreen_01_dual_v1_F"],
    [[-4.88867,-5.52539,2.62016],29.6452,"Land_TripodScreen_01_dual_v1_F"],
    [[-2.98633,-5.9043,2.666],0.575304,"Land_TripodScreen_01_large_F"]];
	
	_HVTpos   = 
	[[[-2.89453,-4.93164,2.57785],3.04507,"B_T_Officer_F"],
    [[-1.61523,-4.37109,0.053091],175.018,"B_engineer_F"]];
	
	_Flips    = [[[-1.98633,0.40625,3.94335],-0.92193,"Land_NetFence_02_m_4m_F"]];
	
	_FstDwn   = 
	[[[3.14844,4.30078,2.44218],-1.35393,"B_CargoNet_01_ammo_F"],
    [[-2.12891,-1.22852,2.4805],270.173,"OfficeTable_01_new_F"],
    [[-2.13672,-2.55273,2.48478],270.173,"OfficeTable_01_new_F"],
    [[-2.83789,-2.55664,2.4899],90.1649,"OfficeTable_01_new_F"],
    [[-2.82422,-1.22461,2.48297],89.9691,"OfficeTable_01_new_F"],
    [[-5.2832,-3.82031,-0.141804],143.476,"Land_ToolTrolley_02_F"],
    [[-5.4668,4.69336,-0.131952],179.688,"Land_ToolTrolley_01_F"],
    [[-1.83789,-5.04492,-0.0175076],179.778,"Land_Workbench_01_F"]];
	

    _Ret = [_GrdsExt,_GrdsInt,_Supplies,_Furn,_Props,_Intel,_HVTpos,_Flips,_FstDwn];  
};

_Ret