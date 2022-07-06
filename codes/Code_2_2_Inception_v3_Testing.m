%%
% Extract test features using the CNN
testFeatures = activations(net, testSet, featureLayer, ...
 'MiniBatchSize', 128, 'OutputAs', 'columns');
%%
% Pass CNN image features to trained classifier

predictedLabels = predict(classifier, testFeatures, 'ObservationsIn', 'columns');

% Get the known labels
testLabels = cellstr(testSet.Labels);

% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2));

% Display the mean accuracy
mean(diag(confMat))*100

%%
 trainingFeatures =trainingFeatures';
 testFeatures =testFeatures';


%%
x1=trainingFeatures;
y1=trainingLabels;
xy1_train=array2table(x1);
xy1_train.type=y1;
%%
x2=testFeatures;
y2=testLabels;
xy2_test=array2table(x2);
xy2_test.type=y2;

x1=double(x1);
[r1, c1]=size(x1);

new_score1 = Find_Entropy(x1,c1);
x3 = real(new_score1(:,1:2048));

xy3_train=array2table(x3);
xy3_train.type=y1;
% cd F:\Study\MS(CS)\Papers\5_object\mat\
% save model
% save('xy_inception_train_2048_Doc','xy1','net','classifier');
% save('xy_inception_test_2048_Doc','xy2','classifier','net');