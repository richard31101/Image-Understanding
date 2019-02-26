%%
% first check if any Words detected from ocr() contain both "." and "$"
% if yes --> each price delete the first element 
% (trying to avoid the probability that $ is detected as 5)
% if no --> do nothing with the price
%
% ocr(I):
%   performance correctness: 80% correct
% ocr(I,'TextLayout', 'Block'):
%   performance correctness: 80% correct (same number will be seen as different numbers)
%
% CharacterSet, '0123456789$.'

final_price = [];
names = ["--TITLE--"];
for ind = 1:20
    imname = strcat('img/img',num2str(ind), '.jpg');
    I = imread(imname);
    results = ocr(I,'TextLayout', 'Block', 'CharacterSet', 'qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM1234567890$.@');
    %% display in image
    %{
    figure;
    for i = 1:length(results.Words)
        word = results.Words{i}; % type of word is 'char'
        wordBBox = results.WordBoundingBoxes(i,:);
        Iname = insertObjectAnnotation(I, 'rectangle', wordBBox, word);
        imshow(Iname);
    end
    %}
    %% check if it contains "$"
    pattern_dot = "."; 
    pattern_dollar = "$";
    pattern_B = "B";
    dollar_exist = 0;
    TF = contains(results.Words,pattern_dot); % check if results.Words{i} contain "."
    for i = 1:length(results.Words)
        if TF(i) == 1
             if contains(results.Words{i}, pattern_dollar)==1
                 dollar_exist = 1;
                 break;
             end
        end
    end
    %% change type from char to double
    bool_first_word = 1; % check if it is the first word
    price = 0; % result of final price
    store_title = ''; % result of final store title
    y_axis_title = 0; % y axis of store title

    for i = 1:length(results.Words)
        % word contain a-zA-Z0-9.$      
        firstWord_Con = results.Words{i}~="" && contains("qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM1234567890$", results.Words{i}(1));
        if firstWord_Con == 1
            % if it is first word
            wordbox = results.WordBoundingBoxes(i,:);
            if bool_first_word == 1
                store_title = results.Words{i};
                bool_first_word = 0;
                y_axis_title = wordbox(2);
            elseif (wordbox(2) >= y_axis_title-16) && (wordbox(2) <= y_axis_title+16)
                store_title = store_title + " " + results.Words{i};
            end
            if TF(i) == 1
                if dollar_exist == 1
                    result = results.Words{i}(2:end);
                else
                    result = results.Words{i};
                end
                result = regexprep(result,'[^a-zA-Z0-9.]','');
                TF_B = contains(result, pattern_B);
                if TF_B == 1
                    result = strrep(result, "B","8");
                end
                result = str2double(result);
                if isnumeric(result) == 1 && result > price
                    price = result;
                end
            end
        end
    end
    names = [names; store_title];
    final_price = [final_price; price];
end
display(names);
display(final_price);

%% output to .txt file
% make each name's length the same
for i = 1:size(names, 1)
    for j = 1:(max(strlength(names))-strlength(names(i)))
        names(i) = names(i) + " ";
    end
end

output = [names, ["--COST--"; num2str(final_price)]];

% write to bookkeeping.txt
fid = fopen('bookkeeping2.txt','wt');
for ii = 1:size(output,1)
    fprintf(fid,'%s\t',output(ii,:));
    fprintf(fid,'\n');
end
fprintf(fid, '\n');
fprintf(fid, '%s %6.2f %s', '---- total amount: ', sum(final_price), '----');
fclose(fid);