function [H] = lpfilter(type,P,Q,D0,n,D1)
%�ú������Դ��������ͨ�˲��� ILPF,BLPF,GLPF,TLPF
%����type Ϊ ideal, butterworth, gaussian, trapezoid
%P,Q �ֱ�Ϊ����ĳ������2*M��2*N
%D0 Ϊ��ֹƵ�� ��D1Ϊ�����˲������в�������ʱD0��Ϊת��Ƶ�ʣ�D1��Ϊ��ֹƵ��)
%���ز���Ϊ�˲�����H
%ues function dftuv to set up the meshgrid arrays needed for computing
[U,V]=dftuv(P,Q);
D=fftshift(sqrt(U.^2+V.^2));
switch type
    case 'ideal'
        H=double(D<=D0);
    case 'butterworth'
        H=1./(1+(D/D0).^(2*n));
    case 'gaussian'
        H=exp((-D.^2)/(2*D0*D0));
    case 'trapezoid'
        H=(D<=D0)+(-D+2).*(D>D0&D<=D1);
    otherwise
        error('Unkonw type')
end

