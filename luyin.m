filename = ('a_male.wav');
[x,fs] = audioread(filename);
figure(1);
stem(x,'.');
title('�����źŵĲ���')
n=160;
for m=1:length(x)/n;
    for k=1:n;
        Rm(k)=0;
        for i=(k+1):n;
            Rm(k)=Rm(k)+x(i+(m-1)*n)*x(i-k+(m-1)*n);
        end
    end
        p=Rm(10:n);
        [Rmax,N(m)]= max(p);
    end
    N=N+10;
    T=N/8;
    figure(2);stem(T,'.');axis([0 length(T) 0 10]);
    xlabel('֡����n��');ylabel('���ڣ�ms��');title('��֡��������')
   