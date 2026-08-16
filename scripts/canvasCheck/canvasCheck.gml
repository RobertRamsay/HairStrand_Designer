// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function canvasCheck(){
// canvasCheck: called every Step_2.
// GML surfaces can be silently purged by the OS (alt-tab, window resize, VRAM pressure).
// This detects any lost surface and recreates only what's missing, then forces a redraw.
// NOTE: content is lost when a surface disappears - a full redraw (forceUpdate) is needed.

	var _surfaceLost = false

	// Check and individually recreate each lost surface
	if !surface_exists(canvas) {
		canvas = surface_create(surfSize, surfSize)
		surface_set_target(canvas)
			draw_clear_alpha(c_black, 0)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(flow_canvas) {
		flow_canvas = surface_create(surfSize, surfSize)
		surface_set_target(flow_canvas)
			draw_set_color(make_color_rgb(0,0,0))
			draw_rectangle(0, 0, surfSize-1, surfSize-1, 0)
			draw_set_color(c_white)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(mask_canvas) {
		mask_canvas = surface_create(surfSize, surfSize)
		surface_set_target(mask_canvas)
			draw_clear_alpha(c_black, 0)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(nm_canvas) {
		nm_canvas = surface_create(surfSize, surfSize)
		surface_set_target(nm_canvas)
			draw_set_color(make_color_rgb(0,0,0))
			draw_rectangle(0, 0, surfSize-1, surfSize-1, 0)
			draw_set_color(c_white)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(id_canvas) {
		id_canvas = surface_create(surfSize, surfSize)
		surface_set_target(id_canvas)
			draw_clear_alpha(c_black, 0)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(color_canvas) {
		color_canvas = surface_create(surfSize, surfSize)
		surface_set_target(color_canvas)
			draw_clear_alpha(c_black, 0)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(depth_canvas) {
		depth_canvas = surface_create(surfSize, surfSize)
		surface_set_target(depth_canvas)
			draw_clear_alpha(c_black, 0)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(ao_canvas) {
		ao_canvas = surface_create(surfSize, surfSize)
		surface_set_target(ao_canvas)
			draw_set_color(make_color_rgb(200,200,200))
			draw_rectangle(0, 0, surfSize-1, surfSize-1, 0)
			draw_set_color(c_white)
			if sprite_exists(aoSprite) draw_sprite(aoSprite, 0, 0, 0)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(frizz_canvas) {
		frizz_canvas = surface_create(surfSize, surfSize)
		surface_set_target(frizz_canvas)
			draw_clear_alpha(c_black, 0)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(blurSurface) {
		blurSurface = surface_create(surfSize, surfSize)
		surface_set_target(blurSurface)
			draw_clear_alpha(c_white, 1)
		surface_reset_target()
		_surfaceLost = true
	}
	if !surface_exists(tNormsurf) {
		tNormsurf = surface_create(surfSize, surfSize)
		surface_set_target(tNormsurf)
			draw_set_color(make_color_rgb(0,0,0))
			draw_rectangle(0, 0, surfSize-1, surfSize-1, 0)
			draw_set_color(c_white)
		surface_reset_target()
		_surfaceLost = true
	}

	// Also check the preview surfaces
	for (var _ps = 0; _ps < 11; _ps++) {
		if !surface_exists(previewSurf[_ps]) {
			previewSurf[_ps] = surface_create(1024, 1024)
			_surfaceLost = true
		}
	}

	// If anything was lost, force a full preview redraw so content is regenerated
	if _surfaceLost {
		forceUpdate  = 1
		//previewCanvasComplete = 0
	}

	// -------------------------------------------------------------------------
	// V1.85 MANUAL PROJECT COLOUR PERSISTENCE
	//
	// The legacy S/L key events explicitly call keyboard_key_release() before
	// End Step.  Therefore the old Step_2 code that waited for *_pressed could
	// miss the operation entirely.  canvasCheck() runs at the start of End Step,
	// so use the forced release as the reliable "project IO has finished" signal.
	// -------------------------------------------------------------------------

	// Manual SAVE: the normal project file has already been written and closed.
	// Append an authoritative block containing true globals plus every set value.
	if keyboard_check_released(ord("S")) and fileCustom!="" and file_exists(fileCustom) and !autosaving
		{
		var _colourSaveFile=file_text_open_append(fileCustom)
		if _colourSaveFile!=-1
			{
			file_text_write_string(_colourSaveFile,"V1.85 - Per Set Colour Overrides")
			file_text_writeln(_colourSaveFile)

			file_text_write_string(_colourSaveFile,"globalColVarA:"+string(globalColVarA)+";")
			file_text_writeln(_colourSaveFile)
			file_text_write_string(_colourSaveFile,"globalColVarB:"+string(globalColVarB)+";")
			file_text_writeln(_colourSaveFile)
			file_text_write_string(_colourSaveFile,"globalRootCol:"+string(globalRootCol)+";")
			file_text_writeln(_colourSaveFile)
			file_text_write_string(_colourSaveFile,"globalTipCol:"+string(globalTipCol)+";")
			file_text_writeln(_colourSaveFile)

			for (var _colourSaveSet=0;_colourSaveSet<11;_colourSaveSet++)
				{
				file_text_write_string(_colourSaveFile,"setColVarAOverrode["+string(_colourSaveSet)+"]:"+string(setColVarAOverrode[_colourSaveSet])+";")
				file_text_writeln(_colourSaveFile)
				file_text_write_string(_colourSaveFile,"setColVarA["+string(_colourSaveSet)+"]:"+string(setColVarA[_colourSaveSet])+";")
				file_text_writeln(_colourSaveFile)
				file_text_write_string(_colourSaveFile,"setColVarBOverrode["+string(_colourSaveSet)+"]:"+string(setColVarBOverrode[_colourSaveSet])+";")
				file_text_writeln(_colourSaveFile)
				file_text_write_string(_colourSaveFile,"setColVarB["+string(_colourSaveSet)+"]:"+string(setColVarB[_colourSaveSet])+";")
				file_text_writeln(_colourSaveFile)
				file_text_write_string(_colourSaveFile,"setRootColOverrode["+string(_colourSaveSet)+"]:"+string(setRootColOverrode[_colourSaveSet])+";")
				file_text_writeln(_colourSaveFile)
				file_text_write_string(_colourSaveFile,"setRootCol["+string(_colourSaveSet)+"]:"+string(setRootCol[_colourSaveSet])+";")
				file_text_writeln(_colourSaveFile)
				file_text_write_string(_colourSaveFile,"setTipColOverrode["+string(_colourSaveSet)+"]:"+string(setTipColOverrode[_colourSaveSet])+";")
				file_text_writeln(_colourSaveFile)
				file_text_write_string(_colourSaveFile,"setTipCol["+string(_colourSaveSet)+"]:"+string(setTipCol[_colourSaveSet])+";")
				file_text_writeln(_colourSaveFile)
				}

			file_text_close(_colourSaveFile)
			}
		}

	// Manual LOAD: legacy loader has finished, closed the file, and loaded mainS.
	if keyboard_check_released(ord("L")) and fileCustom!="" and file_exists(fileCustom)
		{
		// Parse version by label rather than a fixed character offset. This stays
		// safe if the project/header name changes again.
		var _versionPos=string_pos("Version",mainS)
		var _loadedProjectVersion=0
		if _versionPos>0 _loadedProjectVersion=real(string_copy(mainS,_versionPos+7,4))

		var _colourReadFile=file_text_open_read(fileCustom)
		var _foundColourBlock=0
		var _colourLine=""

		if _colourReadFile!=-1 and _loadedProjectVersion>=1.85
			{
			while !file_text_eof(_colourReadFile) and _foundColourBlock==0
				{
				_colourLine=file_text_read_string(_colourReadFile)
				file_text_readln(_colourReadFile)
				if _colourLine=="V1.85 - Per Set Colour Overrides" _foundColourBlock=1
				}

			if _foundColourBlock==1
				{
				_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); globalColVarA=real(analiseString(_colourLine))
				_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); globalColVarB=real(analiseString(_colourLine))
				_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); globalRootCol=real(analiseString(_colourLine))
				_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); globalTipCol=real(analiseString(_colourLine))

				for (var _colourLoadSet=0;_colourLoadSet<11;_colourLoadSet++)
					{
					_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); setColVarAOverrode[_colourLoadSet]=real(analiseString(_colourLine))
					_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); setColVarA[_colourLoadSet]=real(analiseString(_colourLine))
					_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); setColVarBOverrode[_colourLoadSet]=real(analiseString(_colourLine))
					_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); setColVarB[_colourLoadSet]=real(analiseString(_colourLine))
					_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); setRootColOverrode[_colourLoadSet]=real(analiseString(_colourLine))
					_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); setRootCol[_colourLoadSet]=real(analiseString(_colourLine))
					_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); setTipColOverrode[_colourLoadSet]=real(analiseString(_colourLine))
					_colourLine=file_text_read_string(_colourReadFile); file_text_readln(_colourReadFile); setTipCol[_colourLoadSet]=real(analiseString(_colourLine))
					}
				}
			}

		if _colourReadFile!=-1 file_text_close(_colourReadFile)

		// Legacy project, or a 1.85 project saved before the colour block existed:
		// use its normal four colours globally and clear only colour override flags.
		if _foundColourBlock==0
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
			}

		for (var _extraColourSet=11;_extraColourSet<maxSets;_extraColourSet++)
			{
			setColVarA[_extraColourSet]=globalColVarA
			setColVarB[_extraColourSet]=globalColVarB
			setRootCol[_extraColourSet]=globalRootCol
			setTipCol[_extraColourSet]=globalTipCol
			setColVarAOverrode[_extraColourSet]=0
			setColVarBOverrode[_extraColourSet]=0
			setRootColOverrode[_extraColourSet]=0
			setTipColOverrode[_extraColourSet]=0
			}

		setColourOverridesReady=1
		customColVarA=globalColVarA
		customColVarB=globalColVarB
		customRootCol=globalRootCol
		customTipCol=globalTipCol
		colourUiLastA=customColVarA
		colourUiLastB=customColVarB
		colourUiLastRoot=customRootCol
		colourUiLastTip=customTipCol
		colourUiLastSet=setSelectedID

		// Keep the newer click-only colour selector in sync with the loaded data.
		if variable_instance_exists(id,"colourSelectedSlot")
			{
			if colourSelectedSlot==0 colourSelectedStoreColor=colrBack
			if colourSelectedSlot==1 colourSelectedStoreColor=customColVarA
			if colourSelectedSlot==2 colourSelectedStoreColor=customColVarB
			if colourSelectedSlot==3 colourSelectedStoreColor=customRootCol
			if colourSelectedSlot==4 colourSelectedStoreColor=customTipCol
			}

		if bkCol_active==1   newColor=colrBack
		if ColA_active==1    newColor=customColVarA
		if ColB_active==1    newColor=customColVarB
		if RootCol_active==1 newColor=customRootCol
		if TipCol_active==1  newColor=customTipCol

		colorOnlyUpdate=1
		previewCanvasComplete=0
		forceUpdate=1

		// Compatibility has been resolved. Future saves from this running build
		// are always current-format 1.85 files.
		mainS="Hair Strand Designer - Project File - Version1.85.0 - 16thAug2026 (C) Robert Ramsay"
		}

}
