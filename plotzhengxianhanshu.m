%f=350
fs=8000;%抽样频率
N=70;  %采样点数
T=1/fs; %采样间隔 % T = （N-1）*Ts;%采样时长

t = 0:1/fs:(N-1)*T;
ft = sin(2*pi*350*t);%这样的信号为采样后的信号
% subplot(3,1,1);
% plot(t,ft);grid on;
% title('抽样信号的连续形式');
% subplot(3,1,2);
% stem(t,ft)
subplot(3,1,3);
x1=fft(ft,100);
M=length(x1);
k=0:M-1;
wk=2*k/M;
stem(wk,x1);


