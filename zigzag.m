function result= zigzag(Mat)
%��z����ɨ��image������result
%�����ͼ���Ƿ���������Ϊż��
len=size(Mat,1);
temp1=zeros(1,len*len/2+len/2);
temp2=zeros(1,len*len/2+len/2);
temp=zeros(1,len*len/2+len/2);
Counter=2;
temp(1)=Mat(1,1);
Rol=1;Col=1; %�����������
%���Ȼ�������len/2�Σ�������
%�ұ���һ��
% ���¶Խ����ߵ���������1
% ���Խ���û�ߵ���ʱ��������һ��
% ���Խ���û�ߵ���ʱ�����϶Խ����ߵ���������1
%�����ϲ�������󣬽���ʼ�ľ������ź����ᷭת180�㣬
%���������ᷭת180�㣬���µ�������ɾ����������˵����Ͻ�
%�����½ǵĶԽ��ߣ�����ٽ�����תһ�¼��ɵõ�ʣ�µľ���
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
        if Rol==len %�ߵ����½��ˣ���������
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
    %���濪ʼΪ��һ�ε�����׼��
    if times==1
        Counter=2;
        Mat=flip(Mat,1);
        Mat=flip(Mat,2);
        temp(1)=Mat(1,1);
        Rol=1;Col=1; %�����������
    end
end
%������õ�temp1��temp2
%��temp2���ĶԽ���Ԫ��ɾ��������ת
temp2(:,len*len/2-len/2+1:len*len/2+len/2)=[];
temp2=flip(temp2,2);
result=[temp1,temp2];
end
%������

