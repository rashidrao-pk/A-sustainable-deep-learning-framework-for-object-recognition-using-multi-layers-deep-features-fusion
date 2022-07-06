
%% Dataset Paths
clc
clear all
close all
workspace;
%% Multi Core UTILIZATION
p = gcp
if size(p),1==1
    p = gcp('nocreate');    % If no pool, do not create new one.
else
p = gcp
end

%% Orignal Link
% https://www.mathworks.com/help/vision/examples/image-category-classification-using-deep-learning.html
% This Code development took struggles of many hours
% Kindly cite us or refer us if use this code
% Credits : Rashid Rao (Rashidcui@ciitwah.edu.pk ||| Rashid047571@gmail.com)
% Comsats University Islamabad, Wah Campus, Pakistan
%% A-sustainable-deep-learning-framework-for-object-recognition-using-multi-layers-deep-features-fusion
datasetname='F:\Datasets\Caltech-101';
rootFolder = fullfile(datasetname);

allfoldernames= struct2table(dir(rootFolder));
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
clear i
categories=new;

imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource','foldernames');
tbl = countEachLabel(imds);
minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');
% Notice that each set now has exactly the same number of images.
countEachLabel(imds)
%% Pretrained Net AlexNet
net = vgg19();
net.Layers(1)
net.Layers(end)

imr=net.Layers(1, 1).InputSize(:,1);
imc=net.Layers(1, 1).InputSize(:,2);

imds.ReadFcn = @(filename)readAndPreprocessImage(filename,imr,imc);
[trainingSet, testSet] = splitEachLabel(imds, 0.7, 'random');
% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;
%%   Resize weigts for vgg only
w1 = imresize(w1,[imr imc]);
%%
featureLayer = 'fc7';
%%
trainingFeatures = activations(net, trainingSet, featureLayer, ...
 'MiniBatchSize', 128, 'OutputAs', 'columns');
%%
% Get training labels from the trainingSet
trainingLabels = cellstr(trainingSet.Labels);

