function result=Mosaic(im,filtersize)
%该函数用以给RGB或者Gray图像加马赛克，其原理是计算一个领域像素的平均值
%再将该平均值赋给领域中所有像素，其原理与空间卷积一致
if numel(size(im))==2 %处理灰度图
        im=im2double(im);
%         [row1,col1]=size(im);
%         down_left=mod(row1,filtersize);
%         right_left=mod(col1,filtersize);
%         if down_left~=0
%             im=padarray(im,[filtersize-down_left,filtersize-right_left],'replicate','post');
%         end
        [row,col]=size(im);
        down_times=row/filtersize-1;
        right_times=col/filtersize-1;
        X=1;Y=1; %定位点
        result=ones(size(im));
        for i=0:down_times
            for j=0:right_times      
                area=im(X:X+filtersize-1,Y:Y+filtersize-1);
                result(X:X+filtersize-1,Y:Y+filtersize-1)=ones(size(area))*mean(area(:));
                Y=Y+filtersize;
            end
            X=X+filtersize;
            Y=1;
        end
        %最后再把多余的填充行列裁剪掉
%         result=result(1:row1,1:col1);
else %处理彩色图，取三个分量来进行计算
        part{1}=im2double(im(:,:,1));
        part{2}=im2double(im(:,:,2));
        part{3}=im2double(im(:,:,3));
        for counter=1:3
                im=cell2mat(part(counter));
%                 [row1,col1]=size(im);
%                 down_left=mod(row1,filtersize);
%                 right_left=mod(col1,filtersize);
%                 if down_left~=0
%                     im=padarray(im,[filtersize-down_left,filtersize-right_left],'replicate','post');
%                 end
                [row,col]=size(im);
                down_times=row/filtersize-1;
                right_times=col/filtersize-1;
                X=1;Y=1; %定位点
                temp=ones(size(im));
                for i=0:down_times
                    for j=0:right_times      
                        area=im(X:X+filtersize-1,Y:Y+filtersize-1);
                        temp(X:X+filtersize-1,Y:Y+filtersize-1)=ones(size(area))*mean(area(:));
                        Y=Y+filtersize;
                    end
                    X=X+filtersize;
                    Y=1;
                end
                part{counter}=temp;
        end
        result=cat(3,cell2mat(part(1)),cell2mat(part(2)),cell2mat(part(3)));
%         R=cell2mat(part(1));
%         R=R(1:row1,1:col1);
%         G=cell2mat(part(2));
%         G=G(1:row1,1:col1);
%         B=cell2mat(part(3));
%         B=B(1:row1,1:col1);
%         result=cat(3,R,G,B);
end
end
