function [R,P]=SRP_Iamge_Copy_Detection(N,M,K,threshold)
    %���ȶ�ȡ1000��ͼƬ���洢��һ���ṹ������(384*256)��С
    Images{1000}=0;
    files=dir(fullfile('D:\Myimages\SRPImages\images','*.jpg'));
    lengthfiles=length(files);
    for i=1:lengthfiles
        Im=imread(strcat('D:\Myimages\SRPImages\images\',files(i).name));
        Images{i}=Im;
    end
    %���������ѡȡ100��ͼƬ��Ϊ��׼
    a=randperm(1000);
    index=a(1:100);
    Query_images{100}=0;
    for i=1:100
        Query_images{i}=cell2mat(Images(index(i)));
    end
    %��ԭͼ��ɾ��Query_images
    Images(index)=[];
    %����������copied images;
    Copied_images{18,100}=0; %ÿһ�д���һ��ͼ���18��copy_images;
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

    %���������м��,����˼·��
    %��Query_images����100��ԭͼ
    %��Images����900��ԭͼ
    %��Copied_images����1800��Query_images�ķ���
    %Recall rate�󷨣���100��ԭͼ�ֱ���1800+900��ͼ
    %�����������룬���趨һ����ֵ�����ڸ���ֵ���ж�Ϊcopy
    %ͳ������copy��������N3����ͳ�ƴ�1800���л�õ�copy������N1
    %N2=1800��

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
            %����900��ԭͼ����
            for n=1:900
                ham=SRP_Test_simple(Qimage,cell2mat(Images(n)),N,M,K);
                if ham<threshold
                    N3=N3+1;
                end
            end
            %����1800��ͼ����
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





















