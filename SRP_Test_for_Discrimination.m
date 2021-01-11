%该文件用以进行Discrimination TEst
%读取1000张图片
Images{1000}=0;
files=dir(fullfile('D:\Myimages\SRPImages\images','*.jpg'));
lengthfiles=length(files);
for i=1:lengthfiles
    Im=imread(strcat('D:\Myimages\SRPImages\images\',files(i).name));
    Images{i}=Im;
end
TestImages{1}=cell2mat(Images(1));
TestImages{2}=cell2mat(Images(102));
TestImages{3}=cell2mat(Images(266));
TestImages{4}=cell2mat(Images(422));
TestImages{5}=cell2mat(Images(522));
TestImages{6}=cell2mat(Images(613));
TestImages{7}=cell2mat(Images(731));
TestImages{8}=cell2mat(Images(833));
TestImages{9}=cell2mat(Images(950));
Hammings=zeros(1000,9); %列数代表扫描次数，每次扫描都任意选取一副图像作为基准
for times=1:9
    Im=cell2mat(TestImages(times));
    for i=1:lengthfiles
        Hammings(i,times)=SRP_Test_simple(Im,cell2mat(Images(i)),256,8,64,'LOCAL')/64;
    end
end
%去除每一列中多余的一个元素
line1=Hammings(:,1);
line1(1)=[];
line2=Hammings(:,2);
line2(102)=[];
line3=Hammings(:,3);
line3(266)=[];
line4=Hammings(:,4);
line4(422)=[];
line5=Hammings(:,5);
line5(522)=[];
line6=Hammings(:,6);
line6(613)=[];
line7=Hammings(:,7);
line7(731)=[];
line8=Hammings(:,8);
line8(833)=[];
line9=Hammings(:,9);
line9(950)=[];
Hammings=[line1,line2,line3,line4,line5,line6,line7,line8,line9];
%作图
x=1:999*9;
Hammings=reshape(Hammings,[1,999*9]);
plot(x,Hammings,'ro');





