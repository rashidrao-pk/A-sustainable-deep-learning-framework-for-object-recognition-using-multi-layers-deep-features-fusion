parpool

%%  Fusing two pre trained networks
cd F:\Study\MS(CS)\Papers\5_object\transfer_mat_caltech101
load x3.mat
x3_transfer_fc7=x3;
save x3_transfer_fc7.mat
clear x3 m j imagecount filename pathname class  allfoldernames ans classifier imc imr net rootFolder predictedLabels testLabels testSet trainingFeatures trainingLabels trainingSet w1 x featureLayer imds categories new ent_1 ent_2 ent_3 ent_4 ent_b_1 ent_b_2 ent_b_3 ent_b_4 ferry laptop f b c a airplanes alexnet categories2 lenf wd tbl red_dim red_dim1 red_dim2 finalfusion fusedpre_pca r red_dim red_dim1 red_dim2 i vggs19 xy_alexnet_fc6 outputFolder minSetCount testFeatures final feat finalfeat2 im im_ imgSets temp validationSet train Xtrain finalfeat
%%
cd F:\Study\MS(CS)\Papers\5_object\deep_alexnet_mat_caltech101
load xy.mat;
x3_alex_fc7=xy;
cd F:\Study\MS(CS)\Papers\5_object\transfer_mat_caltech101
save x3_alex_fc7
clear xy allfoldernames ans classifier imc imr net rootFolder class featureVar imagecount j m pathname filename predictedLabels testLabels testSet trainingFeatures trainingLabels trainingSet w1 x featureLayer imds categories new ent_1 ent_2 ent_3 ent_4 ent_b_1 ent_b_2 ent_b_3 ent_b_4 ferry laptop f airplanes alexnet categories2 lenf wd tbl red_dim red_dim1 red_dim2 finalfusion fusedpre_pca r red_dim red_dim1 red_dim2 i vggs19 xy_alexnet_fc6 outputFolder minSetCount testFeatures final feat finalfeat2 im im_ imgSets temp validationSet train Xtrain y finalfeat

a=xy1;
b=x3;
c=x3;

clear x3_transfer_fc7 x3_alex_fc7

if(size(a,1)~=size(b,1))
disp('Not Equal ')
if(size(a,1)>size(b,1))
%disp('A is Greater')
    a=a(1:size(b,1),:);
else
    %disp('B is Greater')
    b=b(1:size(a,1),:);
end
else
    disp('Already Equal ')
end



wd=width(a);
wd=(wd*2);
wd=wd-2;

f = cell(1,4097);
lenf=length(f);

% ff = cell(1,1000);
% lenff=length(ff);

a=a(:,1:end-1);
b=b(:,1:end-1);

c=c(:,1:end-1);

clc





for i=1:lenf
   f{i} = strcat('x', num2str((i-1)+lenf));
end
lenf=lenf-1;

i=1;
while(i<lenf)
b.Properties.VariableNames{i} = f{i};
i=i+1;
end
% i=1;
% while(i<1000)
% c.Properties.VariableNames{i} = ff{i};
% i=i+1;
% end
%%
y=cellstr(ytrain);
% clear alex_fc7_pascal3dplus vgg19_fc7_pascal wd vgg19 alexnet
clear ent_1 ent_2 wd v lenf f ff ent_3 ent_4 ent_b_1 ent_b_2 ent_b_3 ent_b_4 i lenf r red_dim1 red_dim2 FV1 FV2

a=table2array(a);
b=table2array(b);

c=table2array(c);



%%  Apply Entropy Before PCA
[row, col]=size(a);
a=double(a);
ent_a= Find_Entropy(a,col);
ent_a=ent_a(:,1:4000);

%%  Apply Entropy Before PCA
[row, col]=size(b);
b=double(b);
ent_b= Find_Entropy(a,col);
ent_b=ent_b(:,1:1000);
%%
[row, col]=size(c);
c=double(c);
ent_c1= Find_Entropy(c,col);
ent_c1=ent_c1(:,1:1000);
clear r 
%%
%%

fused_entropy_before_fusion=horzcat(ent_a,ent_b_c1);
newfused_entropy_before_fusion=fused_entropy_before_fusion;
fused_entropy_after_fusion=horzcat(a,b,c);

fused_alex4096_vgg194096_vgg16_4096=horzcat(a,b,c);



[row, col]=size(fused_entropy_after_fusion);
fused_entropy_after_fusion=double(fused_entropy_after_fusion);
fused_entropy_after_fusion_5000= Find_Entropy(fused_entropy_after_fusion,col);
fused_entropy_after_fusion_5000=fused_entropy_after_fusion_5000(:,1:5500);


[row, col]=size(newfused_entropy_before_fusion);

%%

%%
fused_entropy_before_fusion=num2cell(fused_entropy_before_fusion);
fused_entropy_after_fusion_5000=num2cell(fused_entropy_after_fusion_5000);
fused_alex4096_vgg194096_vgg16_4096=num2cell(fused_alex4096_vgg194096_vgg16_4096);

c1=num2cell(c1);

c1=cell2table(c1);

fused_entropy_before_fusion=horzcat(y,fused_entropy_before_fusion);
fused_entropy_after_fusion_5000=horzcat(ytrain,fused_entropy_after_fusion_5000);
fused_alex4096_vgg194096_vgg16_4096=horzcat(ytrain,fused_alex4096_vgg194096_vgg16_4096);


FFV_c1=horzcat(ytrain,num2cell(c1));
FFV_c2=horzcat(ytrain,num2cell(ent_c1));

%%      Table Conversion
FFV_c1=cell2table(FFV_c1);
FFV_c2=cell2table(FFV_c2);

fused_entropy_before_fusion=cell2table(fused_entropy_before_fusion);
fused_entropy_after_fusion_5000=cell2table(fused_entropy_after_fusion_5000);
fused_alex4096_vgg194096_vgg16_4096=cell2table(fused_alex4096_vgg194096_vgg16_4096);

clear ent_a ent_b ent_c ent_c1 row col fused_entropy_before_fusion fused_entropy_before_fusion
clear y

save('fused_ent_b4_fusn_al4000_v19_500_v16_500','fused_entropy_before_fusion')
save('fused_entropy_after_fusion_5000','fused_entropy_after_fusion_5000','ytrain')

save('fused_alex4096_vgg194096_vgg16_4096','fused_alex4096_vgg194096_vgg16_4096','ytrain')



p = gcp;
delete(p)
task();

f = warndlg('Task Completed Successfully',...
'Memory Warning', 'modal');

