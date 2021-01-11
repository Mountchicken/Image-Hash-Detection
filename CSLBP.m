function result= CSLBP(im)
%�ú������Ҷ�ͼת��ΪCSLBP��ʽ
if numel(size(im))==3
im=rgb2gray(im);
end
[row,col]=size(im);
result=zeros(row,col);
%���Ƚ�ͼ��ת��Ϊdouble��ʽ���ӿ촦���ٶ�
im=im2double(im);
%������Ҫ��ͼ����replicate��ʽ������չ
im=padarray(im,[1,1],'replicate');

%��������������㷨
%���У����н���ɨ��
for i=2:row+1
    for j=2:col+1
        result(i,j)=((im(i,j+1)-im(i,j-1))>=0)*(2^0)+...
                        ((im(i+1,j+1)-im(i-1,j-1))>=0)*(2^1)+...
                        ((im(i+1,j)-im(i-1,j))>=0)*(2^2)+...
                        ((im(i+1,j-1)-im(i-1,j+1))>=0)*(2^3);
    end
end
%ע�⣬���ص�ͼ������ط�ΧΪ0~15������Ҫ������ʾ���ɲ���
%���´���
% result=CSLBP(image);
% result=result./(15*ones(size(result)));
% imshow(result)

