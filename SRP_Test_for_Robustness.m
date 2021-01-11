Airplane=rgb2gray(imresize(imread('D:\Myimages\SRPImages\Airplane.jpg'),[512,512],'bilinear'));
Baloon=rgb2gray(imresize(imread('D:\Myimages\SRPImages\Baloon.jpg'),[512,512],'bilinear'));
House=rgb2gray(imresize(imread('D:\Myimages\SRPImages\House.jpg'),[512,512],'bilinear'));
Kid=rgb2gray(imresize(imread('D:\Myimages\SRPImages\Kid.jpg'),[512,512],'bilinear'));
Peppers=rgb2gray(imresize(imread('D:\Myimages\SRPImages\Peppers.jpg'),[512,512],'bilinear'));
Images{1}=Airplane;
Images{2}=Baloon;
Images{3}=House;
Images{4}=Kid;
Images{5}=Peppers;
% figure(1)
% subplot(1,5,1)
% imshow(Airplane)
% subplot(1,5,2)
% imshow(Baloon)
% subplot(1,5,3)
% imshow(House)
% subplot(1,5,4)
% imshow(Kid)
% subplot(1,5,5)
% imshow(Peppers)
Hamming=zeros(46,5);%每一列都是对应一张图像，60种操作下的结果
for Counter=1:5
    Im=im2double(cell2mat(Images(Counter)));
    %Brightness adjustment 使用自定义函数GrayEnhencement
    Ratio=[20,40,60,80];
    for n=1:4
        Imp=GrayEnhencement(Im,Ratio(n));
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(n,Counter)=ham;
    end
    %Contrast adjustment 使用自定义函数GrayEnhencement
    Ratio=[20,40,60,80];
    for n=1:4
        Imp=GrayEnhencement(Im,Ratio(n));
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(4+n,Counter)=ham;
    end
    %Gamma correction
    Ratio=[0.75,0.9,1.1,1.25];
    for n=1:4
        Imp=imadjust(Im,[0,1],[0,1],Ratio(n));
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(8+n,Counter)=ham;
    end

    %JPEG compression
    %独立于循环外

    %Rescaling
    Ratio=[0.5,0.75,1.1,1.5];
    for n=1:4
        Imp=imresize(Im,Ratio(n));
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(14+n,Counter)=ham;
    end
    %Salt&Pepper变化
    for n=1:4
        Imp=imnoise(Im,'salt & pepper',n*0.002);
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(18+n,Counter)=ham;
    end
    %Speckle变化
    for n=1:4
        Imp=imnoise(Im,'speckle',n*0.002);
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(22+n,Counter)=ham;
    end
    %Gaussian Noise
    for n=1:4
        Imp=imnoise(Im,'gaussian',0,n*0.002);
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(26+n,Counter)=ham;
    end
    %Gaussian filtering,采用D为30，50，70，90的间距
    Ratio=[30,50,70,90];
    for n=1:4
        Imp=LPF(Im,'gaussian',Ratio(n));
       ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(30+n,Counter)=ham;
    end  
    %Mean Filter
    for n=1:2
        Im_filter=fspecial('average',[2*n+1,2*n+1]);
        Imp=imfilter(Im,Im_filter);
       ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(34+n,Counter)=ham;
    end  
    %Median Filter 使用的是自定义函数MidValueFilter
    for n=1:2
        Imp=MidvalueFilter(Im,2*n+1);
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(36+n,Counter)=ham;
    end     
    %WaterMark 待实现
    %独立于循环外

    %Mosaic 使用自定义函数Mosaic
    Ratio=[2,4,6,8];
     for n=1:4
        Imp=Mosaic(Im,Ratio(n));
        ham=SRP_Test_simple(Im,Imp,256,8,64,'LOCAL')/64;
        Hamming(40+n,Counter)=ham;
     end     
    %Plus subtitles 待实现
    %独立于循环外
end

