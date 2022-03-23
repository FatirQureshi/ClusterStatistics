function [pyRtable] = pyFormatC(plotData,pyColors)
%The purpose of this function is to assign colors to each group for
%plotting purposes
uniqueList=unique(plotData(:,1));
%Determine the number of unique Groups being examined 
allColors=[];
groupValues_complete=[];
for i=1:length(table2array(uniqueList))
    %Critical that input is formatted such that label has "Group" as a
    %column header
    %Iterates across all unique Groups

groupValues=plotData(plotData.Group==table2array(uniqueList(i,1)), :);
for j=1:height(groupValues)
    allColors=[allColors ;pyColors(i,:)];
    

end
groupValues_complete=[groupValues_complete;groupValues];
end

allColors.Properties.VariableNames = {'Color'}
pyRtable=[groupValues_complete,allColors];
end