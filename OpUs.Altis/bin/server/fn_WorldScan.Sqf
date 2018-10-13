/*---------------------------------------------------------------------------
-----------------------------------------------------------------------------
Script for Scanning map coordinates                             -------------
(Ie Villages, Towns, Cites) By Nebula                           -------------
																-------------
fn_Init														    -------------
																-------------
																-------------
																-------------
																-------------
-----------------------------------------------------------------------------
---------------------------------------------------------------------------*/
//OBS!!! 2D output, put 0 at the end of each array in order to use for ATL.

InputX = param[0];
InputY = param[1];

xStartRaw = ceil (InputX param[0]);
xFinRaw   = ceil (InputX param[1]);

yStartRaw = ceil (InputY param[0]);
yFinRaw   = ceil (InputY param[1]);

xScanStart = xStartRaw - (xStartRaw mod 400);
xScanFin   = xFinRaw - (xFinRaw mod 400);

yScanFin   = yFinRaw - (yFinRaw mod 400);
yScanStart = yStartRaw - (yStartRaw mod 400);

_ret = [];

for "_b" from xScanStart to xScanFin step 400 do { 
  
  Pos = [];
  
  for "_h" from yScanStart to yScanFin step 400 do {
  
     SubPos = [[_b,_h,0]]; 
	 Pos append SubPos;
    };
    _ret append Pos;
};

[_ret]
   