        clc
clear all
pathname='F:\Study\MS(CS)\Object_Recognition\Datasets\All_datasets\Caltech101\20_ObjectCategories\';
imagespath=imageSet(pathname,'recursive');
imagecount=1;
 allfoldernames= struct2table(dir(pathname));
        for (i=3:height(allfoldernames))
            new(i-2)=allfoldernames.name(i);
        end
for i=1 : size(imagespath,2)
    m=size(imagespath(i).ImageLocation,2);
    temp=imagespath(i).ImageLocation;
     for j=1 :  m
        v{imagecount,1}=temp{j};
        if(~isempty(strfind(temp{j},new(1,i))))
                v{imagecount,2}=new(1,i);    
        else
            v{imagecount,2}='None';
        end
%             if(~isempty(strfind(temp{j},'accordion')))
%                 v{imagecount,2}='accordin';
%             else
%                 v{imagecount,2}='o';
%             end         
            img=imread(v{imagecount,1}); 
            if(size(img, 3) == 3)
            img=rgb2gray(img);
            end
            img=imresize(img,[128,128]);
%            [featureVector, hogVisualization] = extractHOGFeatures(img);
%             lbp = extractLBPFeatures(img);
%             SFTA=sfta(img,4);
%             surf = detectSURFFeatures(img);  
            
%%      MSER REGIONS
        [regions,mserCC] = detectMSERFeatures(img);
        regionsOrientation=transpose(regions.Orientation);
        %%
%          featurehog{imagecount,1}=featureVector(1,:);   
%         featurelbp{imagecount,1}=lbp(1,:); 
%         featuresfta{imagecount,1}=SFTA(1,:);
%%           MSER FEATURES
               featureMSEROrientation{imagecount,1}=regionsOrientation(1,:);
%               featureMSERLocation{imagecount,1}=regionsLocation(1,:);
        imagecount=imagecount+1;
     end
end

for i=1:length(featurehog)
    ftemp=double(featurehog{i});
    FV(i,:)=ftemp;
end
for i=1:length(featurelbp)
    ftemp1=double(featurelbp{i});
    FV1(i,:)=ftemp1;
end
for i=1:length(featuresfta)
    ftemp2=double(featuresfta{i});
    FV2(i,:)=ftemp2;
end
%
maxSize = max(cellfun(@numel,featureMSEROrientation)); 
for i=1:length(featureMSEROrientation)
    pad=maxSize-length(featureMSEROrientation{i}); 
    featureMSEROrientation{i,:}= padarray(featureMSEROrientation{i},[0 pad],0,'post');
    ftemp3=double(featureMSEROrientation{i});
     FV3(i,:)=ftemp3;
end
X=v(:,2);
[pc,score,latent,tsquare] = princomp(FV2);
  [r, c]=size(score);
  new_score2 = Find_Entropy(score,c);
  red_dim2 = new_score2;
  clear pc score latent tsquare  
  [pc,score,latent,tsquare] = princomp(FV1);
  [r, c]=size(score);
  new_score1 = Find_Entropy(score,c);
  red_dim1 = new_score1;
  clear pc score latent tsquare
  [pc,score,latent,tsquare] = princomp(FV);
  [r, c]=size(score);
  new_score = Find_Entropy(score,c);
  red_dim = new_score(:,1:1000);
  clear pc score latent tsquare
  
  [pc,score,latent,tsquare] = princomp(FV3);
  [r, c]=size(score);
  new_score3 = Find_Entropy(score,c); 
  red_dim3 = new_score3(:,1:100);
    %% $erialBasesFusion    
   fused=horzcat(red_dim,red_dim1,red_dim2,red_dim3);   %% All
   fused1=horzcat(red_dim,red_dim1);                    %hog  lbp
   fused2=horzcat(red_dim1,red_dim2);                   %lbp  sfta
   fused3=horzcat(red_dim2,red_dim3);                   %sfta surf
   fused4=horzcat(red_dim,red_dim3);                     %hog sfta
   fused5=horzcat(red_dim1,red_dim2,red_dim3);          %lbp surf sfta
   fused6=horzcat(red_dim,red_dim2,red_dim3);           %lbp surf sfta
   fused7=horzcat(red_dim,red_dim1,red_dim3);           %lbp surf sfta
   fused8=horzcat(red_dim,red_dim1,red_dim2);           %hog lbp sfta
%%
   f=cell2table(horzcat(X,num2cell(fused)));
   f1=cell2table(horzcat(X,num2cell(fused1)));
   f2=cell2table(horzcat(X,num2cell(fused2)));
   f3=cell2table(horzcat(X,num2cell(fused3)));
   f4=cell2table(horzcat(X,num2cell(fused4)));
   f5=cell2table(horzcat(X,num2cell(fused5)));
   f6=cell2table(horzcat(X,num2cell(fused6)));
   f7=cell2table(horzcat(X,num2cell(fused7)));
   f8=cell2table(horzcat(X,num2cell(fused8)));
   % x feature vector
    x=red_dim2;
    % y is label
    y=X;
svmmodel=fitcecoc(x,y);
save svmmodel;
%%  Testing
load('svmmodel.mat');

[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
imgname=horzcat(pathname,filename)
[class,dimg]=tellmeClass( imgname ,svmmodel);

%% Inserting Class Label
[r c j]=size(dimg);
position = [(r/2),2];
value = char(class(1));
RGB = insertText(dimg,position,value);
figure,imshow(RGB),title('Numeric values');
