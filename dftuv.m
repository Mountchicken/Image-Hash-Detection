function [U,V] = dftuv(M,N)
% [U��V] = DFTUV��M��N����������Ƶ�ʾ���U��V�� U��V���ڼ������DFTFILTһ��ʹ�õ�
% Ƶ���˲������������á� U��V����M-by-N������ϸ�ڼ�������˹�̲�93ҳ
% ���ñ�����Χ
u=0:(M-1);
v=0:(N-1);
% ������������������������ԭ��ת�Ƶ����Ͻǣ���ΪFFT����ʱ�任��ԭ�������Ͻǡ�
idx = find(u > M / 2);
u(idx) = u(idx) - M;
idy = find(v > N / 2);
v(idy) = v(idy) - N;

% Compute the meshgrid arrays.
% �����������
[V, U] = meshgrid(v, u);
end

