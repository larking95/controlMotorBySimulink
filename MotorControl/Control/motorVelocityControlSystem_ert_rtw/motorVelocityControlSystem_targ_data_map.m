  function targMap = targDataMap(),

  ;%***********************
  ;% Create Parameter Map *
  ;%***********************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 4;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc paramMap
    ;%
    paramMap.nSections           = nTotSects;
    paramMap.sectIdxOffset       = sectIdxOffset;
      paramMap.sections(nTotSects) = dumSection; %prealloc
    paramMap.nTotData            = -1;
    
    ;%
    ;% Auto data (bsfk5xylsp)
    ;%
      section.nData     = 3;
      section.data(3)  = dumData; %prealloc
      
	  ;% bsfk5xylsp.Tend
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% bsfk5xylsp.Ts
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% bsfk5xylsp.Tstep
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(1) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% bsfk5xylsp.PWM_pinNumber
	  section.data(1).logicalSrcIdx = 3;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(2) = section;
      clear section
      
      section.nData     = 16;
      section.data(16)  = dumData; %prealloc
      
	  ;% bsfk5xylsp.Gain1_Gain
	  section.data(1).logicalSrcIdx = 4;
	  section.data(1).dtTransOffset = 0;
	
	  ;% bsfk5xylsp.Constant_Value
	  section.data(2).logicalSrcIdx = 5;
	  section.data(2).dtTransOffset = 1;
	
	  ;% bsfk5xylsp.Step1_Y0
	  section.data(3).logicalSrcIdx = 6;
	  section.data(3).dtTransOffset = 2;
	
	  ;% bsfk5xylsp.Step1_YFinal
	  section.data(4).logicalSrcIdx = 7;
	  section.data(4).dtTransOffset = 3;
	
	  ;% bsfk5xylsp.Gain_Gain
	  section.data(5).logicalSrcIdx = 8;
	  section.data(5).dtTransOffset = 4;
	
	  ;% bsfk5xylsp.Internal_A
	  section.data(6).logicalSrcIdx = 9;
	  section.data(6).dtTransOffset = 5;
	
	  ;% bsfk5xylsp.Internal_C
	  section.data(7).logicalSrcIdx = 10;
	  section.data(7).dtTransOffset = 7;
	
	  ;% bsfk5xylsp.Internal_D
	  section.data(8).logicalSrcIdx = 11;
	  section.data(8).dtTransOffset = 9;
	
	  ;% bsfk5xylsp.Internal_InitialCondition
	  section.data(9).logicalSrcIdx = 12;
	  section.data(9).dtTransOffset = 10;
	
	  ;% bsfk5xylsp.Gain_Gain_cshgyaw55z
	  section.data(10).logicalSrcIdx = 13;
	  section.data(10).dtTransOffset = 11;
	
	  ;% bsfk5xylsp.Saturation_UpperSat
	  section.data(11).logicalSrcIdx = 14;
	  section.data(11).dtTransOffset = 12;
	
	  ;% bsfk5xylsp.Saturation_LowerSat
	  section.data(12).logicalSrcIdx = 15;
	  section.data(12).dtTransOffset = 13;
	
	  ;% bsfk5xylsp.Constant1_Value
	  section.data(13).logicalSrcIdx = 16;
	  section.data(13).dtTransOffset = 14;
	
	  ;% bsfk5xylsp.Constant2_Value
	  section.data(14).logicalSrcIdx = 17;
	  section.data(14).dtTransOffset = 15;
	
	  ;% bsfk5xylsp.Step_Y0
	  section.data(15).logicalSrcIdx = 18;
	  section.data(15).dtTransOffset = 16;
	
	  ;% bsfk5xylsp.Step_YFinal
	  section.data(16).logicalSrcIdx = 19;
	  section.data(16).dtTransOffset = 17;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(3) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% bsfk5xylsp.AnalogInput_p1
	  section.data(1).logicalSrcIdx = 20;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(4) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (parameter)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    paramMap.nTotData = nTotData;
    


  ;%**************************
  ;% Create Block Output Map *
  ;%**************************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc sigMap
    ;%
    sigMap.nSections           = nTotSects;
    sigMap.sectIdxOffset       = sectIdxOffset;
      sigMap.sections(nTotSects) = dumSection; %prealloc
    sigMap.nTotData            = -1;
    
    ;%
    ;% Auto data (imycjoeyihk)
    ;%
      section.nData     = 4;
      section.data(4)  = dumData; %prealloc
      
	  ;% imycjoeyihk.iwqepvfje0
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% imycjoeyihk.lzu5yrkioz
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% imycjoeyihk.jmnid25et0
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% imycjoeyihk.gfdxjcrums
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (signal)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    sigMap.nTotData = nTotData;
    


  ;%*******************
  ;% Create DWork Map *
  ;%*******************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 4;
    sectIdxOffset = 1;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc dworkMap
    ;%
    dworkMap.nSections           = nTotSects;
    dworkMap.sectIdxOffset       = sectIdxOffset;
      dworkMap.sections(nTotSects) = dumSection; %prealloc
    dworkMap.nTotData            = -1;
    
    ;%
    ;% Auto data (mqhgc113vhe)
    ;%
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% mqhgc113vhe.oydhifu0e1
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(1) = section;
      clear section
      
      section.nData     = 6;
      section.data(6)  = dumData; %prealloc
      
	  ;% mqhgc113vhe.adu0petz40.LoggedData
	  section.data(1).logicalSrcIdx = 1;
	  section.data(1).dtTransOffset = 0;
	
	  ;% mqhgc113vhe.ayyitd3exp.LoggedData
	  section.data(2).logicalSrcIdx = 2;
	  section.data(2).dtTransOffset = 2;
	
	  ;% mqhgc113vhe.istvnh5qwa.LoggedData
	  section.data(3).logicalSrcIdx = 3;
	  section.data(3).dtTransOffset = 3;
	
	  ;% mqhgc113vhe.ky5pc2mqvy.LoggedData
	  section.data(4).logicalSrcIdx = 4;
	  section.data(4).dtTransOffset = 4;
	
	  ;% mqhgc113vhe.b1o5bzkxp3.LoggedData
	  section.data(5).logicalSrcIdx = 5;
	  section.data(5).dtTransOffset = 5;
	
	  ;% mqhgc113vhe.dmqghyptpi.LoggedData
	  section.data(6).logicalSrcIdx = 6;
	  section.data(6).dtTransOffset = 6;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(2) = section;
      clear section
      
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% mqhgc113vhe.earz0snvhp
	  section.data(1).logicalSrcIdx = 7;
	  section.data(1).dtTransOffset = 0;
	
	  ;% mqhgc113vhe.gjww3ltlzz
	  section.data(2).logicalSrcIdx = 8;
	  section.data(2).dtTransOffset = 1;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(3) = section;
      clear section
      
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% mqhgc113vhe.o2cj1bhzls
	  section.data(1).logicalSrcIdx = 9;
	  section.data(1).dtTransOffset = 0;
	
	  ;% mqhgc113vhe.ep5ntgvi2h
	  section.data(2).logicalSrcIdx = 10;
	  section.data(2).dtTransOffset = 1;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(4) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (dwork)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    dworkMap.nTotData = nTotData;
    


  ;%
  ;% Add individual maps to base struct.
  ;%

  targMap.paramMap  = paramMap;    
  targMap.signalMap = sigMap;
  targMap.dworkMap  = dworkMap;
  
  ;%
  ;% Add checksums to base struct.
  ;%


  targMap.checksum0 = 595658576;
  targMap.checksum1 = 1870964496;
  targMap.checksum2 = 2686241819;
  targMap.checksum3 = 1884913451;

