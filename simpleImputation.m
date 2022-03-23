function [groupValues_complete,output_dataset] = simpleImputation(plotData)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
uniqueList=unique(plotData(:,1));
%Determine the number of unique Groups being examined 
groupValues_complete=[];
for i=1:length(table2array(uniqueList))
    %Critical that input is formatted such that label has "Group" as a
    %column header
    %Iterates across all unique Groups

groupValues=plotData(categorical(plotData.Group)==table2array(uniqueList(i,1)), :);
for j=2:width(groupValues)
    singleColumn = groupValues(:,j);
    missing_elements=find(isnan(table2array(singleColumn)));
    for k=1:length(missing_elements)
    groupValues{missing_elements(k),j}=(min(table2array(singleColumn)))/sqrt(2);
    end


end
groupValues_complete=[groupValues_complete;groupValues];
end
elements_dataset=size(groupValues_complete);
output_dataset=table2array(groupValues_complete(:,2:elements_dataset(2)));
%values_alone=table2array(groupValues_complete);
%pyRtable=[plotData.Group,groupValues_complete];
end