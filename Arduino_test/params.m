

%% 初期化
close all;
clearvars;
s = tf('s');
z = tf('z');

%% 時間の設定
Ts = 0.01;
Tend = 30;

%% 制御器の設定
Kp = 8;
Ki = 16;
Kd = 0;

Cfb = Kp + Ki*Ts/(1-z^-1) + Kd*(1-z^-1)/Ts;
