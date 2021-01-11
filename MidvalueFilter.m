function processedImage = MidvalueFilter(image,filterSize)
%该函数进行中值滤波，由奇数filterSize指定滤波器大小，3，5，7即可,type分为'gray','rgb'代表不同空间
if numel(size(image))==2 %灰度图
[M,N]=size(image);%原图尺寸
%进行扩充
f=padarray(image,[filterSize,filterSize],'replicate');
g=colfilt(f,[filterSize,filterSize],'sliding',@mid_value);
%进行裁剪
processedImage=g(filterSize+1:filterSize+M,filterSize+1:filterSize+N);
else %rgb图,分别在三个分量进行滤波感觉效果更好
M=size(image,1);
N=size(image,2);
R=image(:,:,1);
G=image(:,:,2);
B=image(:,:,3);
R1=padarray(R,[filterSize,filterSize],'replicate');
G1=padarray(G,[filterSize,filterSize],'replicate');
B1=padarray(B,[filterSize,filterSize],'replicate');
Rf=colfilt(R1,[filterSize,filterSize],'sliding',@mid_value);
Gf=colfilt(G1,[filterSize,filterSize],'sliding',@mid_value);
Bf=colfilt(B1,[filterSize,filterSize],'sliding',@mid_value);
Rp=Rf(filterSize+1:filterSize+M,filterSize+1:filterSize+N);
Gp=Gf(filterSize+1:filterSize+M,filterSize+1:filterSize+N);
Bp=Bf(filterSize+1:filterSize+M,filterSize+1:filterSize+N);
processedImage=cat(3,Rp,Gp,Bp);
end
end


