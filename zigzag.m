function result= zigzag(Mat)
%以z字形扫描image，返回result
%输入的图像是方阵，且行数为偶数
len=size(Mat,1);
temp1=zeros(1,len*len/2+len/2);
temp2=zeros(1,len*len/2+len/2);
temp=zeros(1,len*len/2+len/2);
Counter=2;
temp(1)=Mat(1,1);
Rol=1;Col=1; %定义横纵坐标
%首先会向右走len/2次，规则是
%右边走一步
% 左下对角线走到列数等于1
% 当对角线没走到底时，向下走一格
% 当对角线没走到底时，右上对角线走到行数等于1
%当以上步骤结束后，将初始的矩阵沿着横中轴翻转180°，
%再沿纵中轴翻转180°，重新迭代，再删除掉多迭代了的右上角
%到左下角的对角线，最后再将矩阵反转一下即可得到剩下的矩阵
for times=1:2
    for i=1:len/2
        Col=Col+1;
        temp(Counter)=Mat(Rol,Col);
        Counter=Counter+1;
        while Col~=1
            Rol=Rol+1;
            Col=Col-1;
            temp(Counter)=Mat(Rol,Col);
            Counter=Counter+1;
        end
        if Rol==len %走到左下角了，结束迭代
            break;
        else
            Rol=Rol+1;
            temp(Counter)=Mat(Rol,Col);
            Counter=Counter+1;
        end
        while Rol~=1
            Rol=Rol-1;
            Col=Col+1;
            temp(Counter)=Mat(Rol,Col);
            Counter=Counter+1;
        end
    end
    if times==1
        temp1=temp;
    else
        temp2=temp;
    end
    %下面开始为下一次迭代做准备
    if times==1
        Counter=2;
        Mat=flip(Mat,1);
        Mat=flip(Mat,2);
        temp(1)=Mat(1,1);
        Rol=1;Col=1; %定义横纵坐标
    end
end
%结束后得到temp1，temp2
%将temp2最后的对角线元素删除，并反转
temp2(:,len*len/2-len/2+1:len*len/2+len/2)=[];
temp2=flip(temp2,2);
result=[temp1,temp2];
end
%接下来

