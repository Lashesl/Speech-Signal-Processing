function pitch_scut()
x = wavread('isolated word.wav');
figure(1);
stem(x,'.');
y = enframe(x,160,80);
l = length(y);
n = 160;
for i=1:l;
    c(i,:) = xcorr(y(i,:));
end
for k=1:l;
    [M1(1,k),I1(1,k)] = max(c(k,:));
    [M2(1,k),I2(1,k)] = max(c(k,1:(I1(1,k)-10)));
end

d = (I1-I2)/8;
figure(2);
stem(d,'.');
axis([0 length(d) 0 14]);
xlabel('帧数(n)');
ylabel('周期(ms)');
title('各帧基因周期');


T1 = medfilt1(d,5);
figure(3);stem(T1,'.');
axis([0 length(T1) 0 14]);
xlabel('帧数(n)');
ylabel('周期(ms)');
title('各帧基因周期');