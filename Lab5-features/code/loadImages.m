function images = loadImages(a)

addpath('train');
addpath('test');

% se escogió aleatoriamente las imagenes 11 15 y 30
images = [];

for j =1:25
    for i = 1:numel(a)
        if j<10
            n1 = ['0' num2str(j)];
        else
            n1 = num2str(j);
        end
        
        if a(i)<10
            n2 = ['0' num2str(a(i))];
        else
            n2 = num2str(a(i));
        end
        
        
        vt1 = imread(['T' n1 '_' n2 '.jpg']);
        images=[images,vt1(1:100,1:100)];
    end
end