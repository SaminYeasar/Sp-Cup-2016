
%% 50 vs 60 Hz File Identification

fn = fs/2;
w1= 48/fn; w2 = 52/fn;
[b,a]=fir1(2500,[w1 w2],'bandpass');
x50 = filter(b,a,sig_x);

fn = fs/2;
w1= 58.5/fn; w2 = 61.5/fn;
[b,a]=fir1(2500,[w1 w2],'bandpass');
x60 = filter(b,a,sig_x);

fn = fs/2;
w1= 97.5/fn; w2 = 102.5/fn;
[b,a]=fir1(2500,[w1 w2],'bandpass');
x100 = filter(b,a,sig_x);

fn = fs/2;
w1= 117.5/fn; w2 = 122.5/fn;
[b,a]=fir1(2500,[w1 w2],'bandpass');
x120 = filter(b,a,sig_x);

fn = fs/2;
w1= 198/fn; w2 = 204/fn;
[b,a]=fir1(2500,[w1 w2],'bandpass');
x200 = filter(b,a,sig_x);

fn = fs/2;
w1= 236/fn; w2 = 244/fn;
[b,a]=fir1(2500,[w1 w2],'bandpass');
x240 = filter(b,a,sig_x);



%**** Convert Bins to Freq****
% 
% Xft50 = abs(fft(x50));
% XFT50=Xft50(floor((1:length(Xft50)/2)));
% p5 = linspace(1,500,length(XFT50));
% subplot(2,4,2); plot(p5,XFT50)
% [q50,ind] = max(XFT50);
% x50  = ((fs/2)/(length(sig_x)/2)) * ind;
% q50;

Xft50 = abs(fft(x50));
XFT50=Xft50(floor((1:length(Xft50)/2)));
[q50,ind] = max(XFT50);
sig_freq50  = ((fs/2)/(length(sig_x)/2)) * ind;

Xft60 = abs(fft(x60));
XFT60=Xft60(floor((1:length(Xft60)/2)));
[q60,ind] = max(XFT60);
sig_freq60  = ((fs/2)/(length(sig_x)/2)) * ind;


Xft100 = abs(fft(x100));
XFT100=Xft100(floor((1:length(Xft100)/2)));
[q100,ind] = max(XFT100);
sig_freq100  = ((fs/2)/(length(sig_x)/2)) * ind;


Xft120 = abs(fft(x120));
XFT120=Xft120(floor((1:length(Xft120)/2)));
[q120,ind] = max(XFT120);
sig_freq120  = ((fs/2)/(length(sig_x)/2)) * ind;


Xft200 = abs(fft(x200));
XFT200=Xft200(floor((1:length(Xft200)/2)));
[q200,ind] = max(XFT200);
sig_freq200  = ((fs/2)/(length(sig_x)/2)) * ind;



Xft240 = abs(fft(x240));
XFT240=Xft240(floor((1:length(Xft240)/2)));
[q240,ind] = max(XFT240);
sig_freq240  = ((fs/2)/(length(sig_x)/2)) * ind;




[M,IN] = max([q50 q60 q100 q120 q200 q240])

if (IN == 1)|(IN == 3)|( IN==5 )
    band_high = 51 ; band_low = 49; sig_high=50.9; sig_low =49.1;
else    
    band_high = 61 ; band_low = 59; sig_high=60.4; sig_low =59.6;
end


