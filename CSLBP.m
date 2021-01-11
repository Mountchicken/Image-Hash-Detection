function result= CSLBP(im)
%该函数将灰度图转换为CSLBP形式
if numel(size(im))==3
im=rgb2gray(im);
end
[row,col]=size(im);
result=zeros(row,col);
%首先将图像转换为double形式，加快处理速度
im=im2double(im);
%接下来要将图像以replicate形式进行扩展
im=padarray(im,[1,1],'replicate');

%接下来进入核心算法
%按行，按列进行扫描
for i=2:row+1
    for j=2:col+1
        result(i,j)=((im(i,j+1)-im(i,j-1))>=0)*(2^0)+...
                        ((im(i+1,j+1)-im(i-1,j-1))>=0)*(2^1)+...
                        ((im(i+1,j)-im(i-1,j))>=0)*(2^2)+...
                        ((im(i+1,j-1)-im(i-1,j+1))>=0)*(2^3);
    end
end
%注意，返回的图像的像素范围为0~15，若想要正常显示，可采用
%以下代码
% result=CSLBP(image);
% result=result./(15*ones(size(result)));
% imshow(result)

