Images{1000}=0;
files=dir(fullfile('D:\Myimages\SRPImages\images','*.jpg'));
lengthfiles=length(files);
for i=1:lengthfiles
    Im=imread(strcat('D:\Myimages\SRPImages\images\',files(i).name));
    Images{i}=Im;
end
%��ÿһ��ͼƬ���вü�
Indigits=15; %��������
Hams=ones(1,lengthfiles);
for i=1:lengthfiles
    Im=cell2mat(Images(i));
    [row,col,left]=size(Im);
    ImCut=imcrop(Im,[Indigits,Indigits,col-Indigits,row-Indigits]);
    Hams(i)= 1-SRP_Test_simple(Im,ImCut,256,8,64,'GLOBAL')/192;
end
plot(Hams)
title('��������Ϊ15�����ƶ�')