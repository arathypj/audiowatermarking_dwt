clear all;clc;clf;
[y,fss]=wavread('C:\Users\PG\Desktop\arathy\main project\byebye.wav');
[co,ln]=wavedec(y,4,'db8');
tmp=co(ln(1):ln(1)+ln(2));
p=size(tmp);
sound(y);
figure(1)
plot(y);
title('Audio Signal');

% Generating the bit pattern with each bit 20 samples long

b=round(rand(1,30));
pattern=[];
for k=1:30
    if b(1,k)==0
        sig=-ones(1,20);
    else
        sig=ones(1,20);
    end
    
    pattern=[pattern sig];
end
figure(2)
plot(pattern);
axis([-1 620 -1.5 1.5]);
title('Original Bit Sequence');
[a,s]=size(pattern);
% Generating the pseudo random bit pattern for spreading
d=round(rand(1,120));
pn_seq=[];
carrier=[];
t=[0:2*pi/4:2*pi];     % Creating 5 samples for one cosine 
for k=1:120
    if d(1,k)==0
        sig=-ones(1,5);
    else
        sig=ones(1,5);
    end
    c=cos(t);   
    carrier=[carrier c];
    pn_seq=[pn_seq sig];
   
end

% Spreading of sequence
spreaded_sig=pattern.*pn_seq;
figure(3)
plot(spreaded_sig)
axis([-1 620 -1.5 1.5]);
title('Spreaded signal');

% BPSK Modulation of the spreaded signal
bpsk_sig=spreaded_sig.*carrier;   % Modulating the signal

figure(4)
plot(bpsk_sig)
axis([-1 620 -1.5 1.5]);
title('BPSK Modulated Signal');

%peak detection

t=tmp;

for j=1:1:s
    m=0;
    for i=1:1:p
        if tmp(i)>m
            m=tmp(i);
            pos(j)=i;
        end
    end
    pek(j)=m;
    for k=1:1:p
        if m==tmp(k)
            tmp(k)=0;
        end
    end
end

pos=pos';

for i=1:1:s
    t(pos(i))=t(pos(i))+ 0.3*bpsk_sig(i);
end
j=1;
for i=ln(1):1:ln(1)+ln(2)
    co(i)=t(j);
    j=j+1;
end

for i=1:1:120
    pos(i)=pos(i)+ln(1);
end
idt=waverec(co,ln,'db8');
figure(5)
plot(idt);
title('Watermarked signal');
sound(idt);
save watermark;









