close all;
%clear all;

f0 = 20;
f1 = 22050;
t1 = 1;
fe = 44100;
fc = 3000;
a = 1/(1+fe/(2*pi*fc));

t = [0:1/fe:t1];
n = length(t);
N = 1;

for k=1:2

    s = randn(1,n);
    %sweep = sin(2*pi*(f0*t1)/log(f1/f0) * (exp(t'/t1*log(f1/f0))-1))';
    sf(1) = s(1);
    
    % Avec une boucle
    tic;
    for i=2:n
        sf(i)=a*s(i)+(1-a)*sf(i-1);
    end
    t_boucle(k) = toc;
    
    % Avec filter
    tic;
    sff = filter(a,[1 a-1],s);
    t_filter(k) = toc;
    
    % Fonction de transfert
    nfft = 16384;
    fft_s = fft(s,nfft);
    fft_sf = fft(sf,nfft);
    fft_sff = fft(sff,nfft);
    f = [0:fe/nfft:fe/2];
    f(1) = [];

    mod_FT(k,:) = abs(fft_sf)./abs(fft_s);
    pha_FT(k,:) = angle(fft_sf);
    mod_FTF(k,:) = abs(fft_sff)./abs(fft_s);
    pha_FTF(k,:) = angle(fft_sff);

end

mod_FT = mean(mod_FT);
figure(1)
semilogx(f,20*log10(mod_FT(1:nfft/2)));
hold on
semilogx(f,20*log10(abs(1./(1+j*(f/fc)))),'r');
title(['Module de la fonction de transfert par la methode recursive (reel / theorique)']);
xlabel(['Frequence (Hz)']);
ylabel(['Amplitude (dB)']);

pha_FT = mean(pha_FT);
figure(2)
semilogx(f,unwrap(pha_FT(1:nfft/2)));
xlabel(['Frequence (Hz)']);
ylabel(['Phase (rad)']);
title(['Phase de la fonction de transfert par la méthode recursive']);

mod_FTF = mean(mod_FTF);
figure(3)
semilogx(f,20*log10(mod_FTF(1:nfft/2)));
hold on
semilogx(f,20*log10(abs(1./(1+j*(f/fc)))),'r');
title(['Module de la fonction de transfert par la fonction filter (reel / theorique)']);
xlabel(['Frequence (Hz)']);
ylabel(['Amplitude (dB)']);

pha_FTF = mean(pha_FTF);
figure(4)
semilogx(f,unwrap(pha_FTF(1:nfft/2)));
xlabel(['Frequence (Hz)']);
ylabel(['Phase (rad)']);
title(['Phase de la fonction de transfert par la fonction filter']);

'temps boucle (s): '
t_boucle
'temps filtre (s): '
t_filter

hold on
plot(t_filter,'r');

pause;

