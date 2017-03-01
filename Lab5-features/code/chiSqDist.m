function [dist,I] = chiSqDist(ini,his)
% CHISQDIST returns the index I of the minimum chi-squared distance between
% the column histogram INI and all the column histograms compacted in HIS
% and returns the distances DIST.


n = size(his);

ini = repmat(ini,1,n(2));
dist = ((ini-his).^2)./(ini+his);
[~,I] = min(sum(dist));

end