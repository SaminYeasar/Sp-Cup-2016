
%%%%%%%%%%%%%%%%%%%  data is splitted into x %%%%%%%%%%%%%%%%%%%%%
xlen = length(x);
xx=x;  

%% Filter implementation

sig_mat = repmat(x,1,har_no) ;

sig_rep = abs(fft(sig_mat));

    if (IN==2)|(IN==4)|(IN==6)
        filt = D_sig60;
        band_low = 59 ; band_high = 61; sig_low =59.5; sig_high =60.5;
        count = 1;
    else
        band_low = 46.8;   band_high = 53.2;   sig_low =49;  sig_high =51;
        filt = D_sig50; count = 2;
    end    

    
for i=1:har_no
    x_sig_har(:,i) = filter(filt(i),x); 
    
    w1=sig_low*i/fn;
    w2=sig_high*i/fn;
    [b,a]=fir1(2500,[w1 w2],'bandpass');
    xf(:,i) = filter(b,a,xx);
    [maxxf(i),indexxf(i)] = max(abs(fft((xf(:,i)))));
end
    clear('xf','xx') 

maxxfk{I,z}(K,:)=maxxf./max(maxxf);
pval= polyfit([1:har_no],maxxf,7);


%%

signal0 = x ; 
fs = 1000; 


    if count == 1
        harmonics = 60*[1:8];
    else harmonics = 50*[1:8];
    end

        



duration = 10; 
frame_size_secs = 5; 
overlap_amount_secs  = 0;
nfft = 5000;
nominal = harmonics(:,1);
width_signal = ( M_max_f(:,z) - M_min_f(:,z) ) + 0.01;
width_band = 1;

[ weights] = computeCombiningWeights( signal0, fs, harmonics, duration, frame_size_secs, overlap_amount_secs, nfft, nominal, width_signal, width_band );

harmonic_multiples = [1:8];
[ spectro_strips, frequency_support ] = computeSpectrogramStrips( signal0, frame_size_secs, overlap_amount_secs, nfft, fs, nominal, harmonic_multiples, width_band );

strip_index = 1;
[ OurStrip_Cell, initial_frequency ] = computeCombinedSpectrum( spectro_strips, weights, duration, frame_size_secs, strip_index, frequency_support );

[sig] = computeENFfromCombinedStrip( OurStrip_Cell, initial_frequency, fs, nfft  );


ENF{I,z}(K,:)= sig;
%% 

MEAN=mean(sig);
d_range= log10(max(sig)-min(sig));
v= log10(var(sig)); 


% L level wavelet decomposition

% L level wavelet decomposition

[C,L] = wavedec(sig,9,'db2');

cA1 = appcoef(C,L,'db2',1);
[cD1,cD2,cD3,cD4,cD5,cD6,cD7,cD8,cD9] = detcoef(C,L,[1,2,3,4,5,6,7,8,9]);


A9 = wrcoef('a',C,L,'db2',9);
vA9= log10(var(A9));

D1 = wrcoef('d',C,L,'db2',1);
vD1= log10(var(D1));

D2 = wrcoef('d',C,L,'db2',2);
vD2= log10(var(D2));

D3 = wrcoef('d',C,L,'db2',3);
vD3= log10(var(D3));

D4 = wrcoef('d',C,L,'db2',4);
vD4= log10(var(D4));

D5 = wrcoef('d',C,L,'db2',5);
vD5= log10(var(D5));

D6 = wrcoef('d',C,L,'db2',6);
vD6= log10(var(D6));

D7 = wrcoef('d',C,L,'db2',7);
vD7= log10(var(D7));

D8 = wrcoef('d',C,L,'db2',8);
vD8= log10(var(D8));

D9 = wrcoef('d',C,L,'db2',9);
vD9= log10(var(D9));
 
[w,A,C,SBC,FPE,th]=arfit(sig,2,2);



feature = [MEAN v d_range vA9 vD1 vD2 vD3 vD4 vD5...
            vD6 vD7 vD8 vD9  ...
            A log10(C) pval maxxf];


  
   
%%
% snr_count = snr_count+1;

varlist = {'sig','Final_sig','P_sig'};
clear(varlist{:})

%% VarName
% 

        
VarName = {'MEAN', 'v', 'd_range', 'vA9' ,'vD1' ,'vD2' ,'vD3' ,'vD4' ,'vD5',...
                'vD6', 'vD7', 'vD8', 'vD9', 'a1', 'a2','log_c',...
                'p1','p2','p3','p4','p5','p6','p7','p8'...
                'm1','m2','m3','m4','m5','m6','m7','m8'};



















