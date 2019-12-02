function shiyan()
del = 2;
a = [];
b = [];

x = wavread('isolated word.wav');
x = x / max(abs(x));
y =enframe(filter([1 -0.9375],1,x),160,80);
i = 1:size(y,1);
amp(i) = sum(abs(y(i,:)),2);

for k = 1:size(y,1)-1
    if amp(k)<del && amp(k+1)>del
        if amp(k-1)<del
            a = [a,k];
        end
    elseif amp(k)>del && amp(k+1)<del;
        if amp(k+2)<del
            b = [b,k];
        end
    end
end
figure

plot(x)
axis([0 length(x) -0.8 0.8]);
for i = 1:size(a,2)
    line([a(i)*80 a(i)*80],[-0.8 0.8],'color','red')
end
for i = 1:size(b,2)
    line([b(i)*80 b(i)*80],[-0.8 0.8],'color','green')
end

         