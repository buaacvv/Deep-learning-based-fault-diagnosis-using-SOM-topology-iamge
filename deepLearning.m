function []=deepLearning(picfile)
clear
clc
%picfile='D:\Matlab codes\Case WR\Load 0-driven end bearing data-12Khz\Pics7';% change the filename according to your settings
imds = imageDatastore(picfile,'IncludeSubfolders',true,'LabelSource','foldernames');
rng('default')

%ѵ�����_LeNet-5
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.8,'randomized');%60%ѵ��
inputSize=[32,32,3];

layers = [
    imageInputLayer(inputSize)
    
    convolution2dLayer(5,6)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5,16)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
       
    fullyConnectedLayer(120)
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];
%ͼԪ��ǿ
% pixelRange = [-30 30];
% imageAugmenter = imageDataAugmenter( ...
%     'RandXReflection',true, ...
%     'RandXTranslation',pixelRange, ...
%     'RandYTranslation',pixelRange);
% augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
%     'DataAugmentation',imageAugmenter);
% augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

%ѵ����������
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',50, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',50, ...
    'ExecutionEnvironment','multi-gpu',...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options);

%��֤����
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation)
%mailme('buaacvv@126.com','Accuracy',num2str(accuracy));
end