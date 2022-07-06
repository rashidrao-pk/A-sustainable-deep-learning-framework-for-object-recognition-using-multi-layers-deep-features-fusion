%% Code to Tabulate Anayze Network
% net=inceptionv3;
% analyzeNetwork(net);

layer_count=size(net.Layers,1);
for i=1:layer_count
lay_name=net.Layers(i, 1).Name;
layer_name_2 = split(lay_name,'_');
layer_name_3=layer_name_2{1,1};

    if layer_name_3=="conv2d"
        disp([num2str(i) ' - Weight & Bias']);
        sz_weight{i,1}=size(net.Layers(i,1).Weights);
        sz_bias{i,1}=size(net.Layers(i,1).Bias);

    elseif layer_name_3=="batch"
        sz_offset{i,1}=size(net.Layers(i,1).Offset);
        sz_scale{i,1}=size(net.Layers(i,1).Scale);
        disp([num2str(i) ' - Offset & Scale']);
    else
        
    end
end