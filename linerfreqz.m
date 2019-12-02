fs=5e7;%����Ƶ��
ts=1/fs;%�������
T=0.1e-3;%�仯ʱ��
B=10e4;%�仯����Ƶ��
K=2e9;%��Ƶб��
N=round(T/ts); %������
t=linspace(0,T,N);
f0=9.5e5;
st=cos(2*pi*(f0+0.5*K*t).*t);
subplot(2,1,1);
plot(t,abs(st));
title('LFM�ź�ʱ��');
xlabel('t/s');
ylabel('����');

subplot(2,1,2)
fft_st=fftshift(fft(st));
f=linspace(-fs/2,fs/2,N);
plot(f,abs(fft_st));
title('LFM�ź�Ƶ��');
axis([-2e6 2e6 0 700 ])
xlabel('f/Hz');
ylabel('����');