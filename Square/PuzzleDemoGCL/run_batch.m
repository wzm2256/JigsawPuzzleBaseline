folder = 'F:\2dpuzzel\wikiart';
% folder = 'G:\CodeSet\JigsawCollection\PuzzleDemoGCL\dataset\540';

% Select all files in the root folder
files = [];
% files_sub = dir(fullfile(folder, '*.jpg'));
% files = [files; files_sub];
folders_sub = dir(fullfile(folder, '*'));
for i = 1 : length(folders_sub)
    if folders_sub(i).isdir
        files_sub = dir(fullfile(folders_sub(i).folder, folders_sub(i).name, '*.jpg'));
        files = [files; files_sub];
    end
end

% Keep only the file in the test set
fid = fopen(fullfile(folder, 'wikiart_subset_test.txt'));
tline = fgetl(fid);
test_list = {};
while ischar(tline)
    test_list{end+1} = tline;
    tline = fgetl(fid);
end
fclose(fid);


for i = 1 : length(files)

    if ~ismember(files(i).name, test_list)
        continue;
    end

    img = imread(fullfile(files(i).folder, files(i).name));

    img = imresize(img, [192, 192]);

    imwrite(img, files(i).name);

    disp('Processing file: ');
    disp(files(i).name);

    try
        % for wikiart
        puzzle_GCL_test_function(files(i).name, 'GCL_Result', 32, 6, 6);
        % for folder 540
    %     puzzle_GCL_test_function(files(i).name, 'GCL_Result', 28, 27, 20);
    end
    
    delete(files(i).name);
end
