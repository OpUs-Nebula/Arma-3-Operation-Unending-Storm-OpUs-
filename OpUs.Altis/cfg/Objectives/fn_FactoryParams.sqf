params  ["_Fort"];

//Tags: Land = ["NoArmor","Light","Medium","Heavy"],
//Tag: ["Tier1","Tier2"..."TierN",Price]

_Ret = [["Land_i_Shed_Ind_F","Large Workshop"],
        ["Land_Addon_05_F","Medium Workshop"],
        ["Land_Warehouse_01_F","Medium Industrial Factory"],
        ["Land_Factory_Main_F","Small Factory"],
        ["Land_Warehouse_02_F","Large Industrial Factory"],
        ["Land_i_Garage_V1_F","Civilian Workshop"],
        ["Land_Warehouse_03_F","Small Workshop"]];

if (_Fort isEqualTo "Land_Addon_05_F") then {
	_VehSpawn = 
	[[[3.32422,-12.9941,-2.13757],-179.689,"B_MRAP_01_F"],
    [[-0.654297,-13.1699,-2.23874],-179.497,"B_MRAP_01_F"]];
	_Tags  = ["Light"];
	_Price = 100;
	_Time  = 10;
	
	_Ret  = [_VehSpawn,_Tags,_Price,_Time];
};

if (_Fort isEqualTo "Land_i_Shed_Ind_F") then {
	_VehSpawn = 
	[[[8.46875,13.9805,-2.00683],314.213,"B_MRAP_01_F"],
    [[7.5,5.78516,-1.24439],270.446,"B_MRAP_01_F"],
    [[-2.45313,14.8535,-2.02609],314.214,"B_MRAP_01_F"],
    [[13.3418,-7.83203,-1.26916],178.408,"B_MRAP_01_F"],
    [[-1.11523,-7.58203,-1.33993],214.985,"B_MRAP_01_F"]];
	_Tags = ["Light"];
    _Price = 100;
	_Time  = 10;
	
	_Ret  = [_VehSpawn,_Tags,_Price,_Time];
};

if (_Fort isEqualTo "Land_Warehouse_01_F") then {
	_VehSpawn = 
	[[[0.486328,-25.4629,-3.08835],180.885,"B_APC_Wheeled_01_cannon_F"],
    [[0.181641,25.3672,-2.22808],0.815918,"B_MBT_01_cannon_F"]];
	_Tags = ["Heavy","Medium"];
    _Price = 100;
    _Time  = 10;
	
	_Ret  = [_VehSpawn,_Tags,_Price,_Time];
};

if (_Fort isEqualTo "Land_Factory_Main_F") then {
	_VehSpawn = 
 	[[[3.66602,22.9082,-6.37955],1.34761,"B_APC_Wheeled_01_cannon_F"],
    [[-3.88867,23.3516,-6.65445],0.0406189,"B_APC_Wheeled_01_cannon_F"]];
	_Tags = ["Medium"];
    _Price = 100;
    _Time  = 10;
	
	_Ret  = [_VehSpawn,_Tags,_Price,_Time];
};

if (_Fort isEqualTo "Land_Warehouse_02_F") then {
	_VehSpawn = 
	[[[0.103516,20.5195,-5.47947],0.458846,"B_MBT_01_cannon_F"],
    [[-15.502,20.4492,-5.56833],0.458846,"B_MBT_01_cannon_F"],
    [[15.1055,20.3516,-5.49088],0.458846,"B_MBT_01_cannon_F"],        
    [[-7.11914,-20.0762,-4.62636],179.954,"B_APC_Wheeled_01_cannon_F"],        
    [[-13.8535,-20.0234,-4.75075],179.954,"B_APC_Wheeled_01_cannon_F"],        
    [[-20.5625,-20.0469,-4.74745],179.954,"B_APC_Wheeled_01_cannon_F"]];
    _Tags = ["Heavy","Medium"];
    _Price = 100;
    _Time  = 10;
    
	_Ret  = [_VehSpawn,_Tags,_Price,_Time];
};

if (_Fort isEqualTo "Land_i_Garage_V1_F") then {
	_VehSpawn = [[[0.740234,0.0859375,-0.0992126],-89.0828,"C_Offroad_01_F"]];
	_Tags = ["NoArmor"];
	_Price = 100;  
    _Time  = 10;
	
	_Ret  = [_VehSpawn,_Tags,_Price,_Time];
};

if (_Fort isEqualTo "Land_Warehouse_03_F") then {
	_VehSpawn = 
	[[[1.48438,-11.4043,-2.46337],178.845,"B_MRAP_01_F"],
    [[-7.06445,-11.5723,-2.17718],178.847,"B_MRAP_01_F"]];
	_Tags = ["Light"];
    _Price = 100;
	_Time  = 10;
	
	_Ret  = [_VehSpawn,_Tags,_Price,_Time];
};

_Ret