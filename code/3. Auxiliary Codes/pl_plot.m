% we show polyfit the harmonics of different order
pval = []
h=cell(1,7);
% maxxfk{1,x}
% x = select harmonic component of any grid
% x = 1 means we choose grid D
v = maxxfk{1,4}(1,:);
%v = x(1,:);
for i=1:7
    pval= polyfit( [1:8],v,i );
    h{i}(1,:) = polyval( pval ,[1:8] );
    figure
    plot( h{i}(1,:)) 
    hold on
    plot ( v ,'*')
    hold off
end