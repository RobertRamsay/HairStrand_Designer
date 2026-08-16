//fix 17th May 2021 / edite 22nd may 2023 (about 2 years later haha)
//if maxScale<minScale maxScale=minScale

// -----------------------------------------------------------------------------
// PER-SET COLOUR OVERRIDES
// Mirrors the existing strand length/count override behaviour:
// - no selected set: edit the global colour and propagate to non-overridden sets
// - selected set: edit only that set and mark that colour channel overridden
// -----------------------------------------------------------------------------
if !variable_instance_exists(id,"setColourOverridesReady")
	{
	globalColVarA=customColVarA
	globalColVarB=customColVarB
	globalRootCol=customRootCol
	globalTipCol=customTipCol
	
	for (var _colourSet=0;_colourSet<maxSets;_colourSet++)
		{
		setColVarA[_colourSet]=globalColVarA
		setColVarB[_colourSet]=globalColVarB
		setRootCol[_colourSet]=globalRootCol
		setTipCol[_colourSet]=globalTipCol
		
		setColVarAOverrode[_colourSet]=0
		setColVarBOverrode[_colourSet]=0
		setRootColOverrode[_colourSet]=0
		setTipColOverrode[_colourSet]=0
		}
	
	colourUiLastA=customColVarA
	colourUiLastB=customColVarB
	colourUiLastRoot=customRootCol
	colourUiLastTip=customTipCol
	colourUiLastSet=setSelectedID
	setColourOverridesReady=1
	}

// Per-set colour data did not exist before project format 1.85.
// If an older project/autosave is loaded, deliberately ignore any accidental
// trailing colour block and treat its four legacy colours as global-only.
// Once converted in memory, future saves use the current 1.85 project header.
var _colourProjectVersion=real(string_copy(mainS,46,4))
if _colourProjectVersion<1.85 and !loading
	{
	globalColVarA=customColVarA
	globalColVarB=customColVarB
	globalRootCol=customRootCol
	globalTipCol=customTipCol
	
	for (var _legacyColourSet=0;_legacyColourSet<maxSets;_legacyColourSet++)
		{
		setColVarA[_legacyColourSet]=globalColVarA
		setColVarB[_legacyColourSet]=globalColVarB
		setRootCol[_legacyColourSet]=globalRootCol
		setTipCol[_legacyColourSet]=globalTipCol
		setColVarAOverrode[_legacyColourSet]=0
		setColVarBOverrode[_legacyColourSet]=0
		setRootColOverrode[_legacyColourSet]=0
		setTipColOverrode[_legacyColourSet]=0
		}
	
	mainS="Hair Strand Designer - Project File - Version1.85.0 - 16thAug2026 (C) Robert Ramsay"
	colourUiLastA=customColVarA
	colourUiLastB=customColVarB
	colourUiLastRoot=customRootCol
	colourUiLastTip=customTipCol
	colourUiLastSet=setSelectedID
	}

var _colourChanged=0

// Variation A
if customColVarA!=colourUiLastA
	{
	if setSelectedID!=-1
		{
		setColVarA[setSelectedID]=customColVarA
		setColVarAOverrode[setSelectedID]=1
		}
	else
		{
		globalColVarA=customColVarA
		for (var _setA=0;_setA<maxSets;_setA++)
			{
			if setColVarAOverrode[_setA]!=1 setColVarA[_setA]=globalColVarA
			}
		}
	_colourChanged=1
	}

// Variation B
if customColVarB!=colourUiLastB
	{
	if setSelectedID!=-1
		{
		setColVarB[setSelectedID]=customColVarB
		setColVarBOverrode[setSelectedID]=1
		}
	else
		{
		globalColVarB=customColVarB
		for (var _setB=0;_setB<maxSets;_setB++)
			{
			if setColVarBOverrode[_setB]!=1 setColVarB[_setB]=globalColVarB
			}
		}
	_colourChanged=1
	}

// Root colour
if customRootCol!=colourUiLastRoot
	{
	if setSelectedID!=-1
		{
		setRootCol[setSelectedID]=customRootCol
		setRootColOverrode[setSelectedID]=1
		}
	else
		{
		globalRootCol=customRootCol
		for (var _setRoot=0;_setRoot<maxSets;_setRoot++)
			{
			if setRootColOverrode[_setRoot]!=1 setRootCol[_setRoot]=globalRootCol
			}
		}
	_colourChanged=1
	}

// Tip colour
if customTipCol!=colourUiLastTip
	{
	if setSelectedID!=-1
		{
		setTipCol[setSelectedID]=customTipCol
		setTipColOverrode[setSelectedID]=1
		}
	else
		{
		globalTipCol=customTipCol
		for (var _setTip=0;_setTip<maxSets;_setTip++)
			{
			if setTipColOverrode[_setTip]!=1 setTipCol[_setTip]=globalTipCol
			}
		}
	_colourChanged=1
	}

