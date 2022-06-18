%% U-Net Training
% Carlos Enrique Lopez Jimenez A01283855
% Genaro Gallardo Bórquez A01382459
% Claudia Esmeralda González Castillo A01411506
% Jesús Eduardo Martínez Herrera A01283785
% Mario Veccio Castro Berrones A00826824


% 1) Learn to create a U-net
%% Create a U-Net network with an encoder-decoder depth of 3.
imageSize = [480 640 3];
numClasses = 5;
encoderDepth = 3;
lgraph = unetLayers(imageSize,numClasses,'EncoderDepth',encoderDepth);

plot(lgraph) % Plot the network

% 2) Train U-Net for semantic segmentation
%% Load training images and pixel labels
dataSetDir = fullfile(toolboxdir('vision'),'visiondata','triangleImages');
imageDir = fullfile(dataSetDir,'trainingImages');
labelDir = fullfile(dataSetDir,'trainingLabels');

%% Create an imageDatastore object to store the training images.
imds = imageDatastore(imageDir);

%% Define the class names and their associated label IDs.
classNames = ["triangle","background"];
labelIDs   = [255 0];

%%
% Create a pixelLabelDatastore object to store the ground truth pixel 
% labels for the training images.
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);

%% Crating the U-Net network
imageSize = [32 32];
numClasses = 2;
lgraph = unetLayers(imageSize, numClasses)

ds = combine(imds,pxds); % Datastore for training the network.

%% Training options
% options = trainingOptions('sgdm', ...
%     'InitialLearnRate',1e-2, ...
%     'MaxEpochs',30, ...
%     'VerboseFrequency',10);
options = trainingOptions('sgdm', ...
    'InitialLearnRate',1e-5, ...
    'MaxEpochs',40, ...
    'VerboseFrequency',10);

%% Train the network
net = trainNetwork(ds,lgraph,options)

%% Resultados
%
%