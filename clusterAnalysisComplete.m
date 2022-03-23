
%The structure of the data is assumed to be an excel file with the first column
%corresponding to the group name

%An example of the correct format for reading data is given by test.xlsx

[file,path] = uigetfile('*.xlsx');
test = readtable(append(path,file));
imputation_option=false;
elements_dataset=size(test);
%Utilize bounds of the data to import only variable columns 
input_dataset=table2array(test(:,2:elements_dataset(2)));
if sum(sum(isnan(input_dataset)))>0
    
    choice_outcome       =  input('Should imputation be performed? : ','s');
    if convertCharsToStrings(choice_outcome)=="yes"
        imputation_option=true;
        
        [new_test,input_dataset]=simpleImputation(test);
        test=new_test;

    else
        new_output = input_dataset(:,all(~isnan(input_dataset)));
        %Remove all columns with empty values if imputation is not being
        %performed
        input_dataset=new_output;
    end

end
%Normalize data relative to each individual variables distribution range
%% This module handles tSNe determination and visualization 

normed_data=normalize(input_dataset);


Adjusted_values=normed_data-min(min(normed_data));
Y = tsne(Adjusted_values);
gscatter(Y(:,1),Y(:,2),table2array(test(:,1)));
Score_1=Y(:,1);
Score_2=Y(:,2);
Group=categorical(table2array(test(:,1)));
tSNE_Results = table(Group,Score_1, Score_2);
load('pyColors.mat')
PyStyle_=pyFormatC(tSNE_Results,pyColors);
delete tsne_input.csv
filename = 'tsne_input.csv';
writetable(PyStyle_,filename);
%Python code here to figure this out

%This part of the code is dependent on all libraries being correctly
%installed for Python

%pyversion  'C:\Users\RPI\Anaconda3\pkgs\python-3.8.5-h5fd99cc_1\pythonw.exe'

%pyrunfile('tSNEplotMaker.py')
delete tsne_input.csv

%Y=table2array(simple_data)


%% The purpose of this module is to determine the cluster statistics 
% following factor analysis

%Utilize the Varimax Factor Analysis function to derive a model consisting
%of factor scores for each sample measurnment
%Normalization occurs internally in function
VFA_Model=VarimaxFactorAnalysis(input_dataset);
Factor1=VFA_Model.F(:,1);
Factor2=VFA_Model.F(:,2);
Group=categorical(table2array(test(:,1)));
%Reorganizes data so serve as an input to calculate statistics
FA_Results = table(Group,Factor1, Factor2);

% Uses function that determines the cluster statistics   
[Group_Name,centroid_Table,Mahalanobis_Distance,t_squared_table_Table,Euclidean_Distance_Average]=clusterStats(FA_Results);
excl_stats=table(Group_Name,centroid_Table,Euclidean_Distance_Average,Mahalanobis_Distance,t_squared_table_Table);
filename = 'FA_Stats.xlsx';
file_extension=append(file,filename);
writetable(excl_stats,file_extension);

%% 

%Colors featured in the python plots can be edited in the pyColors data
%structure
load('pyColors.mat')
PyStyle_=pyFormatC(FA_Results,pyColors);
delete FA_input.csv
filename = 'FA_input.csv';
writetable(PyStyle_,filename);


%Python code here to figure this out

%This part of the code is dependent on all libraries being correctly
%installed for Python

%pyversion  'C:\Users\RPI\Anaconda3\pkgs\python-3.8.5-h5fd99cc_1\pythonw.exe'

%pyrunfile('plotMaker.py')