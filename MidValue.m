function result= MidValue(A)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
B=sort(A,1);
length=size(A,1);
result=B((length+1)/2,:); %���뷵��һ��������
end

