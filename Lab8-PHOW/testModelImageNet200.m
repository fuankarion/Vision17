function testModelImageNet200(conf,testDir,modelDirection)
% Model es el trained vocabulary

% model file    conf.modelPath

% test class directory MUST FINISH WITH '/'
conf.testDir = testDir;
%'~/imageNet200/test/';



% --------------------------------------------------------------------
%                                           Compute spatial histograms
% --------------------------------------------------------------------

classes = dir(conf.testDir);
classes = classes([classes.isdir]) ;
classes = {classes(3:conf.numClasses+2).name};

load(modelDirection);


confu = zeros(conf.numClasses);

for ii = 1:length(classes)
    display(['Processing class number ' num2str(ii) ' - ' classes{ii}])
    Files = dir([conf.testDir classes{ii}]);
    Files = Files(~[Files.isdir]);
    Files = {Files(3:end).name};
    cali = zeros(conf.numClasses,1);
    for jj = 1:length(Files)
        im = imread([conf.testDir classes{ii} '/' Files{jj}]);
        % clasifica la imagen im
        [className, ~] = classify2(model, im);
        class = not(cellfun('isempty',strfind(classes,className)))';
        cali=cali+class;
    end
    cali = cali/sum(cali);
    confu(:,ii)=cali;
end
[conf.dataDir conf.prefix '-classes.mat']
%save([conf.dataDir conf.prefix '-classes.mat'],'classes')
%save([conf.dataDir conf.prefix '-confMatrix.mat'],'confu')
save('finalclasses.mat','classes')
save('final.mat','confu')

end

% -------------------------------------------------------------------------
function hist = getImageDescriptor(model, im)
% -------------------------------------------------------------------------

im = standarizeImage(im) ;
width = size(im,2) ;
height = size(im,1) ;
numWords = size(model.vocab, 2) ;

% get PHOW features
[frames, descrs] = vl_phow(im, model.phowOpts{:}) ;

% quantize local descriptors into visual words
switch model.quantizer
    case 'vq'
        [~, binsa] = min(vl_alldist(model.vocab, single(descrs)), [], 1) ;
    case 'kdtree'
        binsa = double(vl_kdtreequery(model.kdtree, model.vocab, ...
            single(descrs), ...
            'MaxComparisons', 50)) ;
end

for i = 1:length(model.numSpatialX)
    binsx = vl_binsearch(linspace(1,width,model.numSpatialX(i)+1), frames(1,:)) ;
    binsy = vl_binsearch(linspace(1,height,model.numSpatialY(i)+1), frames(2,:)) ;
    
    % combined quantization
    bins = sub2ind([model.numSpatialY(i), model.numSpatialX(i), numWords], ...
        binsy,binsx,binsa) ;
    hist = zeros(model.numSpatialY(i) * model.numSpatialX(i) * numWords, 1) ;
    hist = vl_binsum(hist, ones(size(bins)), bins) ;
    hists{i} = single(hist / sum(hist)) ;
end
hist = cat(1,hists{:}) ;
hist = hist / sum(hist) ;
end

% -------------------------------------------------------------------------
function [className, score] = classify2(model, im)
% -------------------------------------------------------------------------

hist = getImageDescriptor(model, im) ;
psix = vl_homkermap(hist, 1, 'kchi2', 'gamma', .5) ;
scores = model.w' * psix + model.b' ;
[score, best] = max(scores) ;
className = model.classes{best} ;

end

% -------------------------------------------------------------------------
function im = standarizeImage(im)
% -------------------------------------------------------------------------

im = im2single(im) ;
if size(im,1) > 480, im = imresize(im, [480 NaN]) ; end

end
