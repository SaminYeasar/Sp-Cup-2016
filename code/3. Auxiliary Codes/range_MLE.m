clear all
clc

grid_no=10;
powerfile_no=[9 10 11 11 11 8 11 11 11 10];
mk='Train_Grid_A_P%d.wav';
for d=1:grid_no
    q=powerfile_no(d);
    for N=1:q

        % mk='Train_Grid_I_P%d.wav';    
        h = sprintf(mk,N)     
        [x,fs] = audioread(h);
        x = x(1:length(x)); 
        xlen = length(x);
        xtime = (xlen/1000)/60;
%% 
%Data Length Identification
if xtime == 60
Datalet = reshape(x,[],6*4);

else if xtime == 30
Datalet = reshape(x,[],3*4);

else if xtime == 50
Datalet = reshape(x,[],5*4);

else if xtime == 40
Datalet = reshape(x,[],4*4);

else if xtime == 35
%sig_x = sig_x(1:(30*60*1000));        
Datalet = reshape(x,[],(3*2+1)*2);

else if xtime == 25
%sig_x = sig_x(1:(20*60*1000));        
Datalet = reshape(x,[],(2*2+1)*2);

else if xtime == 20
Datalet = reshape(x,[],2*4);

else if xtime == 15
%sig_x = sig_x(1:(10*60*1000));
Datalet = reshape(x,[],(1*2+1)*2);
    end
    end
    end
    end
    end
    end
    end
    end


%% Frequecy Calculation
max_f=zeros(1,size(Datalet,2));
min_f=zeros(1,size(Datalet,2));
for j=1:size(Datalet,2)
x=Datalet(:,j);
xlen = length(x);

if mk(12)=='A'
    f1=59;f2=60;
elseif mk(12)=='C'
    f1=59;f2=60;
elseif mk(12)=='I'
    f1=59;f2=60;
   
else f1=49;f2=50;
end
%f1=59.5;
%f2=60.5;
% Filter implementation
fn=fs/2;
w1=f1/fn;
w2=f2/fn;
[b,a]=fir1(2500,[w1 w2],'bandpass');
x = filter(b,a,x);

%%
%hop size
L = 5000;

%window length & Formation
D = 15;                        %User Defined Parameter in Cooper's paper 
M = L*D;                             
w = hanning(M, 'periodic');    %window formation
%w = rectwin(M);
k = 0; % k =index
l = 1; % j =result vector index  
 
while k + M <= xlen

%window length & Window
xw = x(k+1:k+M) .*w;                  %windowed signal
NN=length(xw);                        %MLE_est
Z=xw';                                %MLE_est

%zero padding
b = 8;                           %Zero Padding Factor 'b'
xw = [xw; zeros(M*b,1)];
[nft,c] = size(xw);

%plot(abs(fft(xw)))

X = abs(fft(xw));
nfft=length(X);

XF=X(floor((1:length(X)/2)));
%XF = floor(X(1:length(X)/2));
[q,ind] = max(XF);          %original Peak bin

%quadratic Interpolation

alpha = 20*log10(abs(XF(ind-1)));
beta = 20*log10(abs(XF(ind)));
lambda = 20*log10(abs(XF(ind+1)));
p = .5*( (alpha-lambda)/ (alpha-2*beta+lambda) );
index = ind + p;            % QI Peak Bin

%calculation of frequency from Bins
sig(l)  = ((fs/2)/(nft/2)) * index;


%%
k = k+L;
l = l+1;
end
% after 5 min
max_f(j)=max(sig); 
min_f(j)=min(sig);

end

% after a power file
MAX_F(N)=max(max_f)
MIN_F(N)=min(min_f)

    end
% after each grid final max & min 
M_max_f(d)=max(MAX_F)
M_min_f(d)=min(MIN_F)

mk(12)=char(d+65);

end

