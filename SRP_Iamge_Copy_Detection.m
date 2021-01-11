function [R,P]=SRP_Iamge_Copy_Detection(N,M,K,threshold)
    %首先读取1000张图片并存储在一个结构数组中(384*256)大小
    Images{1000}=0;
    files=dir(fullfile('D:\Myimages\SRPImages\images','*.jpg'));
    lengthfiles=length(files);
    for i=1:lengthfiles
        Im=imread(strcat('D:\Myimages\SRPImages\images\',files(i).name));
        Images{i}=Im;
    end
    %接下来随机选取100张图片作为基准
    a=randperm(1000);
    index=a(1:100);
    Query_images{100}=0;
    for i=1:100
        Query_images{i}=cell2mat(Images(index(i)));
    end
    %从原图中删除Query_images
    Images(index)=[];
    %接下来生成copied images;
    Copied_images{18,100}=0; %每一列代表一张图像的18种copy_images;
    Counter=1;
    for i=1:100
        Im=cell2mat(Query_images(i));
        %Gamma correction
        Ratio=[0.75,1.25];
        for n=1:2
            Imp=imadjust(Im,[0,1],[0,1],Ratio(n));
            Copied_images{n,i}=Imp;
        end
        %Rescaling
        Ratio=[0.5,1.5];
        for n=1:2
            Imp=imresize(Im,Ratio(n));
             Copied_images{n+2,i}=Imp;
        end
        %Salt&Pepper
        Ratio=[0.002,0.006];
        for n=1:2
            Imp=imnoise(Im,'salt & pepper',Ratio(n));
            Copied_images{n+4,i}=Imp;
        end
        %Speckle
        Ratio=[0.002,0.006];
        for n=1:2
            Imp=imnoise(Im,'speckle',Ratio(n));
            Copied_images{n+6,i}=Imp;
        end
        %Gaussian Noise
        Ratio=[0.002,0.006];
        for n=1:2
            Imp=imnoise(Im,'Gaussian',Ratio(n));
            Copied_images{n+8,i}=Imp;
        end
        %Gaussain low_pass filtering
        Ratio=[50,75];
        for n=1:2
            Imp=LPF(Im,'gaussian',Ratio(n));
            Copied_images{n+10,i}=Imp;
        end  
        %Mean Filter
        Ratio=[3,5];
        for n=1:2
             Im_filter=fspecial('average',Ratio(n));
             Imp=imfilter(Im,Im_filter);
            Copied_images{n+12,i}=Imp;
        end
        %Median Filter
        Ratio=[3,5];
        for n=1:2
            Imp=MidvalueFilter(Im,Ratio(n));
            Copied_images{n+14,i}=Imp;
        end
        %Mosaic
        Ratio=[2,4];
        for n=1:2
            Imp=Mosaic(Im,Ratio(n));
            Copied_images{n+16,i}=Imp;
        end
    end

    %接下来进行检测,总体思路：
    %在Query_images中有100张原图
    %在Images中有900张原图
    %在Copied_images中有1800张Query_images的翻版
    %Recall rate求法，将100张原图分别与1800+900张图
    %进行求汉明距离，并设定一个阈值，低于该阈值杯判定为copy
    %统计最后的copy数，记作N3，再统计从1800张中获得的copy数记作N1
    %N2=1800；

    N2=1800;
    N1=0;
    N3=0; 
    %threshold=67;
    %threshold=68;
    %threshold=72;
    %threshold=74;
    %threshold=76;
    %threshold=78;
        for i=1:100
            Qimage=cell2mat(Query_images(i));
            %先于900张原图运算
            for n=1:900
                ham=SRP_Test_simple(Qimage,cell2mat(Images(n)),N,M,K);
                if ham<threshold
                    N3=N3+1;
                end
            end
            %再与1800张图运算
            for n=1:1800
                ham=SRP_Test_simple(Qimage,cell2mat(Copied_images(n)),N,M,K);
                if ham<threshold
                    N3=N3+1;
                    if 18*i-17<=n && n<=18*i
                        N1=N1+1;
                    end
                end
            end
        end
    R=N1/N2;
    P=N1/N3;
end





















