
%% Splitter Start From Here
if gather_index==1
    N =powerfile_no(z);
end

%%
 for I = 1:N


har_no=8;
h = sprintf(file,I)    
[sig_x,fs] = audioread(h);

run('FrequencySNR30.m')
xlen = length(sig_x);
xtime = (xlen/1000)/60;
% % figure(9);
% plot( linspace(0,1000,length(sig_x)), abs(fft(sig_x)) );


%% 
%Data Length Identification
div = 2;               % Segment multiplier of Time = 5 Mins
if xtime == 60
Datalet = reshape(sig_x,[],12/div);

else if xtime == 30
Datalet = reshape(sig_x,[],6/div);

else if xtime == 50
Datalet = reshape(sig_x,[],10/div);

else if xtime == 40
Datalet = reshape(sig_x,[],8/div);

else if xtime == 35
sig_x = sig_x(1:(30*60*1000));        
Datalet = reshape(sig_x,[],6/div);

else if xtime == 25
sig_x = sig_x(1:(20*60*1000));        
Datalet = reshape(sig_x,[],4/div);

else if xtime == 20
Datalet = reshape(sig_x,[],4/div);

else if xtime == 15
sig_x = sig_x(1:(10*60*1000));
Datalet = reshape(sig_x,[],2/div);

else if xtime == 10
Datalet = reshape(sig_x,[],2/div);

    end
    end
    end
    end
    end
    end
    end
    end
end


%%
%Power Files Selection 
num_seg = size(Datalet,2);
             % comment this


clear feature
clear Power_Feature
 for K=1:num_seg
    x = Datalet(:,K);                   % data saved into x 

        run('Processor_T5new.m');

    Power_Feature(K,:) = (feature);
    clear feature

 end

    PowerFile{I} = Power_Feature;
    clear Power_Feature


  end    

%%
%Concatenation

MotherPower = [];
for i=1:N
MotherPower = cat(1,MotherPower,PowerFile{i});
end

clear PowerFile



