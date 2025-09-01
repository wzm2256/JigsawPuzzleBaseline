%
% Written by Vahan Huroyan
%

function [ rotPatches, rotsNum, rotations, A, rotate_vector ] = calculate_rotations( nn4Mat, rot_mat, Patches, eig_f_top)
%CALCULATE_LOCATIONS This function calculates the rotations
%   Detailed explanation goes here
    numbOfParts = size(nn4Mat, 1);
    lMat = rot_mat .* nn4Mat;

    D = diag(sum(abs(lMat), 2)); 

    lMat1 = D - lMat;   

    C = inv(sqrtm(D)) * lMat1 * inv(sqrtm(D));

    A = inv(D) * lMat1;

%     [U, ~, ~] = svd(C);
%     U = inv(sqrtm(D)) * U ;    
%     rotations = U(:, numbOfParts - 0);
    
    [U, ~] = svds(C, eig_f_top, 'smallest');
    U = U(:, eig_f_top);
%     disp(svds(C, eig_f_top, 'smallest'));
    
%     [U, ~] = svds(C, 1, 0);
    
    U = inv(sqrtm(D)) * U ;    
    rotations = U;

    % [U, ~, ~] = eig(lMat);
    % rotations = U(:, end);

    % round the angles
    [angles, rotsNum] = roundAngles( rotations );

    rotPatches = cell(1, numbOfParts);
    rotate_vector = zeros(1, numbOfParts);
    for i = 1:numbOfParts
        switch rotsNum(i);
            case 1
                rotPatches{i} = rot90(rot90(rot90(Patches{i})));
                rotate_vector(i) = 3;
            case 2
                rotPatches{i} = rot90(rot90(Patches{i}));
                rotate_vector(i) = 2;
            case 3
                rotPatches{i} = rot90(Patches{i});
                rotate_vector(i) = 1;
            otherwise
                rotPatches{i} = Patches{i};
                rotate_vector(i) = 0;
        end
    end
    
end

