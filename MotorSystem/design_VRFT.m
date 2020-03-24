% VRFTの設計スクリプト
% モータの速度制御系に対して設計する。

% Copyright (c) 2019 larking95(https://qiita.com/larking95)
% Released under the MIT Licence 
% https://opensource.org/licenses/mit-license.php

%% 初期化
clearvars;
close all;

%% 設計仕様の決定

% 参照モデル M
tau = 0.2;
M = c2d(1/(tau*s + 1), Ts); % ゼロ次ホールドで離散化した一次遅れ系

% 重み関数
gW = 100;
W = c2d(gW/(s + gW), Ts);   % ゼロ次ホールドで離散化した一次遅れ系

%制御器構造 beta
beta = minreal([1; Ts/(1 - z^-1); (1 - z^-1)/Ts]); % PID制御器

%% 入出力データの取得
switch 1
    case 1  % 取得済みのデータから設計する
        load('resultIdent\20200320_2019');
        P = Gtf_d;  % 制御対象モデル
        
    case 2  % 新たにデータを取得して設計する
        if ~exist('u', 'var')   % データがない時，実験を自動実行
            modelName = 'motorVelocityIdentify';    % 実行するモデル名
            assert(exist(modelName, 'file'));       % モデルの存在確認
            load_system(modelName);                 % モデルのロード
            set_param(modelName, 'SimulationCommand', 'start'); % 実行
            while ~strcmp(get_param(modelName, 'SimulationStatus'), 'stopped')
                pause(1.0); % 実験終了まで待つ
            end
        end
        P = load('resultIdent/20200320_2019', 'Gtf_d');  % 制御対象モデル
end

u0 = u.signals.values;  % 入力データ
y0 = y.signals.values;  % 出力データ

phi_u = 1;              % 入力のパワースペクトル

%% VRFTによる設計
% プレフィルタ L
L = minreal(M*(1 - M)/phi_u);

% フィルタに通した入力信号 ul
ul = lsim(L, u0);

% 疑似誤差信号 el = 
el = lsim(L*(M^(-1) - 1), y0);

%パラメータ前の制御器出力 phi
phi = lsim(beta, el);

%最適なパラメータ rho
rho = phi\ul;               % 行列形式で最小二乗法を解く(mldivide)

%設計した制御器 C
C = minreal(rho.' * beta);  % 制御器を求める

%評価関数 Jmr
Jmr = mean(ul - phi * rho); % 行列形式で評価関数を確認

%% 性能の確認
% 制御器を実装したシステム全体 G
G = minreal(feedback(P*C, 1));

% ステップ応答
fig1 = figure('name', 'Step plot');
stepplot(G, M);

%ボード線図表示
fig2 = figure('name', 'Bode plot of controller');
bodeplot(G, M, {1,100});

figs = [fig1, fig2];

%% データの保存
isAppropriateInput = false;
while isAppropriateInput == false
    validStrings = {'y', 'n'};
    str = input('Do you want to save the result ?(y/n): ', 's');
    if strcmp(str, validStrings(1)) == true
        if ~exist('resultVRFT', 'dir')
            mkdir('resultVRFT');   % フォルダがなければ作成する
        end
        saveName = ['./resultVRFT/',...
            datestr(datetime('now'), 'yyyymmdd_HHMM')];
        save(saveName + ".mat", '-regexp', '^(?!(fig)).');  % fig系を保存しない
        savefig(figs, saveName, 'compact');
        disp('The result is saved.');
        isAppropriateInput = true;
    elseif strcmp(str, validStrings(2)) == true
        disp('The result is not saved.');
        isAppropriateInput = true;
    else
        continue;
    end
end
clearvars isAppropriateInput saveName
