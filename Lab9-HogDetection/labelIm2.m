function labelIm2(w,b,im,fileName,dirName)

fprintf(['    Processing picture: ' fileName(1:(end-4)) '.txt\n'])
% 125,100 -> 16x13x31
% 100,80 -> 13x10x31
% 80x80 -> 10x10x31
im = im2single(im);
hog = vl_hog(im,8);
labels = zeros(size(hog,1),size(hog,2),3);

vectSize = cat(3,cat(3,[16,13],[13 10]),[10 10]);
vectSizeReal = cat(3,cat(3,[125,100],[100 80]),[80 80]);
for k = 1:3
    for i=1:(size(hog,1)-vectSize(1,1,k))
        for j=1:(size(hog,2)-vectSize(1,2,k))
            
            xtest = hog(i:(i+vectSize(1,1,k)-1),j:(j+vectSize(1,2,k)-1),:);
            labels(i,j,k) = sign(w{k}'*xtest(:) + b{k}) ;
            
            
        end
    end
    labels(:,:,k) = (labels(:,:,k)>0)*(4-k);
end

labels = max(labels,[],3);

fid = fopen(fullfile(dirName,[fileName(1:end-4) '.txt']),'wt');
fprintf(fid,[fileName(1:end-4) '\n']);
fprintf(fid,'%d\n',sum(labels(:)>0));

[row,col] = find(labels>0);
[s1, s2]= size(im);
[l1, l2] = size(labels>0);



for j = 1:numel(col)
    tm = labels(row(i),col(i));
    fprintf(fid,'%d %d %d %d 0.33\n',round(s1*col(j)/l1),round(s2*row(j)/l2),vectSizeReal(1,1,4-tm),vectSizeReal(1,2,4-tm));
end

fclose(fid);
