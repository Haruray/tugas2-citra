function outputMatrix = stringToMatrix(inputString)
    rows = strsplit(inputString, ';');
    
    outputMatrix = zeros(length(rows), length(str2num(rows{1})));
    
    for i = 1:length(rows)
        elements = str2num(rows{i});
        outputMatrix(i, :) = elements;
    end
end