%JPEG compression
Airplane_jpeg3=rgb2gray(imread('D:\Myimages\SRPImages\Airplane_jpeg3.jpg'));
ham=SRP_Test_simple(Airplane,Airplane_jpeg3,256,8,64,'LOCAL')/64;
Hamming(13,1)=ham;
Airplane_jpeg5=rgb2gray(imread('D:\Myimages\SRPImages\Airplane_jpeg5.jpg'));
ham=SRP_Test_simple(Airplane,Airplane_jpeg5,256,8,64,'LOCAL')/64;
Hamming(14,1)=ham;

Baloon_jpeg3=rgb2gray(imread('D:\Myimages\SRPImages\Baloon_jpeg3.jpg'));
ham=SRP_Test_simple(Baloon,Baloon_jpeg3,256,8,64,'LOCAL')/64;
Hamming(13,2)=ham;
Baloon_jpeg5=rgb2gray(imread('D:\Myimages\SRPImages\Baloon_jpeg5.jpg'));
ham=SRP_Test_simple(Baloon,Baloon_jpeg5,256,8,64,'LOCAL')/64;
Hamming(14,2)=ham;

House_jpeg3=rgb2gray(imread('D:\Myimages\SRPImages\House_jpeg3.jpg'));
ham=SRP_Test_simple(House,House_jpeg3,256,8,64,'LOCAL')/64;
Hamming(13,3)=ham;
House_jpeg5=rgb2gray(imread('D:\Myimages\SRPImages\House_jpeg5.jpg'));
ham=SRP_Test_simple(House,House_jpeg5,256,8,64,'LOCAL')/64;
Hamming(14,3)=ham;

Kid_jpeg3=rgb2gray(imread('D:\Myimages\SRPImages\Kid_jpeg3.jpg'));
ham=SRP_Test_simple(Kid,Kid_jpeg3,256,8,64,'LOCAL')/64;
Hamming(13,4)=ham;
Kid_jpeg5=rgb2gray(imread('D:\Myimages\SRPImages\Kid_jpeg5.jpg'));
ham=SRP_Test_simple(Kid,Kid_jpeg5,256,8,64,'LOCAL')/64;
Hamming(14,4)=ham;

Peppers_jpeg3=rgb2gray(imread('D:\Myimages\SRPImages\Peppers_jpeg3.jpg'));
ham=SRP_Test_simple(Peppers,Peppers_jpeg3,256,8,64,'LOCAL')/64;
Hamming(13,5)=ham;
Peppers_jpeg5=rgb2gray(imread('D:\Myimages\SRPImages\Peppers_jpeg5.jpg'));
ham=SRP_Test_simple(Peppers,Peppers_jpeg5,256,8,64,'LOCAL')/64;
Hamming(14,5)=ham;

%WaterMark
Airplane_watermark3=rgb2gray(imread('D:\Myimages\SRPImages\Airplane_watermark3.jpg'));
ham=SRP_Test_simple(Airplane,Airplane_watermark3,256,8,64,'LOCAL')/64;
Hamming(39,1)=ham;
Airplane_watermark5=rgb2gray(imread('D:\Myimages\SRPImages\Airplane_watermark5.jpg'));
ham=SRP_Test_simple(Airplane,Airplane_watermark5,256,8,64,'LOCAL')/64;
Hamming(40,1)=ham;

Baloon_watermark3=rgb2gray(imread('D:\Myimages\SRPImages\Baloon_watermark3.jpg'));
ham=SRP_Test_simple(Airplane,Airplane_watermark3,256,8,64,'LOCAL')/64;
Hamming(39,2)=ham;
Baloon_watermark5=rgb2gray(imread('D:\Myimages\SRPImages\Baloon_watermark5.jpg'));
ham=SRP_Test_simple(Baloon,Baloon_watermark5,256,8,64,'LOCAL')/64;
Hamming(40,2)=ham;

House_watermark3=rgb2gray(imread('D:\Myimages\SRPImages\House_watermark3.jpg'));
ham=SRP_Test_simple(House,House_watermark3,256,8,64,'LOCAL')/64;
Hamming(39,3)=ham;
House_watermark5=rgb2gray(imread('D:\Myimages\SRPImages\House_watermark5.jpg'));
ham=SRP_Test_simple(House,House_watermark5,256,8,64,'LOCAL')/64;
Hamming(40,3)=ham;

