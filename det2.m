load watermark.mat
idt=awgn(idt,50);
[c,l]=wavedec(idt,4,'db8');


for i=1:1:120
    pk(i)=c(pos(i));
end
for i=1:1:120
    df(i)=(pk(i)-pek(i))/0.3;
end
for i=1:1:120
    if abs(df(i))>6
        b(i)=1;
    else
        b(i)=0;
    end
end
figure(7)
plot(b);

rxsig=bpsk_sig.*carrier;
demod_sig=[];
for i=1:600
    if rxsig(i)>=0
    rxs =1;
else
    rxs =-1;
    end
    demod_sig=[demod_sig rxs];
end
figure(8)
plot(demod_sig)
axis([-1 620 -1.5 1.5]);
title('Demodulated Signal');

despread_sig=demod_sig.*pn_seq;
figure(9)
plot(despread_sig)
axis([-1 620 -1.5 1.5]);
title('Despreaded data');

% sq=despread_sig.*despread_sig;
% de=pattern.*despread_sig;
% sim=de/sqrt(sq);
% disp(sim);


jk=y.*y;
r=size(jk);
dh=0;
for i=1:1:r
    dh=dh+jk(i);
end

hg=(y-idt).*(y-idt);
dm=0;
for i=1:1:r
    dm=dm+hg(i);
end
lp=dh/dm;
snr=10*log10(lp);
disp('SNR=');
disp(snr);










