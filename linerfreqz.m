fs=5e7;%采样频率
ts=1/fs;%采样间隔
T=0.1e-3;%变化时间
B=10e4;%变化带宽频率
K=2e9;%调频斜率
N=round(T/ts); %采样点
t=linspace(0,T,N);
f0=9.5e5;
st=cos(2*pi*(f0+0.5*K*t).*t);
subplot(2,1,1);
plot(t,abs(st));
title('LFM信号时域');
xlabel('t/s');
ylabel('幅度');

subplot(2,1,2)
fft_st=fftshift(fft(st));
f=linspace(-fs/2,fs/2,N);
plot(f,abs(fft_st));
title('LFM信号频谱');
axis([-2e6 2e6 0 700 ])
xlabel('f/Hz');
ylabel('幅度');