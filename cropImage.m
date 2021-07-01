function Acrop = cropImage(A,y,ncut1,ncut2)

%input - A - image to crop
%      x,y - the dimensions of the image (width, height - in material coordinates)
%      ncut1 - upper threshold, above which is cut from image
%      ncut2 - lower threshold, below which is cut from image
%output - A - cropped image

%pixel dimensions of A
[ny,nx,~] = size(A);
% 1 vertical pixel = y/ny

%number of vertical pixels
pix = y/ny;

%define upper rectangle to crop image using pixels
ncut_pix1 = round(ncut1/pix); %convert to pixels
rec = [0 ny-ncut_pix1 nx ncut_pix1]; %[xmin ymin width height]
Acrop = imcrop(A,rec); %crop image

%pixel dimensions of Acrop
[ny,nx,~] = size(Acrop);

% define lower rectangle to crop image using pixels
% number of vertical pixels
y = ncut1;
pix = y/ny;
ncut_pix2 = round(ncut2/pix);
rec2 = [0 0 nx ny-ncut_pix2];
Acrop = imcrop(Acrop,rec2);
