
clearvars;
close all;

% ボードを取得
myboard = arduino('COM6', 'Uno');

% サンプリング周期
Ts = 0.1;

% シミュレーション時間
Tend = 10;

% データ長
N = Tend/Ts;

% 入力電圧
u = nan([N, 1]);

c = 1;
disp('start');
tic
% 繰り返し処理
for k = 1:N
    if c < 3
        u(k) = 0;
    elseif c < 7
        u(k) = 1;
    else
        u(k) = 0;
    end
    if c == 10
        c = 1;
    else
        c = c + 1;
    end
    myboard.writeDigitalPin('D6', u(k));
    myboard.writeDigitalPin('D7', 0);
    pause(Ts);
end
toc
fig = figure();
plot(u);
