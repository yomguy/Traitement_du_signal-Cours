% Premier test octave

f0 = 50;
f1 = 100;
k = 1;
a = f0/f1;
t = [0:1/10000:1];
f = [1:1:1000];

x=k*sin(2*pi*f0*t);
y=k*sin(2*pi*f1*t);

figure(1);
%plot(t, x , '-;sin(2*pi*50t);', t, y, '.@;sin(2*pi*100*t);');
plot(t, x , ';sin(2*pi*50t);', t, y, ';sin(2*pi*100*t);');
axis([0,0.1,-1.2,1.2]);
xlabel('Temps (s)');
ylabel('Amplitude');
print('./sinus_ech.eps', '-deps');

fx = zeros(1000,1);
fy = zeros(1000,1);
fx(f0) = k;
fy(f1) = a;

%[b0 b1] = bar([f0 f1],[k a]);

figure(2);
semilogx(f,fx,';sin(2*pi*50t);',f,fy,';sin(2*pi*100*t);');
axis([10,1000,0,1.2]);
xlabel('Frequence (Hz)');
ylabel('Amplitude');
print('./sinus_ech_ft.eps', '-deps');