function [H] = lpfilter(type,P,Q,D0,n,D1)
%该函数用以创建四类低通滤波器 ILPF,BLPF,GLPF,TLPF
%各自type 为 ideal, butterworth, gaussian, trapezoid
%P,Q 分别为填充后的长与宽，即2*M与2*N
%D0 为截止频率 ，D1为梯形滤波器特有参数（此时D0作为转折频率，D1作为截止频率)
%返回参数为滤波矩阵H
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