// F4: reset the selected set's colour overrides to the globals.
if keyboard_check_pressed(vk_f4) and setSelectedID!=-1
	{
	var _resetColourSet=setSelectedID
	setColVarAOverrode[_resetColourSet]=0
	setColVarBOverrode[_resetColourSet]=0
	setRootColOverrode[_resetColourSet]=0
	setTipColOverrode[_resetColourSet]=0
	setColVarA[_resetColourSet]=globalColVarA
	setColVarB[_resetColourSet]=globalColVarB
	setRootCol[_resetColourSet]=globalRootCol
	setTipCol[_resetColourSet]=globalTipCol
	_colourChanged=1
	}

// F5: reset all colour overrides, matching the existing all-override reset.
if keyboard_check_pressed(vk_f5)
	{
	for (var _resetAllColours=0;_resetAllColours<maxSets;_resetAllColours++)
		{
		setColVarAOverrode[_resetAllColours]=0
		setColVarBOverrode[_resetAllColours]=0
		setRootColOverrode[_resetAllColours]=0
		setTipColOverrode[_resetAllColours]=0
		setColVarA[_resetAllColours]=globalColVarA
		setColVarB[_resetAllColours]=globalColVarB
		setRootCol[_resetAllColours]=globalRootCol
		setTipCol[_resetAllColours]=globalTipCol
		}
	_colourChanged=1
	}

if _colourChanged==1
	{
	if color_GenState==2 color_GenState=1
	colorOnlyUpdate=1
	previewCanvasComplete=0
	forceUpdate=1
	}

// Expose the correct colours to the existing colour UI.  This means the old
// picker/swatch code does not need to know anything about the override arrays.
if setSelectedID!=-1
	{
	customColVarA=setColVarA[setSelectedID]
	customColVarB=setColVarB[setSelectedID]
	customRootCol=setRootCol[setSelectedID]
	customTipCol=setTipCol[setSelectedID]
	}
else
	{
	customColVarA=globalColVarA
	customColVarB=globalColVarB
	customRootCol=globalRootCol
	customTipCol=globalTipCol
	}

// When switching between global/set editing, make the active colour picker
// follow the newly exposed colour instead of retaining the previous set's value.
if colourUiLastSet!=setSelectedID
	{
	if bkCol_active==1   newColor=colrBack
	if ColA_active==1    newColor=customColVarA
	if ColB_active==1    newColor=customColVarB
	if RootCol_active==1 newColor=customRootCol
	if TipCol_active==1  newColor=customTipCol
	}

colourUiLastA=customColVarA
colourUiLastB=customColVarB
colourUiLastRoot=customRootCol
colourUiLastTip=customTipCol
colourUiLastSet=setSelectedID

// -----------------------------------------------------------------------------
// COLOUR HISTORY: ONLY COMMIT ON A REAL LEFT CLICK
// The legacy Draw event's five colour swatch handlers run from mouse position
// alone, so merely hovering currently writes hCol[] and advances the history.
// Keep its normal click behaviour, but redirect hover-only writes to hCol[24],
// which is outside the 24 visible history slots (0..23).
// -----------------------------------------------------------------------------
if !variable_instance_exists(id,"colourHistoryHoverSuppressed")
	{
	colourHistoryHoverSuppressed=0
	colourHistorySavedPointer=colorHistoryPointer
	}

var _overColourSourceSwatch =
	mouse_x>1568 and mouse_x<1632 and
	(
		(mouse_y>541 and mouse_y<564) or
		(mouse_y>568 and mouse_y<590) or
		(mouse_y>594 and mouse_y<618) or
		(mouse_y>621 and mouse_y<645) or
		(mouse_y>649 and mouse_y<671)
	)

if _overColourSourceSwatch and !mouse_check_button_pressed(mb_left)
	{
	if colourHistoryHoverSuppressed==0
		{
		colourHistorySavedPointer=colorHistoryPointer
		colourHistoryHoverSuppressed=1
		}
	
	// Draw_0 may write/increment/wrap this during hover. Reset it to the dummy
	// slot every Step so no visible history entry is changed.
	colorHistoryPointer=24
	}
else
	{
	if colourHistoryHoverSuppressed==1
		{
		// Restore the real insertion point before Draw_0 sees an actual click,
		// or when the cursor leaves the colour-source swatches.
		colorHistoryPointer=colourHistorySavedPointer
		colourHistoryHoverSuppressed=0
		}
	}
