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
	      //text = "#(argb,8,8,3)color(1,1,1,1)";
	      x = 0.149971 * safezoneW + safezoneX;
	      y = 0.17178 * safezoneH + safezoneY;
	      w = 0.700059 * safezoneW;
	      h = 0.656441 * safezoneH;
		  colorBackground[] = {0.184,0.2,0.125,0.7};
        };
      class client_rscButton_1: RscButton
        {
	      idc = 1600;
	      text = "Spawn Vehicle"; //--- ToDo: Localize;
	      x = 0.640012 * safezoneW + safezoneX;
	      y = 0.618159 * safezoneH + safezoneY;
	      w = 0.166264 * safezoneW;
	      h = 0.0393864 * safezoneH;
		  action = "((findDisplay 99999) getVariable 'LBSL') createVehicle position player;";
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
		// RscListbox
      class client_rscListBox: RscListbox
        {
	        idc = 1500;
		    style = ST_LEFT + LB_TEXTURES;
	        x = 0.61376 * safezoneW + safezoneX;
	        y = 0.198037 * safezoneH + safezoneY;
	        w = 0.218768 * safezoneW;
	        h = 0.406993 * safezoneH;
		    colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
		    colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color
		    colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)
            
		    sizeEx = GUI_GRID_CENTER_H; // Text size
		    font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
		    shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
		    colorText[] = {1,1,1,1}; // Text and frame color
		    colorDisabled[] = {1,1,1,0.5}; // Disabled text color
		    colorSelect[] = {1,1,1,1}; // Text selection color
		    colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
		    colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)
            
		    pictureColor[] = {1,0.5,0,1}; // Picture color
		    pictureColorSelect[] = {1,1,1,1}; // Selected picture color
		    pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color
            
		    tooltip = "CT_LISTBOX"; // Tooltip text
		    tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
		    tooltipColorText[] = {1,1,1,1}; // Tooltip text color
		    tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color
            
		    period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected
            
		    rowHeight = 1.5 * GUI_GRID_CENTER_H; // Row height
		    itemSpacing = 0; // Height of empty space between items
		    maxHistoryDelay = 1; // Time since last keyboard type search to reset it
		    canDrag = 1; // 1 (true) to allow item dragging
            
		    soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected
            
		    // Scrollbar configuration (applied only when LB_TEXTURES style is used)
		    class ListScrollBar //In older games this class is "ScrollBar"
		    {
		    	width = 0; // width of ListScrollBar
		    	height = 0; // height of ListScrollBar
		    	scrollSpeed = 0.01; // scroll speed of ListScrollBar
            
		    	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
		    	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
		    	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
		    	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)
            
		    	color[] = {1,1,1,1}; // Scrollbar color
		    };
            
		    onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
		    onDestroy = "systemChat str ['onDestroy',_this]; false";
		    onSetFocus = "systemChat str ['onSetFocus',_this]; false";
		    onKillFocus = "systemChat str ['onKillFocus',_this]; false";
		    onKeyDown = "systemChat str ['onKeyDown',_this]; false";
		    onKeyUp = "systemChat str ['onKeyUp',_this]; false";
		    onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
		    onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
		    onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
		    onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
		    onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
		    onMouseMoving = "";
		    onMouseHolding = "";
            
		    onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; (findDisplay 99999) setVariable ['LBSL',lbData [1500,_this param[1]]]";
		    onLBDblClick = "systemChat str ['onLBDblClick',_this]; false";
		    onLBDrag = "systemChat str ['onLBDrag',_this]; false";
		    onLBDragging = "systemChat str ['onLBDragging',_this]; false";
		    onLBDrop = "systemChat str ['onLBDrop',_this]; false";
        };
      class client_Watch: RscButton
        {
	      idc = 1602;
	      text = "Undefined"; //--- ToDo: Localize;
	      x = 0.429994 * safezoneW + safezoneX;
	      y = 0.184909 * safezoneH + safezoneY;
	      w = 0.0787566 * safezoneW;
	      h = 0.0656441 * safezoneH;
		  action = "hint ((findDisplay 99999) getVariable 'LBSL')";
        };
	};		
};


