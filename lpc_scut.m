function lpc_scut()
x = wavread('phrase.wav');
subplot(3,1,1);
plot(x);
title('原始语音波形');
%对指定帧位置进行加窗处理
Q = x';
N =256;
Hamm = hamming(N);
frame = 60;
M = Q(((frame-1)*(N/2)+1):((frame-1)*(N/2)+N));
Frame = M.*Hamm';
[B,F,T] = specgram(x,N,N/2,N);
[m,n] = size(B);
for i = 1:m;
    FTframe1(i) = B(i,frame);
end

P = input('请输入预测器阶数 = ');
ai = lpc(Frame,P);
LP = filter([0 -ai(2:end)],1,Frame);
FFT1p = fft(LP);
E = Frame - LP;
subplot(2,1,1),plot(1:N,Frame,1:N,LP,'-r');grid;
title('原始语音和预测语音波形');
subplot(2,1,2),plot(E);grid;
title('预测误差');
pause

fLength(1:2*N) = [M,zeros(1,N)];
Xm = fft(fLength,2*N);
X= Xm.*conj(Xm);
Y = fft(X,2*N);
Rk = Y(1:N);
PART = sum(ai(2:P+1).*Rk(1:P));
G = sqrt(sum(Frame.^2)-PART);

A = (FTframe1 - FFT1p(1:length(F')))./FTframe1;
subplot(2,1,1),plot(F',20*log(abs(FTframe1)),F',(20*log(abs(1./A))),'-r');
grid;

xlabel('频率/dB');ylabel('幅度');
title('短时谱');
subplot(2,1,2),plot(F',(20*log(abs(G./A))));grid;
xlabel('频率/dB');ylabel('幅度');
title('LPC谱');
pause

pitch = fftshift(rceps(E));
M_pitch = fftshift(rceps(Frame));
subplot(2,1,1),plot(M_pitch);grid;
xlabel('语音帧');ylabel('/dB');
title('原始语音帧倒谱');
pause

ai1 = lpc(x,P);
LP1 = filter([0 -ai(2:end)],1,x);
subplot(2,1,1);
specgram(x,N,N/2,N);
title('原始语音语谱图');
subplot(2,1,2);
specgram(LP1,N,N/2,N);
title('预测语音语谱图');




