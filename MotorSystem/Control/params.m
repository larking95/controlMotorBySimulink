

%% 初期化
% No operations

%% 時間の設定
if ~exist('Ts', 'var')
    Ts = 0.01;
end
Tstep = 5;
Tend = 10;

%% 制御器の設定
if ~exist('Cfb', 'var')
    z = tf('z');
    % デフォルトの制御器
    Kp = 10; Ki = 0; Kd = 0;
    Cfb = Kp + Ki*Ts/(1-z^-1) + Kd*(1-z^-1)/Ts;
end
