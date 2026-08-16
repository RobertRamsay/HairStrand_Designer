// Alarm 2 normally plays the legacy notification sound. During a project load
// clearOverrides() arms this alarm as a one-frame-later V1.85 colour recovery,
// after the old loader has finished and closed the file.
if variable_instance_exists(id,"v185ColourLoadNeedsRecovery") and v185ColourLoadNeedsRecovery==1
	{
	v185ColourLoadNeedsRecovery=0
	
	var _colourLoadPath=""
	if variable_instance_exists(id,"lastFileName") and lastFileName!="" and file_exists(lastFileName)
		_colourLoadPath=lastFileName
	else if variable_instance_exists(id,"fileCustom") and fileCustom!="" and file_exists(fileCustom)
		_colourLoadPath=fileCustom
	
	var _loadedVersion=0
	var _versionPos=string_pos("Version",mainS)
	if _versionPos>0 _loadedVersion=real(string_copy(mainS,_versionPos+7,4))
	
	var _foundColourBlock=0
	
	if _colourLoadPath!="" and _loadedVersion>=1.85
		{
		var _colourFile=file_text_open_read(_colourLoadPath)
		if _colourFile!=-1
			{
			var _line=""
			while !file_text_eof(_colourFile) and _foundColourBlock==0
				{
				_line=file_text_read_string(_colourFile)
				file_text_readln(_colourFile)
				if _line=="V1.85 - Per Set Colour Overrides" _foundColourBlock=1
				}
			
			if _foundColourBlock==1 and !file_text_eof(_colourFile)
				{
				// Two 1.85 layouts have existed during development:
				// 1) manual save: marker, four globals, then 11 set records
				// 2) autosave:    marker, then 11 set records (globals are earlier)
				// Accept both so no existing 1.85 work is stranded.
				_line=file_text_read_string(_colourFile)
				file_text_readln(_colourFile)
				
				var _firstSet=0
				if string_pos("globalColVarA:",_line)==1
					{
					globalColVarA=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); globalColVarB=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); globalRootCol=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); globalTipCol=real(analiseString(_line))
					}
				else
					{
					// Old/current autosave layout: the first line already belongs to set 0.
					setColVarAOverrode[0]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setColVarA[0]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setColVarBOverrode[0]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setColVarB[0]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setRootColOverrode[0]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setRootCol[0]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setTipColOverrode[0]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setTipCol[0]=real(analiseString(_line))
					_firstSet=1
					}
				
				for (var _set=_firstSet;_set<11;_set++)
					{
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setColVarAOverrode[_set]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setColVarA[_set]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setColVarBOverrode[_set]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setColVarB[_set]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setRootColOverrode[_set]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setRootCol[_set]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setTipColOverrode[_set]=real(analiseString(_line))
					_line=file_text_read_string(_colourFile); file_text_readln(_colourFile); setTipCol[_set]=real(analiseString(_line))
					}
				}
			
			file_text_close(_colourFile)
			}
		}
	
	// Legacy file, malformed 1.85 file, or a 1.85 file made before the colour
	// block existed: its normal four colours become globals and all sets inherit.
	if _foundColourBlock==0
		{
		globalColVarA=customColVarA
		globalColVarB=customColVarB
		globalRootCol=customRootCol
		globalTipCol=customTipCol
		
		for (var _legacySet=0;_legacySet<maxSets;_legacySet++)
			{
			setColVarA[_legacySet]=globalColVarA
			setColVarB[_legacySet]=globalColVarB
			setRootCol[_legacySet]=globalRootCol
			setTipCol[_legacySet]=globalTipCol
			setColVarAOverrode[_legacySet]=0
			setColVarBOverrode[_legacySet]=0
			setRootColOverrode[_legacySet]=0
			setTipColOverrode[_legacySet]=0
			}
		}
	
	// Keep unused future set slots sane without touching the loaded 0..10 data.
	for (var _extraSet=11;_extraSet<maxSets;_extraSet++)
		{
		setColVarA[_extraSet]=globalColVarA
		setColVarB[_extraSet]=globalColVarB
		setRootCol[_extraSet]=globalRootCol
		setTipCol[_extraSet]=globalTipCol
		setColVarAOverrode[_extraSet]=0
		setColVarBOverrode[_extraSet]=0
		setRootColOverrode[_extraSet]=0
		setTipColOverrode[_extraSet]=0
		}
	
	// Loads return to global editing; the per-set arrays remain authoritative
	// and are exposed when the user selects each set.
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
	pleaseGen=true
	
	// Compatibility decision is complete; future saves are current-format.
	mainS="Hair Strand Designer - Project File - Version1.85.0 - 16thAug2026 (C) Robert Ramsay"
	}
else
	{
	audio_play_sound(Sound1,1,0)
	}