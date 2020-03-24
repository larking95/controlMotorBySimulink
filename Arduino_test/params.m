

%% ‰Šú‰»
close all;
clearvars;
s = tf('s');
z = tf('z');

%% ŠÔ‚Ìİ’è
Ts = 0.01;
Tend = 30;

%% §ŒäŠí‚Ìİ’è
Kp = 8;
Ki = 16;
Kd = 0;

Cfb = Kp + Ki*Ts/(1-z^-1) + Kd*(1-z^-1)/Ts;
