

%% ������
close all;
clearvars;
s = tf('s');
z = tf('z');

%% ���Ԃ̐ݒ�
Ts = 0.01;
Tend = 30;

%% �����̐ݒ�
Kp = 8;
Ki = 16;
Kd = 0;

Cfb = Kp + Ki*Ts/(1-z^-1) + Kd*(1-z^-1)/Ts;
