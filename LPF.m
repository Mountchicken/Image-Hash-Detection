function [result] = LPF(im,type,D0,n,D1)
%�ú���Ϊ��ͨ�˲�����
%imΪuint8����ͼ����Ϊ��ɫͼ���߲�ɫͼ,ע�⣬��ɫͼ����hsi����
%����type Ϊ ideal, butterworth, gussian, trapezoid��
%D0 Ϊ��ֹƵ�� ��D1Ϊ�����˲������в�������ʱD0��Ϊת��Ƶ�ʣ�D1��Ϊ��ֹƵ��)
%���ز���Ϊ�˲����
processing=im2double(im);
if numel(size(im))==3 %��ɫͼȡǿ�ȷ���
hsi=RGB2HSI(processing);
processing=hsi(:,:,3);
end
%����1���������
%im=Paddedsize(im);��������䣬Ч���ܲ�
[P,Q]=size(processing);
%����2�������˲�����ʹ���Զ��庯��lpfilter
if strcmpi(type,'ideal')
    H=lpfilter(type,P,Q,D0);
elseif strcmpi(type,'butterworth')
    H=lpfilter(type,P,Q,D0,n);
elseif strcmpi(type,'gaussian')
    H=lpfilter(type,P,Q,D0);
elseif strcmpi(type,'trapezoid')
    H=lpfilter(type,P,Q,D0,n,D1);
end
%����3�����ͼ����и���Ҷ�任
Im=fftshift(fft2(processing));
%����4��Ƶ�������
Y=H.*Im;
%����5�����и���Ҷ���任
processed=abs(ifft2(Y));
%����ǻ�ɫͼ��ֱ�ӷ���
if numel(size(im))==2
result=processed;
else
%����ǲ�ɫͼ������ƴ��
newhsi=cat(3,hsi(:,:,1),hsi(:,:,2),processed);
result=HSI2RGB(newhsi);
end
end

