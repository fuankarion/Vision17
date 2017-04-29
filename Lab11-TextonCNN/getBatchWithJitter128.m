
% --------------------------------------------------------------------
function [im, labels] = getBatchWithJitter128(imdb, batch)
% --------------------------------------------------------------------
im = imdb.images.data(:,:,batch) ;
labels = imdb.images.label(1,batch);

n = numel(batch) ;
train = find(imdb.images.set == 1) ;

sel = randperm(numel(train), n) ;
im1 = imdb.images.data(:,:,sel) ;

sel = randperm(numel(train), n) ;
im2 = imdb.images.data(:,:,sel) ;

ctx = [im1 im2] ;
%sizeCTX=size(ctx(:,65:192,:))
%sizeIm=size(im)
%ctx(:,65:192,:) = min(ctx(:,65:192,:), im) ;
ctx(:,65:192,:) =im ;

dx = randi(44) - 22 ;
%ssSizeCTX=size(ctx)
im = ctx(:,(65:192)+dx,:) ;
%ssSizeIM=size(im)
sx = (65:192) + dx ;
%sizsSX=size(sx)

dy = randi(20) - 8 ;
sy = max(1, min(128, (1:128) + dy)) ;
%sizsSY=size(sy)

im = ctx(sy,sx,:) ;
%sizeInteIM=size(im)

% Visualize the batch:
figure(100) ; clf ;
vl_imarraysc(im) ;

im = 256 * reshape(im, 128, 128, 1, []) ;
%size(im)
%figure(100) ; clf ;
%imshow(mat2gray(im(:,:,1,randi(99))))

%imFinalSize=size(im)
%labelsFinalSize=size(labels)
