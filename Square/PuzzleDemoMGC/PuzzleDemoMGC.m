%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% This demo code creates and solves type 1 and type 2 jigsaw puzzles from
%%% an image. 
%%%
%%%
%%% Copyright (C) 2012, Andrew Gallagher
%%% This code is distributed with a non-commercial research license.
%%% Please see the license file license.txt included in the source directory.
%%%
%%% Please cite this paper if you use this code: 
%%% 
%%% 
%%% Jigsaw Pieces with Pieces of Unknown Orientation, Andrew Gallagher,
%%% CVPR 2012. 
%%% 
%%% Andrew Gallagher
%%% Aug. 15, 2012. 
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Demo Really Big Puzzle!
addpath ./PuzCode/
imlist= 'DSC_1062.JPG';  % people watching waterfall, river

PP = 28; %pixels in a piece
nc = 24; % number of puzzle pieces across the puzzle
nr = 18;  % number of puzzle pieces up and down

placementKey = reshape(1:nr*nc, nr,nc);
ScramblePositions =1;% 0 to keep pieces in original locations, 1 to scrable
ScrambleRotations =1;% 0 to keep upright orientation, 1 to scramble

%make the puzzle pieces:
[pieceMat,ap, pi] = PuzzleFun(imlist,PP, nc,nr);

% SCRAMBLE THE PIECES:
if(ScramblePositions)
    ap2 = ap;
    ppp = randperm(numel(ap));
    for iii = 1:1:numel(ppp)
        ap2{iii} = ap{ppp(iii)};
    end
    ap=ap2;
else
    ppp = 1:numel(ap);
end
if(ScrambleRotations)
    randscram = floor(rand(numel(ap),1)*4)+1;
    for jj = 1:1:numel(ap)
        ap2{jj} = imrotate(ap{jj},90*(randscram(jj)-1));
    end
    ap=ap2;
end


% compute PuzzlePiece Atribute
fprintf('Compute Attributes for Puzzle\n');
pieceAttributes = ComputePieceAttributes(ap);  % Need to write this
fprintf('Done with Compute Attributes for Puzzle\n');

fprintf('Compute Pairwise Compatibility Scores for Puzzle, Method %d\n',7);

SCO = ComparePiecePairA_ROT(ap, 7,pieceAttributes,ScrambleRotations);  

fprintf('Done with Score Computation for Puzzle Method %d\n',7);
[GI, GR, im, Results] = DoAllAssemblyOfPuzzle(ap,SCO,nr,nc,1,ppp);
figure; 
imagesc(im);axis image;axis off
title('solved puzzle'); 
imwrite(im,'SolvedDemo.jpg','Quality',99);

imS  = renderPiecesFromGraphIDs(ap,placementKey,0);
figure; 
imagesc(imS);axis image;axis off
title('original puzzle'); 
imwrite(imS,'ScrambledDemo.jpg','Quality',99);



% evaluate the results:
G_safe = GI;
G_undo = (G_safe==0);
G_safe(G_safe==0) = 1;
G_temptemp = ppp(G_safe);
G_temptemp(G_undo) = 0;
[Res] = EvalPuzzleAssembly(G_temptemp, nc, nr);
% count the number with the right rotation:
G_temprot = GR(ppp);
LUT = [1 4 3 2];
sum(LUT(G_temprot)==randscram');
cloc = Res(3); K = nr*nc; 
% fprintf('\n\nAccuracy: %.0f pieces of %.0f are exactly in the correct position.\n', cloc,K ); 
% fprintf('Orientation: %d pieces have correct orientation.\n\n\n', sum(LUT(G_temprot)==randscram')); 

try
    rotation_record = mod(G_temprot + randscram' - 2, 4);
    predict_piece0 = G_temptemp;
    true_piece_1d = 1:1:numel(G_temptemp(:));

    predict_piece1 = rot90(predict_piece0);
    predict_piece2 = rot90(predict_piece1);
    predict_piece3 = rot90(predict_piece2);

    correct0 = sum(predict_piece0(:) == true_piece_1d(:) & rotation_record(:) == 0);
    correct1 = sum(predict_piece1(:) == true_piece_1d(:) & rotation_record(:) == 3);
    correct2 = sum(predict_piece2(:) == true_piece_1d(:) & rotation_record(:) == 2);
    correct3 = sum(predict_piece3(:) == true_piece_1d(:) & rotation_record(:) == 1);

    correct = max(correct0, max(correct1, max(correct2, correct3)));
    ratio = correct / numel(G_temptemp(:));
catch
    ratio = -1;
end

fprintf('Accuracy: %.2f\n', ratio);