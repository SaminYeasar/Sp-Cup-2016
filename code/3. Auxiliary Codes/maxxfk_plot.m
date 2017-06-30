
% i = 1 means Grid A
% i = 4 means Grid D
% i = 7 means Grid G
load('G:\Machine Learning\GitHub\Sp Cup 2016\code\maxxfk.mat')
% maxxfk contains harmonic component of only 9 grids

i = [1:9]

for k=1:length(i)
    % we take just one dataset of harmonic from each grid
    x(k,:) = maxxfk{1,i(k)}(1,:);
    pval= polyfit( [1:8],x(k,:),7 );
    h(k,:) = polyval( pval ,[1:8] );
    figure
    plot( h(k,:)) 
    hold on
    plot ( x(k,:) ,'*')
    hold off
end
