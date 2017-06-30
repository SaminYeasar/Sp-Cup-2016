clear all
clc

%% Load Designed Filters


%We filter the noise from audio and find max range for grids ENF

% run('Filter_creator8th.m')

%As it takes time we saved the data required for further filtering 
%in 'filter_8th.mat' file and simplt load it.
load('filter_8th.mat')

% This represents number of powerfiles recording we have for each grid 
% Audio files are of same quantity for each grid thus we didn't need to
% specify gridwise as we did for power file

powerfile_no=[9 10 11 11 11 8 11 11 11 11 12 15 10];  

%% Normal Data Gather Start From Here
sig_index = 1;   % Comment This.. This is a counter for variable "sig" in PreProcess

grid_no = 13 ;              % grid Numbers

% each grid has individual ENF range we use 'range_MLE.m' to find that out
% run('range_MLE.m')

% creating filter and filtering data requires time thus saved the data
% beforehand 
load('Range_JAN4.mat')

%%  Gathers All the Data from A to 'grid_no' Grids
file='Train_Grid_A_P%d.wav';    

all_feat=[]; 

% for evaluating only power data we use gather_index=1:1
% for evaluating "power data" & "audio data" we use gather_index=1:1

for gather_index=1:1
    
    clear MotherPower
    for z =1:grid_no               % z Loops through the z=1,2,3..grid_no; Grids       
    run('SplitterX.m')
    all_feat{z}=MotherPower;
    file(12)=char(z+65);           % Changes The Letter of Grid in File Names                              
    end

    if gather_index==1
        Power_Feat = all_feat;  N=2;
        all_feat=[];
        file='Train_Grid_A_A%d.wav';
    
    elseif gather_index==2
        Audio_Feat = all_feat; grid_no =1; N=50;   % N=50
        all_feat=[];
        file='Practice_%d.wav';
    elseif gather_index==3
        Practice_Feat = all_feat; grid_no =1; N=100;  % N=100
        file='Test_%d.wav';
    else 
        Test_Feat = all_feat;
        
    end
end





VarName = {'MEAN', 'v', 'd_range', 'vA9' ,'vD1' ,'vD2' ,'vD3' ,'vD4' ,'vD5',...
                'vD6', 'vD7', 'vD8', 'vD9', 'a1', 'a2','log_c',...
                'p1','p2','p3','p4','p5','p6','p7','p8'...
                'm1','m2','m3','m4','m5','m6','m7','m8'};

% for individual Tab we get, we use them in "classification learner" app
% from matlab to get efficiency for proposed features

[PowerTab] = GetTabFeat( Power_Feat,VarName, 1 );

[AudioTab] = GetTabFeat( Audio_Feat,VarName, 2 );

[AllTab] = GetTabFeat( [ Power_Feat  Audio_Feat],VarName, 3 );














%% New Normalization


             
break




% For Practice Data
run('AudioPowerDetect.m')

[ALabel]= ANormal(Power_Feat, Audio_Feat,Practice_Feat,AudioIn);
[PLabel]= PNormal(Power_Feat,Practice_Feat,PowerIn);

LABEL(PowerIn) = PLabel;
LABEL(AudioIn) = ALabel;
PracticeLABEL = LABEL;

clear PowerIn
clear AudioIn

% For Test Data
run('AudioPowerDetect100.m')

[ALabelT]= ANormal(Power_Feat, Audio_Feat,Test_Feat,AudioIn);
[PLabelT]= PNormal(Power_Feat,Test_Feat,PowerIn);

LABELT(PowerIn) = PLabelT;
LABELT(AudioIn) = ALabelT;
TestLABEL = LABELT;
 

PracticeLABEL
TestLABEL




