function [TabFeat X_norm, mu, sigma] = GetTabFeat( MotherOfAllFeat,VarName, TabNo )

 
for i = 1:length(MotherOfAllFeat)
  TrainDataNo(i)= size(MotherOfAllFeat{i},1); 
end
 
MegaFeat = [];
for i=1:length(MotherOfAllFeat)
    MegaFeat = [MegaFeat ;MotherOfAllFeat{1,i}];
end

[X_norm, mu, sigma] = featureNormalize(MegaFeat );


%%
% Tables


TabFeat = array2table(X_norm,'VariableNames',VarName);

if TabNo == 1 
    TabFeat.Grid = [ repmat({'A'},TrainDataNo(1),1); repmat({'B'},TrainDataNo(2),1); repmat({'C'},TrainDataNo(3),1);...
                 repmat({'D'},TrainDataNo(4),1); repmat({'E'},TrainDataNo(5),1); repmat({'F'},TrainDataNo(6),1);...
                 repmat({'G'},TrainDataNo(7),1); repmat({'H'},TrainDataNo(8),1); repmat({'I'},TrainDataNo(9),1);...
                 repmat({'J'},TrainDataNo(10),1); repmat({'K'},TrainDataNo(11),1); repmat({'L'},TrainDataNo(12),1);...
                 repmat({'M'},TrainDataNo(13),1)];
             
elseif TabNo == 2
    TabFeat.Grid = [ repmat({'A'},TrainDataNo(1),1); repmat({'B'},TrainDataNo(2),1); repmat({'C'},TrainDataNo(3),1);...
                 repmat({'D'},TrainDataNo(4),1); repmat({'E'},TrainDataNo(5),1); repmat({'F'},TrainDataNo(6),1);...
                 repmat({'G'},TrainDataNo(7),1); repmat({'H'},TrainDataNo(8),1); repmat({'I'},TrainDataNo(9),1)];
             
else             TabFeat.Grid = [ repmat({'A'},TrainDataNo(1),1); repmat({'B'},TrainDataNo(2),1); repmat({'C'},TrainDataNo(3),1);...
                 repmat({'D'},TrainDataNo(4),1); repmat({'E'},TrainDataNo(5),1); repmat({'F'},TrainDataNo(6),1);...
                 repmat({'G'},TrainDataNo(7),1); repmat({'H'},TrainDataNo(8),1); repmat({'I'},TrainDataNo(9),1);...
                 repmat({'J'},TrainDataNo(10),1); repmat({'K'},TrainDataNo(11),1); repmat({'L'},TrainDataNo(12),1);...
                 repmat({'M'},TrainDataNo(13),1);...
                 
                 repmat({'A'},TrainDataNo(14),1); repmat({'B'},TrainDataNo(14),1); repmat({'C'},TrainDataNo(16),1);...
                 repmat({'D'},TrainDataNo(17),1); repmat({'E'},TrainDataNo(18),1); repmat({'F'},TrainDataNo(19),1);...
                 repmat({'G'},TrainDataNo(20),1); repmat({'H'},TrainDataNo(21),1); repmat({'I'},TrainDataNo(22),1)];
end

TabFeat.Grid=categorical(TabFeat.Grid);