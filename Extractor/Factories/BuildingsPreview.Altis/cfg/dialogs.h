class client_GunShop_Dialog
{
	idd = 99999;
	movingEnabled = false;
	class controls
	{ 
      ////////////////////////////////////////////////////////
      // GUI EDITOR OUTPUT START (by Nebula, v1.063, #Gihere)
      ////////////////////////////////////////////////////////

      class client_rscPicture: RscPicture
        {
	      idc = 1200;
	      text = "#(argb,8,8,3)color(1,1,1,1)";
	      x = 0.149971 * safezoneW + safezoneX;
	      y = 0.17178 * safezoneH + safezoneY;
	      w = 0.700059 * safezoneW;
	      h = 0.656441 * safezoneH;
        };
      class client_rscButton_1: RscButton
        {
	      idc = 1600;
	      text = "Equip"; //--- ToDo: Localize;
	      x = 0.640012 * safezoneW + safezoneX;
	      y = 0.618159 * safezoneH + safezoneY;
	      w = 0.166264 * safezoneW;
	      h = 0.0393864 * safezoneH;
		  action = "['open','true'] call BIS_fnc_garage";
        };
      class client_rscButton_2: RscButton
        {
	      idc = 1601;
	      text = "Close"; //--- ToDo: Localize;
	      x = 0.158721 * safezoneW + safezoneX;
	      y = 0.184909 * safezoneH + safezoneY;
	      w = 0.166264 * safezoneW;
	      h = 0.0393864 * safezoneH;
		  action = "closeDialog 0;";
        };
      class client_rscListBox: RscListbox
        {
	      idc = 1500;
	      x = 0.61376 * safezoneW + safezoneX;
	      y = 0.198037 * safezoneH + safezoneY;
	      w = 0.218768 * safezoneW;
	      h = 0.406993 * safezoneH;
        };
      class client_Watch: RscButton
        {
	      idc = 1602;
	      text = "Get Time"; //--- ToDo: Localize;
	      x = 0.429994 * safezoneW + safezoneX;
	      y = 0.184909 * safezoneH + safezoneY;
	      w = 0.0787566 * safezoneW;
	      h = 0.0656441 * safezoneH;
		  action = "[] spawn client_fnc_CreateTimer";
        };
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
	};		
};