function V = QGA_FilterBank(InImg, PatchSize, NumFilters) 
% =======INPUT=============
% InImg            Input images (cell structure)  
% InImgIdx         Image index for InImg (column vector)
% PatchSize        the patch size, asumed to an odd number.
% NumFilters       the number of PCA filters in the bank.
% givenV           the PCA filters are given. 
% =======OUTPUT============
% V                PCA filter banks, arranged in column-by-column manner
% OutImg           filter output (cell structure)
% OutImgIdx        Image index for OutImg (column vector)
% ========= CITATION ============
% T.-H. Chan, K. Jia, S. Gao, J. Lu, Z. Zeng, and Y. Ma, 
% "PCANet: A simple deep learning baseline for image classification?" submitted to IEEE TPAMI. 
% ArXiv eprint: http://arxiv.org/abs/1404.3606 

% Tsung-Han Chan [thchan@ieee.org]
% Please email me if you find bugs, or have suggestions or questions!

% addpath('./Utils')

% to efficiently cope with the large training samples, we randomly subsample 100000 training subset to learn PCA filter banks
ImgZ = length(InImg);
MaxSamples = 10000;
NumRSamples = 10000; 
RandIdx = randperm(ImgZ);
RandIdx = RandIdx(1:ImgZ);

%% Learning PCA filters (V)
NumChls = size(InImg{1},3);
Rx = zeros(PatchSize^2,PatchSize^2,NumChls);
for i = RandIdx 
    im = im2patch(InImg{i},16,PatchSize,1); % collect all the patches of the ith image in a matrix
    % sampling one image
    num_per_img = round(NumRSamples/ImgZ);  %??
     load('E:\QGANet\Data\1\a');
    patchIdx = [a{i}];
    
%     patchIdx = randperm(size(im,2));
%     num_per_img = 15;
    
    im = im(:,patchIdx(1:num_per_img),:);
    
    im = bsxfun(@minus, im, mean(im)); % patch-mean removal 
  %  Rx = Rx + im*im'; % sum of all the input images' covariance matrix
     Rx = Rx + PLUSq(im,im);
end
Rx = Rx/(NumRSamples*size(im,2));
% [E D] = eig(Rx);
% [trash ind] = sort(diag(D),'descend');
% V = E(:,ind(1:NumFilters));  % principal eigenvectors 

V = quaternion_ga(Rx,8);
% V = grassmann_average(Rx, 8);



 



