# A sustainable deep learning framework for object recognition using multi-layers deep features fusion and selection
Google Scholar Link -> https://scholar.google.com/citations?user=F5u_Z5MAAAAJ
Paper Link -> https://www.mdpi.com/2071-1050/12/12/5037

# Feature Extraction
In proposed method, we first employed VGG-VeryDeep-19 model for feature extraction. Each model has
different layers and hence the output may vary from model to model. We exploited this advantage of DeepCNN and extracted feature using FC-7 layer. And finally the average pooling is performed for noise
removal. A feature vector of length 1x4096 is obtained for each image.
Secondly we applied Inception-V3 for feature extraction, and the feature are extracted using “avg_pool”
layer. A feature vector of length 1x2048 is obtained as the output.
![Serial_Fusion_Model_Full](https://user-images.githubusercontent.com/25412736/165830457-345dc478-9d91-4d63-bbaa-b4c81ed9c4a8.png)

  # Feature Extraction using InceptionV3
  ![Inception_Model](https://user-images.githubusercontent.com/25412736/165830770-2a587ea5-7c50-4baf-b617-bb18f797c503.png)

  # Feature Extraction using VGG-19
  ![VGG_MODEL_NEw](https://user-images.githubusercontent.com/25412736/165830842-9278d80b-095c-4343-9280-33b054d23c07.png)


# Feature Fusion and Selection
After feature extraction, features are fused into a single vector using parallel based fusion. After fusion a
fused vector of length FVx6144 was achieved where FV denotes the quantity of images. In Figure 1, feature
extraction and fusion technique is shown. As the size of feature vector increases, classification accuracy
may increase, but the execution time also increases. To deal with the enhanced execution time, we applied
entropy based selection on the final fused vector instead of applying entropy individually on each vector
![Birds_labeled](https://user-images.githubusercontent.com/25412736/165830603-4a07c193-dd8a-406b-b3f4-4cf528f37ea9.jpg)

![Final_Green](https://user-images.githubusercontent.com/25412736/165830649-003261f0-5d76-473f-bf2a-6a8ca44c8aee.png)

![Final_Green](https://user-images.githubusercontent.com/25412736/165830673-82e9c6d8-5688-41d5-abc1-c145b506d58e.png)



Please cite us, if you use these codes , Codes written and used for Object Detection and Classifications paper
<br>
contact us if facing any issue<br>
Rashidcui@ciitwah.edu.pk
<br>
Rashid047571@gmail.com
