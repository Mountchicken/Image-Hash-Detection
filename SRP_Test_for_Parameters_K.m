%���Ե�KֵΪ32��64��521��Nȡ256��Mȡ8
%���Ե�threshold ȡ 64 66 68 70 74 80
%threshold=64
%threshold=66
%threshold=68
%threshold=70
%threshold=74
%threshold=80
R=ones(1,3);
P=ones(1,3);
Ratio=[32,64,512];
for times=1:3
    K=Ratio(times);
    [R(times),P(times)]=SRP_Iamge_Copy_Detection(256,8,K,threshold);
end
%һ������Ԥ����Ҫ3��Сʱ��