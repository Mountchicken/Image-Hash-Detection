function processedImage = MidvalueFilter(image,filterSize)
%�ú���������ֵ�˲���������filterSizeָ���˲�����С��3��5��7����,type��Ϊ'gray','rgb'����ͬ�ռ�
if numel(size(image))==2 %�Ҷ�ͼ
[M,N]=size(image);%ԭͼ�ߴ�
%��������
f=padarray(image,[filterSize,filterSize],'replicate');
g=colfilt(f,[filterSize,filterSize],'sliding',@mid_value);
%���вü�
processedImage=g(filterSize+1:filterSize+M,filterSize+1:filterSize+N);
else %rgbͼ,�ֱ����������������˲��о�Ч������
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


