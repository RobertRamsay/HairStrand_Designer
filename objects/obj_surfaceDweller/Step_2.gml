/// @description Step 2 
// You can write your code in this editor
// draw color highlights
debugMsg="End Step"
canvasCheck()
if bkCol_active==1 
	{
		if keyboard_check(vk_alt) and mouse_check_button_pressed(mb_right)  and !( mouse_x>=0 and mouse_x<1024 and mouse_y>1024 and mouse_y<1080) // set panel area excluded
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			colrBack=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 

	if mouse_x>=1644 and mouse_x<=1899 and ( (mouse_y>=542 and mouse_y<=720) or (mouse_y>=743 and mouse_y<=753))
	// in palette?
		{
		if mouse_check_button(mb_left)
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			colrBack=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 
		}
	}

if mouse_check_button_released(mb_left)
	{
		doAutoSave()
	}


if ColA_active==1 
	{

	if keyboard_check(vk_alt)  and mouse_check_button_pressed(mb_right) and!( mouse_x>=0 and mouse_x<1024 and mouse_y>1024 and mouse_y<1080) // set panel area excluded
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			customColVarA=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 
	if mouse_x>=1644 and mouse_x<=1899 and ( (mouse_y>=542 and mouse_y<=720) or (mouse_y>=743 and mouse_y<=753))
		{
		if mouse_check_button(mb_left)
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			customColVarA=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 
		}
	}
	
if ColB_active==1 
	{
			if keyboard_check(vk_alt)  and mouse_check_button_pressed(mb_right) and !( mouse_x>=0 and mouse_x<1024 and mouse_y>1024 and mouse_y<1080) // set panel area excluded
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			customColVarB=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 
	if mouse_x>=1644 and mouse_x<=1899 and ( (mouse_y>=542 and mouse_y<=720) or (mouse_y>=743 and mouse_y<=753))
		{
		if mouse_check_button(mb_left)
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			customColVarB=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 
		}
	}

if RootCol_active==1 
	{
	if keyboard_check(vk_alt)  and mouse_check_button_pressed(mb_right) and  !( mouse_x>=0 and mouse_x<1024 and mouse_y>1024 and mouse_y<1080) // set panel area excluded
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			customRootCol=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 

		
	draw_sprite(spr_colHL,0,1566,550+128)
if mouse_x>=1644 and mouse_x<=1899 and ( (mouse_y>=542 and mouse_y<=720) or (mouse_y>=743 and mouse_y<=753))
		{
		if mouse_check_button(mb_left)
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			customRootCol=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 
		}
	}

if TipCol_active==1 
	{
				if keyboard_check(vk_alt) and mouse_check_button_pressed(mb_right) and  !( mouse_x>=0 and mouse_x<1024 and mouse_y>1024 and mouse_y<1080) // set panel area excluded
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			customTipCol=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 
	draw_sprite(spr_colHL,0,1566,550+192)
	if mouse_x>=1644 and mouse_x<=1899 and ( (mouse_y>=542 and mouse_y<=720) or (mouse_y>=743 and mouse_y<=753))
		{
		if mouse_check_button(mb_left)
			{
			if color_GenState==2 {color_GenState=1;}
			getColorPick=draw_getpixel(device_mouse_raw_x(0), device_mouse_raw_y(0))
			customTipCol=getColorPick
			newColor=getColorPick
			colorOnlyUpdate=1
			previewCanvasComplete=0
			forceUpdate=1
			} 
		}
	}

// The final renderer still consumes the original custom colour variables.
// Feed it the colour set for the batch currently being rendered, then restore
// the UI-facing colours immediately afterwards.
var _uiColVarA=customColVarA
var _uiColVarB=customColVarB
var _uiRootCol=customRootCol
var _uiTipCol=customTipCol
var _swapRenderColours=(renderF>=0 and renderF<11)

if _swapRenderColours
	{
	customColVarA=setColVarA[renderF]
	customColVarB=setColVarB[renderF]
	customRootCol=setRootCol[renderF]
	customTipCol=setTipCol[renderF]
	}

doMainStep()

if _swapRenderColours
	{
	customColVarA=_uiColVarA
	customColVarB=_uiColVarB
	customRootCol=_uiRootCol
	customTipCol=_uiTipCol
	}
