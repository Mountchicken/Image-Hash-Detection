function distance=SRP_Hamming_Calculation(Hash1,Hash2)
%�ú������Լ���������ϣ���м�ĺ�������
%���SRP_Hash_Generation����ʹ��
result=xor(Hash1,Hash2);
distance=sum(result(:)==1);

end

