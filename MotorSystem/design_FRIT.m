% FRIT�̐݌v�X�N���v�g
% ���[�^�̑��x����n�ɑ΂��Đ݌v����B

% Copyright (c) 2019 larking95(https://qiita.com/larking95)
% Released under the MIT Licence 
% https://opensource.org/licenses/mit-license.php

%% ������
clearvars;
close all;

%% �݌v�d�l�̌���
% �T���v�����O�^�C���Ɖ��Z�q
Ts = 0.01;
s = tf('s');        % ���v���X���Z�q s
z = tf('z', Ts);    % ���Ԑi�݉��Z�q z

% �Q�ƃ��f�� Td
% tau = 0.2;
% Td = c2d(1/(tau*s + 1), Ts);    % �[�����z�[���h�ŗ��U�������ꎟ�x��n
tau = 0.1;
Td = c2d(1/(tau*s + 1), Ts);    % �[�����z�[���h�ŗ��U�������ꎟ�x��n

% �����\�� C(rho)
Crho = @(rho) rho(1) + rho(2)*Ts/(1-z^-1) + rho(3)*(1-z^-1)/Ts; % PID�����

% ���������̃p�����[�^
rho0 = [10, 0.0, 0.0];              % �K���Ȕ�ᐧ���i���艻����j

% ��������� C0
C0 = Crho(rho0);

%% ���o�̓f�[�^�̎擾
% %�f�[�^�擾�ɗp������͐M�� u  (�X�e�b�v�M��)
% N = 1000;           % �f�[�^��
% r0 = ones([N, 1]);  % �M���̃x�N�g��
% 
% % ����Ώۃ��f�� P
% Tp = 0.74;
% Kp = 1.02;
% P = c2d(Kp/(Tp*s + 1), Ts);
% 
% % �����̕��[�v�V�X�e��
% T0 = feedback(C0*P, 1);
% 
% % ����Ώۂ̏o�͐M�� y0
% y0 = lsim(T0, r0);  
% 
% % ������͐M�� u0
% u0 = lsim(C0, r0 - y0);

switch 2
    case 1  % �擾�ς݂̃f�[�^����݌v����
%         load('resultIdent\20200320_2019');
        P = Gtf_d;  % ����Ώۃ��f��
        
    case 2  % �V���Ƀf�[�^���擾���Đ݌v����
        if ~exist('u', 'var')   % �f�[�^���Ȃ����C�������������s
            Cfb = C0;                                   % ������
            modelName = 'motorVelocityControlSystem';   % ���s���郂�f����
            addpath('./Control');
            assert(exist(modelName, 'file') ~= 0);       % ���f���̑��݊m�F
            load_system(modelName);                 % ���f���̃��[�h
            set_param(modelName, 'SimulationCommand', 'start'); % ���s
            while ~strcmp(get_param(modelName, 'SimulationStatus'), 'stopped')
                pause(1.0); % �����I���܂ő҂�
            end
            rmdir([modelName, '_ert_rtw'], 's');
            delete([modelName, '*']);
            rmpath('./Control');
        end
        S_ident = load('resultIdent/20200320_2019');
        P = S_ident.Gtf_d;  % ����Ώۃ��f��
        clearvars S_ident;
end

r0 = r.signals.values(4.5 <= r.time & r.time <= 7.0);  % �Q�ƐM�� r0
u0 = u.signals.values(4.5 <= u.time & u.time <= 7.0);  % ������͐M�� u0
y0 = y.signals.values(4.5 <= y.time & y.time <= 7.0);  % ����Ώۂ̏o�͐M�� y0
% r0 = r0 - r0(1);
% u0 = u0 - u0(1);
% y0 = y0 - y0(1);

%% FRIT�ɂ��݌v
% �œK�����̕]���֐� f(x)
f = @(x) Jfrit(Crho(x), x, y0, u0, Td);

global C_ideal;     % ���z�����
global fun;         % �p�����g���C�Y���ꂽ�����
global vidObj;      % ����쐬�p�̃r�f�I�I�u�W�F�N�g

C_ideal = minreal(Td/(1 - Td)/P);
fun = Crho;
vidObj = VideoWriter('visualizeFRIT.mp4','MPEG-4');
vidObj.FrameRate = 4;
open(vidObj);       % �r�f�I�t�@�C�����J��

%�œK�ȃp�����[�^ rho
switch 3
    case 1
        % fminsearch �𗘗p�iMATLAB�g���݁j
        opt = optimset(...
            'Display', 'iter',...
            'PlotFcns', @optimplotfval,...
            'OutputFcn', @outfun);
        [rho, ~, ~, info] = fminsearch(f, rho0, opt);
    case 2
        % fminunc �𗘗p�iOptimization toolbox�j
        opt = optimoptions('fminunc',...
            'MaxIterations', 400,...
            'Display', 'iter',...
            'PlotFcn', 'optimplotfval',...
            'OutputFcn', @outfun);
        [rho, ~, ~, info] = fminunc(f, rho0, opt);
    case 3
        % fmincon �𗘗p�iOptimization toolbox�j
        opt = optimoptions('fmincon',...
            'Display', 'iter',...
            'PlotFcn', 'optimplotfval',...
            'OutputFcn', @outfun);
        [rho, ~, ~, info] = fmincon(f, rho0,...
             -eye(length(rho0)), zeros(size(rho0)), [], [], [], [], [], opt);
%             [], [], [], [], zeros(size(rho0)), inf(size(rho0)), [], opt);
end

close(vidObj);      % �r�f�I�t�@�C�������

%�݌v��������� C
C = Crho(rho);  % ���������߂�

%�]���֐� Je
Je0 = Jfrit(C0, rho0, y0, u0, Td);      % ���������̕]���l
Je  = Jfrit(C, rho, y0, u0, Td);        % �݌v���������̕]���l
disp("J_frit(C_0) = " + num2str(Je0));
disp("J_frit(C_opt) = " + num2str(Je));

%% ���\�̊m�F
% ���������������V�X�e���S�� G
G = minreal(feedback(P*C, 1));

% �X�e�b�v����
fig1 = figure('name', '�X�e�b�v����');
stepplot(G, Td);

%�{�[�h���}�\��
fig2 = figure('name', '���[�v�V�X�e���̃{�[�h���}');
bodeplot(G, Td, {1,100});

figs = [fig1, fig2];

%% �f�[�^�̕ۑ�
isAppropriateInput = false;
while isAppropriateInput == false
    validStrings = {'y', 'n'};
    str = input('Do you want to save the result ?(y/n): ', 's');
    if strcmp(str, validStrings(1)) == true
        if ~exist('resultFRIT', 'dir')
            mkdir('resultFRIT');   % �t�H���_���Ȃ���΍쐬����
        end
        saveName = ['./resultFRIT/',...
            datestr(datetime('now'), 'yyyymmdd_HHMM')];
        save(saveName + ".mat", '-regexp', '^(?!(fig)).');  % fig�n��ۑ����Ȃ�
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

%% ���[�J���֐�
function val = Jfrit(C, rho, y0, u0, Td)
% FRIT �̕]���֐����v�Z����

% �����̊m�F
validateattributes(C, {'tf', 'ss'}, {'scalar'}, 1);
validateattributes(rho, {'numeric'}, {'vector'}, 2);
validateattributes(y0, {'numeric'}, {'vector'}, 3);
validateattributes(u0, {'numeric'}, {'vector', 'size', size(y0)}, 4);
validateattributes(Td, {'tf', 'ss'}, {'scalar'}, 5);

% ���萫�̊m�F(fmincon �ȊO�̏ꍇ�̑΍�)
if ~isempty(find(rho < 0, 1))
    val = inf;
    return;
end

W = c2d(tf(100, [1, 100]), 0.01);
% �^���Q�ƐM�����v�Z
r_tilde = lsim(C^-1, u0) + y0;

% �Q�ƃ��f���̉������v�Z
y_tilde = lsim(W*Td, r_tilde);
y0=lsim(W, y0);
% y0��y_tilde�̍���]��
val = norm(y0 - y_tilde, 2)^2;
end

function stop = outfun(x, optimValues, state)
    % ����킪�X�V����Ă����l�q���v���b�g����

    % �O���[�o���ϐ��̐錾
    global fun;
    global C_ideal;
    global vidObj;

    % �i���ϐ��̒�`
    persistent fig;       % figure handle
    persistent popt;

    % �o�͊֐��̒��g
    stop = false;           % �œK�����I�����Ȃ�
    if state == 'init'
        fig = figure('name', 'How to optimize controller');
        popt = bodeoptions();
        popt.Xlim = [10^-2, 10^4];
        popt.Ylim = {[0, 70], [-90, 45]};
    end

    % ���݂̐����
    Cnow = fun(x);
    
    % �{�[�h���}�̃v���b�g
    figure(fig);                      % ���ڂ���figure��ύX
    bodeplot(C_ideal, Cnow, popt);  % �{�[�h���}

    %�e�L�X�g�f�[�^�̍쐬�A�v���b�g
    str = ['iter = ' num2str(optimValues.iteration) newline];
    str = [str 'Kp = ' num2str(x(1), 3) newline]; % P�Q�C��
    str = [str 'Ki = ' num2str(x(2), 3) newline]; % I�Q�C��
    str = [str 'Kd = ' num2str(x(3), 3)];         % D�Q�C��
    text(0.02, 0.0, str, 'FontSize', 14);

    writeVideo(vidObj, getframe(gcf));
    drawnow
end
