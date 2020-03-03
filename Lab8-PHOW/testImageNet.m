TrVoc = [0 100 150; 300 600 900];

cd ../../..
run('VLFEATROOT/toolbox/vl_setup')
cd ..
addpath('lab8')
cd lab8/VLFEATROOT/apps/dataImageNet200

conf.numClasses=200;
testDir = '~/imageNet200/test/';
conf.dataDir = './';
conf.prefix = 'imageNet200';

%for i = 2:3
 %   for j = 1:3
        %dirName = ['tr' num2str(TrVoc(1,i)) '_voc' num2str(TrVoc(2,j))];
	dirName = 'final'
        conf.dataDir = [dirName '/'];
        
        testModelImageNet200(conf,testDir,[dirName '/imageNet200FINAL-model.mat']);
        
%    end
%end
