function HD= Global_Hash_Generation(image)
N=256;M=8;K=64;
%imageΪ����ͼ��NΪ�����ڲ��С��MΪС��ߴ�
%�ú����������ɹ�ϣ����

%�����ж��Ƿ�Ϊ�Ҷ�ͼ�������ǣ���ת��Ϊ�Ҷ�ͼ
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
HH_DCT=dct2(HH);
HH_DCT_zigzag=zigzag(HH_DCT);
%ȡǰ3K��Ԫ����Ϊȫ�־���
G=HH_DCT_zigzag(:,1:3*K);
H=abs(G-mean(G(:))*ones(size(G)));
HD=H>=mean(H(:));
end