class client_Engineering_Dialog
{
	idd = 126851;
	movingEnabled = true;
	class controls
	{
        //:RscFrame		
        class RscFrameBackground: RscText
        {
        	idc = 1800;
        
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.171875 * safezoneH + safezoneY;
        	w = 0.7 * safezoneW;
        	h = 0.65625 * safezoneH;
            //fixedWidth = 0;
			colorBackground[] = {0.184,0.2,0.125,0.7};
        };
        class RscVehlist: RscListBox
        {
        	idc = 1500;
        
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.303125 * safezoneH + safezoneY;
        	w = 0.2625 * safezoneW;
        	h = 0.275625 * safezoneH;
			type = CT_LISTBOX; // Type is 5
			style = ST_LEFT + LB_TEXTURES; // Style
			default = 0; // Control selected by default (only one within a display can be used)
			blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
			
			colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
			colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color
			colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

			sizeEx = GUI_GRID_CENTER_H; // Text size
			font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
			shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
			colorText[] = {1,1,1,1}; // Text and frame color
			colorDisabled[] = {1,1,1,0.5}; // Disabled text color
			colorSelect[] = {1,1,1,1}; // Text selection color
			colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
			colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

			pictureColor[] = {1,0.5,0,1}; // Picture color
			pictureColorSelect[] = {1,1,1,1}; // Selected picture color
			pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

			tooltip = "CT_LISTBOX"; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

			period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

			rowHeight = 1.5 * GUI_GRID_CENTER_H; // Row height
			itemSpacing = 0; // Height of empty space between items
			maxHistoryDelay = 1; // Time since last keyboard type search to reset it
			canDrag = 1; // 1 (true) to allow item dragging

			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

			// Scrollbar configuration (applied only when LB_TEXTURES style is used)
			class ListScrollBar //In older games this class is "ScrollBar"
			{
				width = 0; // width of ListScrollBar
				height = 0; // height of ListScrollBar
				scrollSpeed = 0.01; // scroll speed of ListScrollBar

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

				color[] = {1,1,1,1}; // Scrollbar color
			};
			onDestroy = "systemChat str ['onDestroy',_this]; false";
			onLBSelChanged = "(findDisplay 126851) setVariable ['LBSL',lbData [1500,_this param[1]]];";
        };
        class RscHead: RscText
        {
        	idc = 1000;
        
        	text = "Engineering"; //--- ToDo: Localize;
        	x = 0.605 * safezoneW + safezoneX;
        	y = 0.171875 * safezoneH + safezoneY;
        	w = 0.245 * safezoneW;
        	h = 0.07875 * safezoneH;
			font = GUI_FONT_BOLD;
        };
        class RscCat11: RscButton
        {
        	idc = 1600;
        
