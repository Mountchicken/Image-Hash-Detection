function HD= Global_Hash_Generation(image)
N=256;M=8;K=64;
%image为输入图像，N为线性内插大小，M为小块尺寸
%该函数用以生成哈希序列

%首先判断是否为灰度图，若不是，则转换为灰度图
if numel(size(image))==3
    image=rgb2gray(image);
end
%将图像转换为double形式，加快处理速度
image=im2double(image);

%①对图像进行二次线性内插
image=imresize(image,[N,N],'bilinear');
%TEST figure(1)
%TEST imshow(image)

%②对图像进行高斯低通滤波，使用自定义函数LPF
image=LPF(image,'gaussian',70); %注意，高斯低通滤波器的截止频率可能会对结果产生影响
%TEST figure(2)
%TEST imshow(image)
%③对图像进行三阶小波分解
[LL,LH,HL,HH]=dwt2(image,'haar');
[LL,LH,HL,HH]=dwt2(LL,'haar');
[LL,LH,HL,HH]=dwt2(LL,'haar');
New_len=N/8;
%TEST imshow([LL,LH;HL,HH],[])
%Local Texture Feature
HH_DCT=dct2(HH);
HH_DCT_zigzag=zigzag(HH_DCT);
%取前3K个元素作为全局矩阵
G=HH_DCT_zigzag(:,1:3*K);
H=abs(G-mean(G(:))*ones(size(G)));
HD=H>=mean(H(:));
end

