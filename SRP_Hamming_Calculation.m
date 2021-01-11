function distance=SRP_Hamming_Calculation(Hash1,Hash2)
%该函数用以计算两个哈希序列间的汉明距离
%配合SRP_Hash_Generation函数使用
result=xor(Hash1,Hash2);
distance=sum(result(:)==1);

end

