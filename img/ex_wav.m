% Wavread

cd /home/momo/CNAM/CPDA/Signal/cours/img/;
fic = 'regularfries.wav';
[x,fs,bits] = wavread(fic);
x = x(:,1);
lx = length(x);
t = [0:lx-1];
t = t/fs;

plot(t,x,'-;wav;')

axis([0,1,-1.2,1.2]);
xlabel('Temps (s)');
ylabel('Amplitude');
print('./ex_sig.eps', '-deps');