Kid_watermark3=rgb2gray(imread('D:\Myimages\SRPImages\Kid_watermark3.jpg'));
ham=SRP_Test_simple(Kid,Kid_watermark3,256,8,64,'LOCAL')/64;
Hamming(39,4)=ham;
Kid_watermark5=rgb2gray(imread('D:\Myimages\SRPImages\Kid_watermark5.jpg'));
ham=SRP_Test_simple(Kid,Kid_watermark5,256,8,64,'LOCAL')/64;
Hamming(40,4)=ham;


Peppers_watermark3=rgb2gray(imread('D:\Myimages\SRPImages\Peppers_watermark3.jpg'));
ham=SRP_Test_simple(Peppers,Peppers_watermark3,256,8,64,'LOCAL')/64;
Hamming(39,5)=ham;
Peppers_watermark5=rgb2gray(imread('D:\Myimages\SRPImages\Peppers_watermark5.jpg'));
ham=SRP_Test_simple(Peppers,Peppers_watermark5,256,8,64,'LOCAL')/64;
Hamming(40,5)=ham;

%SubTitles
Airplane_title10=rgb2gray(imread('D:\Myimages\SRPImages\Airplane_title10.jpg'));
ham=SRP_Test_simple(Airplane,Airplane_title10,256,8,64,'LOCAL')/64;
Hamming(45,1)=ham;
Airplane_title20=rgb2gray(imread('D:\Myimages\SRPImages\Airplane_title20.jpg'));
ham=SRP_Test_simple(Airplane,Airplane_title20,256,8,64,'LOCAL')/64;
Hamming(46,1)=ham;

Baloon_title10=rgb2gray(imread('D:\Myimages\SRPImages\Baloon_title10.jpg'));
ham=SRP_Test_simple(Baloon,Baloon_title10,256,8,64,'LOCAL')/64;
Hamming(45,2)=ham;
Baloon_title20=rgb2gray(imread('D:\Myimages\SRPImages\Baloon_title20.jpg'));
ham=SRP_Test_simple(Baloon,Baloon_title20,256,8,64,'LOCAL')/64;
Hamming(46,2)=ham;

House_title10=rgb2gray(imread('D:\Myimages\SRPImages\House_title10.jpg'));
ham=SRP_Test_simple(House,House_title10,256,8,64,'LOCAL')/64;
Hamming(45,3)=ham;
House_title20=rgb2gray(imread('D:\Myimages\SRPImages\House_title20.jpg'));
ham=SRP_Test_simple(House,House_title20,256,8,64,'LOCAL')/64;
Hamming(46,3)=ham;

Kid_title10=rgb2gray(imread('D:\Myimages\SRPImages\Kid_title10.jpg'));
ham=SRP_Test_simple(Kid,Kid_title10,256,8,64,'LOCAL')/64;
Hamming(45,4)=ham;
Kid_title20=rgb2gray(imread('D:\Myimages\SRPImages\Kid_title20.jpg'));
ham=SRP_Test_simple(Kid,Kid_title20,256,8,64,'LOCAL')/64;
Hamming(46,4)=ham;

Peppers_title10=rgb2gray(imread('D:\Myimages\SRPImages\Peppers_title10.jpg'));
ham=SRP_Test_simple(Peppers,Peppers_title10,256,8,64,'LOCAL')/64;
Hamming(45,5)=ham;
Peppers_title20=rgb2gray(imread('D:\Myimages\SRPImages\Peppers_title20.jpg'));
ham=SRP_Test_simple(Peppers,Peppers_title20,256,8,64,'LOCAL')/64;
Hamming(46,5)=ham;

%下面开始画图
x=1:46;
figure(1)
plot(x,Hamming(:,1)','r*')
hold on 
plot(x,Hamming(:,2),'kh')
plot(x,Hamming(:,3),'yo')
plot(x,Hamming(:,4),'cp')
plot(x,Hamming(:,5),'ms')
axis([0,50,0,0.3])
legend('Airplane','Baloon','House','Kid','Peppers')













