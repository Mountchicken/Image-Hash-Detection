function result= MidValue(A)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
B=sort(A,1);
length=size(A,1);
result=B((length+1)/2,:); %必须返回一个行向量
end

