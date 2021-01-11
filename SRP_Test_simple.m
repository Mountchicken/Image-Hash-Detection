function ham= SRP_Test_simple(image1,image2,N,M,K,choice)
%该函数用以简要测试两张图片的汉明距离
%choice决定求局部特征，全局特征，所有特征,改良模式
switch choice
    case 'ALL'
        hash1=SRP_Hash_Generation(image1,N,M,K);
        hash2=SRP_Hash_Generation(image2,N,M,K);
        ham=SRP_Hamming_Calculation(hash1,hash2);
    case 'LOCAL'
        hash1=Locat_Hash_Generatuon(image1);
        hash2=Locat_Hash_Generatuon(image2);
        ham=SRP_Hamming_Calculation(hash1,hash2);
    case 'GLOBAL'
        hash1=Global_Hash_Generation(image1);
        hash2=Global_Hash_Generation(image2);
        ham=SRP_Hamming_Calculation(hash1,hash2);
    case 'improved'
         hash1=Improved_Hash_Generation(image1);
        hash2=Improved_Hash_Generation(image2);
        ham=SRP_Hamming_Calculation(hash1,hash2);
end
end

% im=rgb2gray(imread('D:\Myimages\ColorImages\Image20.jpg'));
% im1=log(1+double(im));
% im2=im2uint8(mat2gray(im1));
% subplot(1,2,1)
% imshow(im)
% subplot(1,2,2)
% imshow(im2)
