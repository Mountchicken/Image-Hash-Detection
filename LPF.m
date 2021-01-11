function [result] = LPF(im,type,D0,n,D1)
%该函数为低通滤波函数
%im为uint8类型图，可为单色图或者彩色图,注意，彩色图是在hsi操作
%各自type 为 ideal, butterworth, gussian, trapezoid）
%D0 为截止频率 ，D1为梯形滤波器特有参数（此时D0作为转折频率，D1作为截止频率)
%返回参数为滤波结果
processing=im2double(im);
if numel(size(im))==3 %彩色图取强度分量
hsi=RGB2HSI(processing);
processing=hsi(:,:,3);
end
%步骤1，进行填充
%im=Paddedsize(im);不建议填充，效果很差
[P,Q]=size(processing);
%步骤2，构建滤波器，使用自定义函数lpfilter
if strcmpi(type,'ideal')
    H=lpfilter(type,P,Q,D0);
elseif strcmpi(type,'butterworth')
    H=lpfilter(type,P,Q,D0,n);
elseif strcmpi(type,'gaussian')
    H=lpfilter(type,P,Q,D0);
elseif strcmpi(type,'trapezoid')
    H=lpfilter(type,P,Q,D0,n,D1);
end
%步骤3，填充图像进行傅里叶变换
Im=fftshift(fft2(processing));
%步骤4，频域做点积
Y=H.*Im;
%步骤5，进行傅里叶反变换
processed=abs(ifft2(Y));
%如果是灰色图，直接返回
if numel(size(im))==2
result=processed;
else
%如果是彩色图，重新拼接
newhsi=cat(3,hsi(:,:,1),hsi(:,:,2),processed);
result=HSI2RGB(newhsi);
end
end

