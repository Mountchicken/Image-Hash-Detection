function [U,V] = dftuv(M,N)
% [U，V] = DFTUV（M，N）计算网格频率矩阵U和V。 U和V对于计算可与DFTFILT一起使用的
% 频域滤波器函数很有用。 U和V都是M-by-N。更多细节见冈萨雷斯教材93页
% 设置变量范围
u=0:(M-1);
v=0:(N-1);
% 计算网格的索引，即将网络的原点转移到左上角，因为FFT计算时变换的原点在左上角。
idx = find(u > M / 2);
u(idx) = u(idx) - M;
idy = find(v > N / 2);
v(idy) = v(idy) - N;

% Compute the meshgrid arrays.
% 计算网格矩阵
[V, U] = meshgrid(v, u);
end

