function HT = Locat_Hash_Generatuon(image)

%ֻ���ɾֲ���ϣֵ
%�����ж��Ƿ�Ϊ�Ҷ�ͼ�������ǣ���ת��Ϊ�Ҷ�ͼ
N=256;M=8;K=64;
if numel(size(image))==3
    image=rgb2gray(image);
end
%��ͼ��ת��Ϊdouble��ʽ���ӿ촦���ٶ�
image=im2double(image);

%�ٶ�ͼ����ж��������ڲ�
image=imresize(image,[N,N],'bilinear');
%TEST figure(1)
%TEST imshow(image)

%�ڶ�ͼ����и�˹��ͨ�˲���ʹ���Զ��庯��LPF
image=LPF(image,'gaussian',70); %ע�⣬��˹��ͨ�˲����Ľ�ֹƵ�ʿ��ܻ�Խ������Ӱ��
%TEST figure(2)
%TEST imshow(image)
%�۶�ͼ���������С���ֽ�
[LL,LH,HL,HH]=dwt2(image,'haar');
[LL,LH,HL,HH]=dwt2(LL,'haar');
[LL,LH,HL,HH]=dwt2(LL,'haar');
New_len=N/8;
%TEST imshow([LL,LH;HL,HH],[])
%Local Texture Feature

%�ܶ�LL����CS-LBP�任,ʹ���Զ��庯��CSLBP
LL_CSLBP=CSLBP(LL);
%TEST figure(1)
%TEST imshow(LL,[])
%TEST figure(2)
%TEST imshow(LL_CSLBP,[])
%�ݷֿ�,��cell����洢��blocks�У���Ҫ���ã���ʹ��cell2mat����
BlocksCounter=0;
Blocks={}; %����취��ʼ��һ��
for RowCounter=0:M:New_len-M
    for ColCounter=0:M:New_len-M
        BlocksCounter=BlocksCounter+1;
        Blocks{BlocksCounter}=LL_CSLBP(RowCounter+1:RowCounter+M,ColCounter+1:ColCounter+M);     
    end
end
%�޼�����������V
V=zeros(4,BlocksCounter);
for Counter=1:BlocksCounter
    Matr=cell2mat(Blocks(Counter));
    average=mean(Matr(:)); %��ֵ
    variance=var(Matr(:));     %����
    sum=0;
    for i=1:M*M
        sum=sum+(Matr(i)-average)^3;
    end
    third_moment=sum/(M*M); %���׾���
    sum=0;
    for j=1:M*M
        sum=sum+(Matr(i)-average)^4;
    end
    forth_moment=sum/(M*M); %�Ľ׾���
    temp=[average,variance,third_moment, forth_moment]';
    V(:,Counter)=temp;
end
%�߹�һ��V�õ�V'
V=V/max(V(:));
%�����ο�����
C=mean(V,2);
%�������������Q
Q=zeros(4,BlocksCounter);
for i=1:BlocksCounter
    Q(:,i)=abs(V(:,i)-C);
end
Q=abs(V);
%��Ӧ�ð��н����������õ��ֲ���������HT,
for i=1:4
Q(i,:)=Q(i,:)>=mean(Q(i,:));
end
HT=Q;
%���а���������
HT=reshape(HT,[1,numel(HT)]);

end

