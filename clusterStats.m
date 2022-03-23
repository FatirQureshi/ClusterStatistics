function [Header_column,centroid_Table,mahal_Table,t_squared_table_Table,Spatial_Table] = clusterStats(test)
%Determines dimension of input to allocate appropriate size.
elements_dataset=size(test);
%Initialize a table to store the centroid and Euclidian distance Values
centroid_Table=[];
Spatial_Table=[];
uniqueList=unique(test(:,1));
%Determine the number of unique Groups being examined 
for i=1:length(table2array(uniqueList))
    %Critical that input is formatted such that label has "Group" as a
    %column header
    %Iterates across all unique Groups
try
groupValues=test(test.Group==table2array(uniqueList(i,1)), :);
    catch
        warning('The names used for the Group names contain an invalid character, please change them to be compatible')
        return
    end
postScoreMes=table2array(groupValues(:,2:elements_dataset(2)));
centroidFA=mean(postScoreMes);
centroid_Table=[centroid_Table;centroidFA];
%Determines the centroid of each variable
adjusted_values=postScoreMes-mean(postScoreMes);
all_adjusted=[];
for q=1:length(postScoreMes)
    %Determines the distance from the centroid for each point in each
    %variable
all_adjusted=[all_adjusted,((adjusted_values(q,2)^2)+(adjusted_values(q,1)^2))^(1/2)];
end
% Aggregates all average Euclidian Distance for all groups
Spatial_Table=[Spatial_Table;mean(all_adjusted)]
end
%Prep for determining the average Mahalanobis distance
mahal_Table=zeros(length(table2array(uniqueList)));
t_squared_table_Table=zeros(length(table2array(uniqueList)));
for i=1:length(table2array(uniqueList))
groupValues=test(test.Group==table2array(uniqueList(i,1)), :);
postScoreMes=table2array(groupValues(:,2:elements_dataset(2)));
for j=1:length(table2array(uniqueList))
    %Pairwise determination of Mahalanobis distance and Hotelling T-squared
    %statistic
    groupValues_vs=test(test.Group==table2array(uniqueList(j,1)), :);
postScoreMes_vs=table2array(groupValues_vs(:,2:elements_dataset(2)));

    d2 = mahal(centroid_Table(j,:),postScoreMes);
    mahal_Table(i,j)=d2;
    groupX=groupValues(:,2:3);
    groupY=groupValues_vs(:,2:3);
   
    delete groupX.xlsx
    delete groupY.xlsx
    writetable(groupX,'groupX.xlsx')
    writetable(groupY,'groupY.xlsx')
    %Handshake with R to determine Hotelling t-squared statistic 
    RunRcode('T_Squared.R','C:\Program Files\R\R-4.1.1\bin')
    if isnan(table2array(readtable('p_value_statR.csv')))
    t_squared_table_Table(i,j)=99;
    else
        t_squared_table_Table(i,j)=table2array(readtable('p_value_statR.csv'));
    end
end
end
Header_column=table2array(uniqueList);
delete groupX.xlsx
    delete groupY.xlsx
end

