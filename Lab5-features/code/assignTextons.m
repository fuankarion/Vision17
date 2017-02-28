function [map] = assignTextons(fim,textons)
% function [map] = assignTextons(fim,textons)

d = numel(fim);
n = numel(fim{1});
data = zeros(d,n);
for i = 1:d,
  data(i,:) = fim{i}(:)';
end
%clasifica las imagenes  cogiendo la distancia mínima entre los posibles
%textones.
d2 = distSqr(data,textons);
[y,map] = min(d2,[],2);
%map es la etiqueta de la imagen
[w,h] = size(fim{1});
map = reshape(map,w,h);