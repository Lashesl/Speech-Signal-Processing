%f=350
fs=8000;%����Ƶ��
N=70;  %��������
T=1/fs; %������� % T = ��N-1��*Ts;%����ʱ��

t = 0:1/fs:(N-1)*T;
ft = sin(2*pi*350*t);%�������ź�Ϊ��������ź�
% subplot(3,1,1);
% plot(t,ft);grid on;
% title('�����źŵ�������ʽ');
% subplot(3,1,2);
% stem(t,ft)
subplot(3,1,3);
x1=fft(ft,100);
M=length(x1);
k=0:M-1;
wk=2*k/M;
stem(wk,x1);


