%���Ե�MֵΪ4��8��16��Nȡ256��Kȡ64
%���Ե�threshold ȡ 64 66 68 70 74 80
%threshold=64
%threshold=66
%threshold=68
%threshold=70
%threshold=74
%threshold=80
R=ones(1,3);
P=ones(1,3);
for times=1:3
    M=2^(times+1);
    [R(times),P(times)]=SRP_Iamge_Copy_Detection(256,M,64,threshold);
end
%һ������Ԥ����Ҫ3��Сʱ��