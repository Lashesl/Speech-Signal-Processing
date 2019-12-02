function vad_scut1()

z=0;
x = wavread('conversational speech.wav');
x = x / max(abs(x));
x =filter([1 -0.9375],1,x);
plot(x);
len = length(x);
round = 160;
repeat = 80;
inc = round - repeat;
ka = ceil((len-round)/(round-repeat))+1;
x = [x;zeros((round-repeat)*(ka-1)+round-len,1)];
len =length(x);
w = zeros(round,ka);
for i = 1:ka;
    for k = 1:round;
        w(k,i) = x(k+(i-1)*(round-repeat),1);
    end
end
ST = 0.01;
f =zeros(ka,1);
F = zeros(ka,round);

for i =1:ka
    for k = 0:round-1
        for j = 1:round-k
            F(ka,k+1) = F(ka,k+1)+abs(w(j,i)-w(j+k,i));
        end
        if(k<round-1)
            if(w(k+1,i)>0&&w(k+2,i)<0)
                z = sign(w(k+1,i)-ST)-sign(w(k+2,i)+ST);
            elseif(w(k+1,i)<0&&w(k+2,i)>0)
                z = sign(w(k+2,i)-ST)-sign(w(k+1,i)+ST);
            end
            
          if(z==2)
              f(i,1)=f(i,1)+1;
          end
        end
    end
end
amp = sum(abs(w).^2,1);
% framelen = 240;
% frameinc = 80;

amp1 = 10;
amp2 = 2;
zcr1 = 10;
zcr2 = 6;

minsilence =7;
minlen = 15;
status = 0;
count = 0;
silence = 0;
xpoint = [];

amp1 = min(amp1,max(amp)/4);
amp2 = min(amp2,max(amp)/8);

for n =1 :ka;
    switch status
        case {0,1}
            if amp(n)>amp1
                x1 = max(n-count-1,1);
                xpoint =[xpoint,x1];
                status = 2;
                silence = 0;
                count = count+1;
            elseif amp(n)>amp2||f(n)>zcr2
                status = 1;
                count = count +1;
            else
                status = 0;
                count = 0;
            end
        case 2,
            if amp(n)>amp2||f(n)>zcr2
                count = count +1;
            else
                silence = silence +1;
                if silence < minsilence
                    count = count +1;
            elseif count < minlen
                status = 0;
                silence = 0;
                count = 0;
                else
                    status = 3;
                end
            end
        case 3,
            status = 0;
            count = count-silence/2;
            x2 = x1 +count -1;
            xpoint = [xpoint,x2];
            count=0;
            silence = 0;
    end
end

subplot(3,1,1)
plot(x)
axis([1 length(x) -1 1])
ylabel('Speech');
for i =1:length(xpoint)
line([xpoint(i)*inc xpoint(i)*inc],[-1 1],'Color','red');
end

subplot(3,1,2)
plot(amp);
axis([1 length(amp) 0 max(amp)])
ylabel('Energy');
for i =1:length(xpoint)
line([xpoint(i) xpoint(i)],[min(amp),max(amp)],'Color','green');
end
            
subplot(3,1,3)
plot(f);
axis([1 length(f) 0 max(f)])
ylabel('ZCR');
for i =1:length(xpoint)
line([xpoint(i) xpoint(i)],[min(f),max(f)],'Color','black');
end