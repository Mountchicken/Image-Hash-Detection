function HT = Locat_Hash_Generatuon(image)

%只生成局部哈希值
%首先判断是否为灰度图，若不是，则转换为灰度图
N=256;M=8;K=64;
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

%④对LL进行CS-LBP变换,使用自定义函数CSLBP
LL_CSLBP=CSLBP(LL);
%TEST figure(1)
%TEST imshow(LL,[])
%TEST figure(2)
%TEST imshow(LL_CSLBP,[])
%⑤分块,以cell数组存储于blocks中，若要调用，请使用cell2mat函数
BlocksCounter=0;
Blocks={}; %想个办法初始化一下
for RowCounter=0:M:New_len-M
    for ColCounter=0:M:New_len-M
        BlocksCounter=BlocksCounter+1;
        Blocks{BlocksCounter}=LL_CSLBP(RowCounter+1:RowCounter+M,ColCounter+1:ColCounter+M);     
    end
end
%⑥计算特征矩阵V
V=zeros(4,BlocksCounter);
for Counter=1:BlocksCounter
    Matr=cell2mat(Blocks(Counter));
    average=mean(Matr(:)); %均值
    variance=var(Matr(:));     %方差
    sum=0;
    for i=1:M*M
        sum=sum+(Matr(i)-average)^3;
    end
    third_moment=sum/(M*M); %三阶矩阵
    sum=0;
    for j=1:M*M
        sum=sum+(Matr(i)-average)^4;
    end
    forth_moment=sum/(M*M); %四阶矩阵
    temp=[average,variance,third_moment, forth_moment]';
    V(:,Counter)=temp;
end
%⑦归一化V得到V'
V=V/max(V(:));
%⑧计算参考矩阵
C=mean(V,2);
%⑨计算特征矩阵Q
Q=zeros(4,BlocksCounter);
for i=1:BlocksCounter
    Q(:,i)=abs(V(:,i)-C);
end
Q=abs(V);
%⑩应该按行进行量化，得到局部特征矩阵HT,
for i=1:4
Q(i,:)=Q(i,:)>=mean(Q(i,:));
end
HT=Q;
%进行按列重排序
HT=reshape(HT,[1,numel(HT)]);

end

