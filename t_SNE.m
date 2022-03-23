normed_data=normalize(table2array(input_dataset))
Adjusted_values=normed_data-min(min(normed_data))
Adjusted_values=table2array(temp);
Y = tsne(Adjusted_values);
%Y=table2array(simple_data)
gscatter(Y(:,1),Y(:,2),table2array(Contro))