        	text = "Category1"; //--- ToDo: Localize;
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.171875 * safezoneH + safezoneY;
        	w = 0.0525 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscCat12: RscButton
        {
        	idc = 1601;
        
        	text = "Category2"; //--- ToDo: Localize;
        	x = 0.255 * safezoneW + safezoneX;
        	y = 0.171875 * safezoneH + safezoneY;
        	w = 0.0525 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscCat13: RscButton
        {
        	idc = 1602;
        
        	text = "Category3"; //--- ToDo: Localize;
        	x = 0.36 * safezoneW + safezoneX;
        	y = 0.171875 * safezoneH + safezoneY;
        	w = 0.0525 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscCat21: RscButton
        {
        	idc = 1603;
        
        	text = "Category4"; //--- ToDo: Localize;
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.250625 * safezoneH + safezoneY;
        	w = 0.0525 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscCat22: RscButton
        {
        	idc = 1604;
        
        	text = "Category5"; //--- ToDo: Localize;
        	x = 0.255 * safezoneW + safezoneX;
        	y = 0.250625 * safezoneH + safezoneY;
        	w = 0.0525 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscCat23: RscButton
        {
        	idc = 1605;
        
        	text = "Category6"; //--- ToDo: Localize;
        	x = 0.36 * safezoneW + safezoneX;
        	y = 0.250625 * safezoneH + safezoneY;
        	w = 0.0525 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscDescBord: RscText
        {
        	idc = 1801;
        
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.57875 * safezoneH + safezoneY;
        	w = 0.2625 * safezoneW;
        	h = 0.249375 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
        };
        class RscVehDesc: RscLbA3
        {
        	idc = 1001;

        	x = 0.15875 * safezoneW + safezoneX;
        	y = 0.591875 * safezoneH + safezoneY;
        	w = 0.245 * safezoneW;
        	h = 0.223125 * safezoneH;
			//colorBackground[] = {0.2,0.2,0.2,1};
			font = GUI_FONT_THIN;
			
			//colorSelect[] = {0.2,0.2,0.2,1};
            //colorSelect2[] = {0.2,0.2,0.2,1};
			//colorSelectBackground2[] = {0.2,0.2,0.2,1};
	    };
        class RscNatLogo: RscPicture
        {
        	idc = 1200;
        //[] call cfg_fnc_DispFlag
        	text = "#(argb,8,8,3)color(1,1,1,1)";
        	x = 0.42125 * safezoneW + safezoneX;
        	y = 0.185 * safezoneH + safezoneY;
        	w = 0.175 * safezoneW;
        	h = 0.065625 * safezoneH;
        };
        class RscItems: RscLbA3
        {
        	idc = 1501;
        
        	x = 0.745 * safezoneW + safezoneX;
        	y = 0.26375 * safezoneH + safezoneY;
        	w = 0.09625 * safezoneW;
        	h = 0.1575 * safezoneH;
        };
        class RscItemsDescFrame: RscText
        {
        	idc = 1802;
        
        	x = 0.63125 * safezoneW + safezoneX;
        	y = 0.26375 * safezoneH + safezoneY;
        	w = 0.11375 * safezoneW;
        	h = 0.1575 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
        };
        class RscItemDesc: RscText
        {
        	idc = 1002;
        
        	text = "Resource Item Description"; //--- ToDo: Localize;
        	x = 0.64 * safezoneW + safezoneX;
        	y = 0.276875 * safezoneH + safezoneY;
        	w = 0.09625 * safezoneW;
        	h = 0.13125 * safezoneH;
			colorBackground[] = {0.2,0.2,0.2,1};
			font = GUI_FONT_THIN;
        };
        class RscBuy: RscButton
        {
        	idc = 1606;
        
        	text = "Purchase"; //--- ToDo: Localize;
        	x = 0.42125 * safezoneW + safezoneX;
        	y = 0.749375 * safezoneH + safezoneY;
        	w = 0.11375 * safezoneW;
        	h = 0.065625 * safezoneH;
        };
		//: RscButton
        class RscPlayerFunds: RscStructuredText
        {
        	idc = 1607;
        
            colorBackground[] = 
	        {
	        	0,
	        	0,
	        	0,
	        	0.5
	        };		
        	text = "PlayerFunds"; //--- ToDo: Localize;
        	x = 0.42125 * safezoneW + safezoneX;
        	y = 0.276875 * safezoneH + safezoneY;
        	w = 0.07 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
		//: RscButton
        class RscNatFunds: RscStructuredText
        {
        	idc = 1608;
        
		    colorBackground[] = 
	        {
	        	0,
	        	0,
	        	0,
	        	0.5
	        };		
        	text = "Nation GDP"; //--- ToDo: Localize;
        	x = 0.52625 * safezoneW + safezoneX;
        	y = 0.276875 * safezoneH + safezoneY;
        	w = 0.07 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscText_1803: RscText
        {
        	idc = 1803;
        
        	x = 0.63125 * safezoneW + safezoneX;
        	y = 0.42125 * safezoneH + safezoneY;
        	w = 0.21875 * safezoneW;
        	h = 0.406875 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
        };
        class RscSquadTree: RscListBox
        {
        	idc = 1502;
        
        	x = 0.64 * safezoneW + safezoneX;
        	y = 0.434375 * safezoneH + safezoneY;
        	w = 0.20125 * safezoneW;
        	h = 0.380625 * safezoneH;
			type = CT_TREE; // Type is 12
			style = ST_LEFT; // Style
			default = 0; // Control selected by default (only one within a display can be used)
			blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

			colorBorder[] = {0,0,0,1}; // Frame color

			colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
			colorSelect[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 0)
			colorMarked[] = {1,0.5,0,0.5}; // Marked item fill color (when multiselectEnabled is 1)
			colorMarkedSelected[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 1)

			sizeEx = GUI_GRID_CENTER_H; // Text size
			font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
			shadow = 1; // Shadow (0 - none, 1 - N/A, 2 - black outline)
			colorText[] = {1,1,1,1}; // Text color
			colorSelectText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 0)
			colorMarkedText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 1)

			tooltip = "CT_TREE"; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

			multiselectEnabled = 1; // Allow selecting multiple items while holding Ctrl or Shift
			expandOnDoubleclick = 1; // Expand/collapse item upon double-click
			hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa"; // Expand icon
			expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa"; // Collapse icon
			maxHistoryDelay = 1; // Time since last keyboard type search to reset it

			// Scrollbar configuration
			class ScrollBar
			{
				width = 0; // width of ScrollBar
				height = 0; // height of ScrollBar
				scrollSpeed = 0.01; // scroll speed of ScrollBar

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

				color[] = {1,1,1,1}; // Scrollbar color
			};

			colorDisabled[] = {0,0,0,0}; // Does nothing, but must be present, otherwise an error is shown
			colorArrow[] = {0,0,0,0}; // Does nothing, but must be present, otherwise an error is shown

			onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
			onDestroy = "systemChat str ['onDestroy',_this]; false";
			onMouseEnter = "systemChat str ['onMouseEnter',_this]; false";
			onMouseExit = "systemChat str ['onMouseExit',_this]; false";
			onSetFocus = "systemChat str ['onSetFocus',_this]; false";
			onKillFocus = "systemChat str ['onKillFocus',_this]; false";
			onKeyDown = "systemChat str ['onKeyDown',_this]; false";
			onKeyUp = "systemChat str ['onKeyUp',_this]; false";
			onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
			onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
			onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
			onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
			onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
			onMouseMoving = "";
			onMouseHolding = "";

			onTreeSelChanged = "systemChat str ['onTreeSelChanged',_this]; false";
			onTreeLButtonDown = "systemChat str ['onTreeLButtonDown',_this]; false";
			onTreeDblClick = "systemChat str ['onTreeDblClick',_this]; false";
			onTreeExpanded = "systemChat str ['onTreeExpanded',_this]; false";
			onTreeCollapsed = "systemChat str ['onTreeCollapsed',_this]; false";
			onTreeMouseExit = "systemChat str ['onTreeMouseExit',_this]; false";
        };          
	};
};
class client_Building_Display
{
	idd = 356851;
	movingEnabled = true;
//	onMouseButtonClick = "systemChat str [(nearestObject (screenToWorld (getMousePosition))),(screenToWorld (getMousePosition))];";
	class controls
	{
		//: RscCombo
        class RscBuildClasses: RscCombo
        {
        	idc = 2100;
        	x = 0.00125001 * safezoneW + safezoneX;
        	y = 0.00125002 * safezoneH + safezoneY;
        	w = 0.21875 * safezoneW;
        	h = 0.039375 * safezoneH;
			onLBSelChanged = "(findDisplay 356851) setVariable ['LBCL',((findDisplay 356851) displayCtrl 1500) lbData (_this param[1])];";
        };
        class RscBuildItems: RscLbA3
        {
        	idc = 1500;
        	x = 0.00125001 * safezoneW + safezoneX;
        	y = 0.0406251 * safezoneH + safezoneY;
        	w = 0.21875 * safezoneW;
        	h = 0.958125 * safezoneH;
			colorBackground[] = {0.2,0.2,0.2,0.7};
			onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; (findDisplay 356851) setVariable ['LBSL',((findDisplay 356851) displayCtrl 1500) lbData (_this param[1])]; systemChat str ['LBDATACHANGED',((findDisplay 356851) displayCtrl 1500) lbData (_this param[1])];";
        };
        class RscDescBack: RscText
        {
        	idc = 1001;
        
        	x = 0.00125001 * safezoneW + safezoneX;
        	y = 0.749375 * safezoneH + safezoneY;
        	w = 0.21875 * safezoneW;
        	h = 0.249375 * safezoneH;
        	colorBackground[] = {0,0,0,0.8};
        };
        class RscItemDesc: RscLbA3
        {
        	idc = 1500;
        
        	x = 0.01 * safezoneW + safezoneX;
        	y = 0.7625 * safezoneH + safezoneY;
        	w = 0.20125 * safezoneW;
        	h = 0.223125 * safezoneH;
			colorBackground[] = {0.2,0.2,0.2,0.7};
        };
        class RscBuildDir: RscSlider
        {
        	idc = 1900;
        
        	x = 0.22875 * safezoneW + safezoneX;
        	y = 0.94625 * safezoneH + safezoneY;
        	w = 0.30625 * safezoneW;
        	h = 0.039375 * safezoneH;
			color[] = {1,1,1,1};
			coloractive[] = {1,0.5,0,1};
        };
        class RscBuildButton: RscButton
        {
        	idc = 1600;
        
        	text = "Build"; //--- ToDo: Localize;
        	x = 0.57875 * safezoneW + safezoneX;
        	y = 0.933125 * safezoneH + safezoneY;
        	w = 0.14 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscSellButton: RscButton
        {
        	idc = 1601;
        
        	text = "Sell"; //--- ToDo: Localize;
        	x = 0.84125 * safezoneW + safezoneX;
        	y = 0.933125 * safezoneH + safezoneY;
        	w = 0.14 * safezoneW;
        	h = 0.0525 * safezoneH;
        };     
    };
};
class client_ItemPurchase_Display
{
    idd = 312351;
    movingEnabled = false;
    class controls
    {  
        class RscFrameBackground: RscText
        {
        	idc = 1800;
        
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.171875 * safezoneH + safezoneY;
        	w = 0.7 * safezoneW;
        	h = 0.65625 * safezoneH;
        	colorBackground[] = {0.184,0.2,0.125,0.7};
        };
        class RscVehlist: RscListBox
        {
            idc = 1500;       	
        	
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.303125 * safezoneH + safezoneY;
        	w = 0.2625 * safezoneW;
        	h = 0.275625 * safezoneH;
        	type = CT_LISTBOX; // Type is 5
        	style = ST_LEFT + LB_TEXTURES; // Style
        	default = 0; // Control selected by default (only one within a display can be used)
        	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
        	
        	colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
        	colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color
        	colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)
        	
        	sizeEx = GUI_GRID_CENTER_H; // Text size
        	font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
        	shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
        	colorText[] = {1,1,1,1}; // Text and frame color
        	colorDisabled[] = {1,1,1,0.5}; // Disabled text color
        	colorSelect[] = {1,1,1,1}; // Text selection color
        	colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
        	colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)
        	
        	pictureColor[] = {1,0.5,0,1}; // Picture color
        	pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        	pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color
        	
        	tooltip = "CT_LISTBOX"; // Tooltip text
        	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
        	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
        	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color
        	
        	period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected
        	
        	rowHeight = 1.5 * GUI_GRID_CENTER_H; // Row height
            itemSpacing = 0; // Height of empty space between items
        	maxHistoryDelay = 1; // Time since last keyboard type search to reset it
        	canDrag = 1; // 1 (true) to allow item dragging
        	
        	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected
        	
        	// Scrollbar configuration (applied only when LB_TEXTURES style is used)
            class ListScrollBar //In older games this class is "ScrollBar"
            {
            	width = 0; // width of ListScrollBar
            	height = 0; // height of ListScrollBar
            	scrollSpeed = 0.01; // scroll speed of ListScrollBar
            
            	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
            	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
            	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
            	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)
            
            	color[] = {1,1,1,1}; // Scrollbar color
		    };
		    onDestroy = "systemChat str ['onDestroy',_this]; false";
		    onLBSelChanged = "(findDisplay 126851) setVariable ['LBSL',lbData [1500,_this param[1]]];";
        };
        class RscHead: RscText
        {
        	idc = 1000;
        	font = "PuristaSemibold";
        
        	text = "Engineering"; //--- ToDo: Localize;
        	x = 0.605 * safezoneW + safezoneX;
        	y = 0.171875 * safezoneH + safezoneY;
        	w = 0.245 * safezoneW;
        	h = 0.07875 * safezoneH;
        };
        class RscDescBord: RscText
        {
        	idc = 1801;
        
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.57875 * safezoneH + safezoneY;
        	w = 0.2625 * safezoneW;
        	h = 0.249375 * safezoneH;
        	colorBackground[] = {0,0,0,0.8};
        };
        class RscVehDesc: RscText
        {
        	idc = 1001;
        	font = "PuristaLight";
        
        	x = 0.15875 * safezoneW + safezoneX;
        	y = 0.591875 * safezoneH + safezoneY;
        	w = 0.245 * safezoneW;
        	h = 0.223125 * safezoneH;
        	colorBackground[] = {0.2,0.2,0.2,1};
        };
        class RscNatLogo: RscPicture
        {
        	idc = 1200;
            
			style = 2096;
        	text = "#(argb,8,8,3)color(1,1,1,1)";
        	x = 0.42125 * safezoneW + safezoneX;
        	y = 0.185 * safezoneH + safezoneY;
        	w = 0.175 * safezoneW;
        	h = 0.065625 * safezoneH;
        };
		/*
        class RscBuildButton: RscButton
		{
			idc = 1600;
		
			text = "Build"; //--- ToDo: Localize;
			x = 0.57875 * safezoneW + safezoneX;
			y = 0.933125 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.0525 * safezoneH;
		};
		*/
        class RscBuy: RscButton
        {
        	idc = 1606;
        
        	text = "Purchase"; //--- ToDo: Localize;
        	x = 0.42125 * safezoneW + safezoneX;
        	y = 0.7625 * safezoneH + safezoneY;
        	w = 0.18375 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscPlayerFunds: RscStructuredText
        {
        	idc = 1607;
        
		    colorBackground[] = 
	        {
	        	0,
	        	0,
	        	0,
	        	0.5
	        };		
        	text = "PlayerFunds"; //--- ToDo: Localize;
        	x = 0.42125 * safezoneW + safezoneX;
        	y = 0.276875 * safezoneH + safezoneY;
        	w = 0.07 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
        class RscNatFunds: RscStructuredText
        {
        	idc = 1608;
            
			colorBackground[] = 
	        {
	        	0,
	        	0,
	        	0,
	        	0.5
	        };	
        	text = "Nation GDP"; //--- ToDo: Localize;
        	x = 0.52625 * safezoneW + safezoneX;
        	y = 0.276875 * safezoneH + safezoneY;
        	w = 0.07 * safezoneW;
        	h = 0.0525 * safezoneH;
        };
		
		//RscCombo_2100:
        class RscCatCombo: RscCombo
        {
        	idc = 2100;
        	x = 0.15875 * safezoneW + safezoneX;
        	y = 0.185 * safezoneH + safezoneY;
        	w = 0.20125 * safezoneW;
        	h = 0.02625 * safezoneH;
			
			onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; (findDisplay 126851) setVariable ['CBSL',lbData [2100,_this param[1]]];";
        };
        class RscIDbk: RscText
        {
        	idc = 1801;
        
        	x = 0.61375 * safezoneW + safezoneX;
        	y = 0.486875 * safezoneH + safezoneY;
        	w = 0.2275 * safezoneW;
        	h = 0.34125 * safezoneH;
        	colorBackground[] = {0,0,0,0.8};
        };
        class RscItemDesc: RscLbA3
        {
        	idc = 19321;
        	font = GUI_FONT_THIN;
        
        	x = 0.6225 * safezoneW + safezoneX;
        	y = 0.486875 * safezoneH + safezoneY;
        	w = 0.21 * safezoneW;
        	h = 0.328125 * safezoneH;
        	colorBackground[] = {0.2,0.2,0.2,1};
        };
        class RscPicBk: RscText
        {
        	idc = 1801;
        
        	x = 0.61375 * safezoneW + safezoneX;
        	y = 0.250625 * safezoneH + safezoneY;
        	w = 0.2275 * safezoneW;
        	h = 0.23625 * safezoneH;
        	colorBackground[] = {0,0,0,0.8};
        };
		class RscItemPic: RscPicture
        {
        	idc = 1201;
			style = 2096;
        	//text = "#(argb,8,8,3)color(1,1,1,1)";
			text = "";
        	x = 0.6225 * safezoneW + safezoneX;
        	y = 0.26375 * safezoneH + safezoneY;
        	w = 0.21 * safezoneW;
        	h = 0.21 * safezoneH;
			colorText[] = {1,1,1,1};
        };
        class RscCurrentClass: RscStructuredText
        {
        	idc = 1100;
        	text = "CurrentClas"; //--- ToDo: Localize;
        	x = 0.4475 * safezoneW + safezoneX;
        	y = 0.42125 * safezoneH + safezoneY;
        	w = 0.13125 * safezoneW;
        	h = 0.1575 * safezoneH;
        }; 
    };		
};

class MissionMenu_Main
{
    idd = 13371337;
    movingEnabled = false;
    class controls
	{	
        class RscIAMsBkgrnd: RscText
        {
        	idc = 1605;
        
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.224375 * safezoneH + safezoneY;
        	w = 0.245 * safezoneW;
        	h = 0.5775 * safezoneH;
        	colorBackground[] = {0.2,0.2,0.2,0.8};
        };
        class RscDescBack: RscText
        {
        	idc = 1602;
        
        	x = 0.43 * safezoneW + safezoneX;
        	y = 0.224375 * safezoneH + safezoneY;
        	w = 0.42 * safezoneW;
        	h = 0.5775 * safezoneH;
        	colorBackground[] = {0.2,0.2,0.2,0.8};
        };
        class RscAMlb: RscListBox
        {
        	idc = 1500;
        
        	x = 0.15875 * safezoneW + safezoneX;
        	y = 0.26375 * safezoneH + safezoneY;
        	w = 0.2275 * safezoneW;
        	h = 0.328125 * safezoneH;
        };
        class RscIntelLb: RscListBox
        {
        	idc = 1501;
        
        	x = 0.17625 * safezoneW + safezoneX;
        	y = 0.6575 * safezoneH + safezoneY;
        	w = 0.1925 * safezoneW;
        	h = 0.13125 * safezoneH;
        };
        class RscIntelBttn: RscButton
        {
        	idc = 1600;
        
        	text = "Intel"; //--- ToDo: Localize;
        	x = 0.17625 * safezoneW + safezoneX;
        	y = 0.605 * safezoneH + safezoneY;
        	w = 0.1925 * safezoneW;
        	h = 0.039375 * safezoneH;
        };
        class RscMssnPic: RscPicture
        {
        	idc = 1200;
        
        	text = "#(argb,8,8,3)color(1,1,1,1)";
        	x = 0.47375 * safezoneW + safezoneX;
        	y = 0.250625 * safezoneH + safezoneY;
        	w = 0.3325 * safezoneW;
        	h = 0.18375 * safezoneH;
        };
        class RscMssnDesc: RscListBox
        {
        	idc = 1502;
        
        	x = 0.47375 * safezoneW + safezoneX;
        	y = 0.460625 * safezoneH + safezoneY;
        	w = 0.3325 * safezoneW;
        	h = 0.275625 * safezoneH;
        };
        class RscJoinBttn: RscButton
        {
        	idc = 1603;
        
        	text = "Join"; //--- ToDo: Localize;
        	x = 0.47375 * safezoneW + safezoneX;
        	y = 0.7625 * safezoneH + safezoneY;
        	w = 0.11375 * safezoneW;
        	h = 0.02625 * safezoneH;
        };
        class RscStrtBttn: RscButton
        {
        	idc = 1604;
        
        	text = "Start (0/5)"; //--- ToDo: Localize;
        	x = 0.6925 * safezoneW + safezoneX;
        	y = 0.7625 * safezoneH + safezoneY;
        	w = 0.11375 * safezoneW;
        	h = 0.02625 * safezoneH;
        };
        class RscAMcmBx: RscCombo
        {
        	idc = 2100;
        
        	text = "Active/All/Class sorted Missions"; //--- ToDo: Localize;
        	x = 0.15875 * safezoneW + safezoneX;
        	y = 0.2375 * safezoneH + safezoneY;
        	w = 0.2275 * safezoneW;
        	h = 0.02625 * safezoneH;
        };
		//RscButton
        class RscTopBar: RscText
        {
        	idc = 1601;
        
        	x = 0.15 * safezoneW + safezoneX;
        	y = 0.21125 * safezoneH + safezoneY;
        	w = 0.7 * safezoneW;
        	h = 0.013125 * safezoneH;
			colorBackground[] = {0.953,0.478,0.004,0.9};
        };
	};
};