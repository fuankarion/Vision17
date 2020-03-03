function labels = labelsIm(im,w,b,cellSize)

hog = vl_hog(im,cellSize);


% Take the vectors corresponding to a  
s1 = size(hog,1);
s2 = size(hog,2);
labels = zeros([s1-13 s2-16]);
for i = 1:(s1-13)
    for j = 1:(s2-16)
        xtest = reshape(hog(i:(i+13-1),j:(j+16-1),:), 13*16*31, 1);
        labels(i,j) = sign(w'*xtest+b);
    end
end



end
