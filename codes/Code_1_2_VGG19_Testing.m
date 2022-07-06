% Extract test features using the CNN
testFeatures = activations(net, testSet, featureLayer, ...
 'MiniBatchSize', 64, 'OutputAs', 'columns');
%%
% Pass CNN image features to trained classifier

predictedLabels = predict(classifier, testFeatures, 'ObservationsIn', 'columns');

% Get the known labels
testLabels = testSet.Labels;

% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))

% Display the mean accuracy
mean(diag(confMat))

%%
 trainingFeatures =trainingFeatures';
 testFeatures =testFeatures';


%%
x1=trainingFeatures;
y1=trainingLabels;
xy1=array2table(x1);
xy1.type=y1;
%%
x2=testFeatures;
y2=testLabels;
xy2=array2table(x2);
xy2.type=y2;

cd F:\Study\MS(CS)\Papers\object\mat\
%%save model

save('xy_vgg_train_4096','xy1','net','classifier');
save('xy_vgg_test_4096','xy2','classifier','net');
