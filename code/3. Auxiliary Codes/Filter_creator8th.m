har_no = 8;
%% 60 Hertz
%     band_low60 = 59.6 ; band_high60 = 60.4;
%     sig_low60 =59.94  ; sig_high60 =60.06;
Dn = 60 - band_low60; 
Ds = 60 - sig_low60 ;

   for i = 1:har_no
        if i == 2
        f1= band_low60*i +(.8*Dn); f2=band_high60*i -(.8*Dn); 
        F1= sig_low60 *i ; F2=sig_high60*i ;
        
        else if i == 4
        f1= band_low60*i +(1.7*Dn); f2=band_high60*i -(1.7*Dn); 
        F1= sig_low60 *i ; F2=sig_high60*i ;
       
        else if i == 8
        f1= band_low60*i +(3*Dn); f2=band_high60*i -(3*Dn); 
        F1= sig_low60 *i; F2=sig_high60*i; 
         
        
        else
        f1= band_low60*i; f2=band_high60*i; 
        F1= sig_low60 *i; F2=sig_high60*i;    %  [F1 F2]=[59.98 60.06] 
            end
            end
            end
 
% Signal Band Whole
        D_sig60(i) = designfilt('bandpassiir','FilterOrder',40, ...
            'PassbandFrequency1',F1,'PassbandFrequency2',F2, ...
            'PassbandRipple',3, ...
            'StopbandAttenuation1',80,'StopbandAttenuation2',80, ...
            'SampleRate',1000);
        
%% Noise calculation

% Noise Band Whole
        D_nb_60(i) = designfilt('bandpassiir','FilterOrder',40, ...
            'PassbandFrequency1',f1,'PassbandFrequency2',f2, ...  
            'PassbandRipple',3, ...
            'StopbandAttenuation1',80,'StopbandAttenuation2',80, ...
            'SampleRate',1000);

% Noise Band 1
        D_n1_60(i)  = designfilt('bandpassiir','FilterOrder',40, ...
            'PassbandFrequency1',f1,'PassbandFrequency2',F1, ...   
            'PassbandRipple',3, ...
            'StopbandAttenuation1',80,'StopbandAttenuation2',80, ...
            'SampleRate',1000);   
        
% Noise Band 2
        D_n2_60(i)  = designfilt('bandpassiir','FilterOrder',40, ...
            'PassbandFrequency1',F2,'PassbandFrequency2',f2, ...  
            'PassbandRipple',3, ...
            'StopbandAttenuation1',80,'StopbandAttenuation2',80, ...
            'SampleRate',1000);
   end


%%  50 Hertz

% band_low50 = 45 ;  band_high50 = 55;
% sig_low50 =49.1 ;  sig_high50 =50.9;
dn = 50 - band_low50; 
ds = 50 - sig_low50 ;
  for i = 1:har_no
        
        if i == 2
        f1= band_low50*i +(.45*dn); f2=band_high50*i -(.45*dn); 
        F1= sig_low50 *i  ;  F2=sig_high50*i ;
        
        else if i == 3
        f1= band_low50*i +(1.5*dn); f2=band_high50*i -(1.5*dn); 
        F1= sig_low50 *i +(1.1*ds);  F2=sig_high50*i -(1.1*ds);
        
        else if i == 4
        f1= band_low50*i +(2.2*dn); f2=band_high50*i -(2.2*dn); 
        F1= sig_low50 *i +(2.4*ds); F2=sig_high50*i -(0.6*ds);   
        
        else if i == 5
        f1= band_low50*i +(2*dn); f2=band_high50*i -(2*dn); 
        F1= sig_low50 *i +(2.2*ds); F2=sig_high50*i  -(2.2*ds);   
        
        else if i == 6
        f1= band_low50*i +(4.0*dn); f2=band_high50*i -(4.0*dn); 
        F1= sig_low50 *i +(3.1*ds); F2=sig_high50*i  -(3.1*ds);   
        
        else if i == 7
        f1= band_low50*i +(4.5*dn); f2=band_high50*i -(4.5*dn); 
        F1= sig_low50 *i +(3.8*ds); F2=sig_high50*i  -(3.8*ds);  
        
        else if i == 8
        f1= band_low50*i +(4.9*dn); f2=band_high50*i -(4.9*dn); 
        F1= sig_low50 *i +(4.25*ds); F2=sig_high50*i  -(4.25*ds);  

        
        else
        f1= band_low50*i ; f2=band_high50*i ; 
        F1= sig_low50 *i ;  F2=sig_high50*i ;
            end
            end
            end
            end
            end
            end
            end
 
               
% Signal Whole Band
        D_sig50(i) = designfilt('bandpassiir','FilterOrder',40, ...
            'PassbandFrequency1',F1,'PassbandFrequency2',F2, ...
            'PassbandRipple',3, ...
            'StopbandAttenuation1',80,'StopbandAttenuation2',80, ...
            'SampleRate',1000);
        

%% Noise calculation
% Noise Whole Band
        D_nb_50(i) = designfilt('bandpassiir','FilterOrder',40, ...
            'PassbandFrequency1',f1,'PassbandFrequency2',f2, ...  
            'PassbandRipple',3, ...
            'StopbandAttenuation1',80,'StopbandAttenuation2',80, ...
            'SampleRate',1000);

% Noise Band 1
        D_n1_50(i)  = designfilt('bandpassiir','FilterOrder',40, ...
            'PassbandFrequency1',f1,'PassbandFrequency2',F1, ...   
            'PassbandRipple',3, ...
            'StopbandAttenuation1',80,'StopbandAttenuation2',80, ...
            'SampleRate',1000);   

% Noise Band 2
        D_n2_50(i)  = designfilt('bandpassiir','FilterOrder',40, ...
            'PassbandFrequency1',F2,'PassbandFrequency2',f2, ...  
            'PassbandRipple',3, ...
            'StopbandAttenuation1',80,'StopbandAttenuation2',80, ...
            'SampleRate',1000);

   end

save('C:\Users\Samin Yeasar\Desktop\Final Program\filter_8th.mat')
clear i
