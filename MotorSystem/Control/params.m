

%% ������
% No operations

%% ���Ԃ̐ݒ�
if ~exist('Ts', 'var')
    Ts = 0.01;
end
Tstep = 5;
Tend = 10;

%% �����̐ݒ�
if ~exist('Cfb', 'var')
    z = tf('z');
    % �f�t�H���g�̐����
    Kp = 10; Ki = 0; Kd = 0;
    Cfb = Kp + Ki*Ts/(1-z^-1) + Kd*(1-z^-1)/Ts;
end
