% VRFT�̐݌v�X�N���v�g
% ���[�^�̑��x����n�ɑ΂��Đ݌v����B

% Copyright (c) 2019 larking95(https://qiita.com/larking95)
% Released under the MIT Licence 
% https://opensource.org/licenses/mit-license.php

%% ������
clearvars;
close all;

%% �݌v�d�l�̌���

% �Q�ƃ��f�� M
tau = 0.2;
M = c2d(1/(tau*s + 1), Ts); % �[�����z�[���h�ŗ��U�������ꎟ�x��n

% �d�݊֐�
gW = 100;
W = c2d(gW/(s + gW), Ts);   % �[�����z�[���h�ŗ��U�������ꎟ�x��n

%�����\�� beta
beta = minreal([1; Ts/(1 - z^-1); (1 - z^-1)/Ts]); % PID�����

%% ���o�̓f�[�^�̎擾
switch 1
    case 1  % �擾�ς݂̃f�[�^����݌v����
        load('resultIdent\20200320_2019');
        P = Gtf_d;  % ����Ώۃ��f��
        
    case 2  % �V���Ƀf�[�^���擾���Đ݌v����
        if ~exist('u', 'var')   % �f�[�^���Ȃ����C�������������s
            modelName = 'motorVelocityIdentify';    % ���s���郂�f����
            assert(exist(modelName, 'file'));       % ���f���̑��݊m�F
            load_system(modelName);                 % ���f���̃��[�h
            set_param(modelName, 'SimulationCommand', 'start'); % ���s
            while ~strcmp(get_param(modelName, 'SimulationStatus'), 'stopped')
                pause(1.0); % �����I���܂ő҂�
            end
        end
        P = load('resultIdent/20200320_2019', 'Gtf_d');  % ����Ώۃ��f��
end

u0 = u.signals.values;  % ���̓f�[�^
y0 = y.signals.values;  % �o�̓f�[�^

phi_u = 1;              % ���͂̃p���[�X�y�N�g��

%% VRFT�ɂ��݌v
% �v���t�B���^ L
L = minreal(M*(1 - M)/phi_u);

% �t�B���^�ɒʂ������͐M�� ul
ul = lsim(L, u0);

% �^���덷�M�� el = 
el = lsim(L*(M^(-1) - 1), y0);

%�p�����[�^�O�̐����o�� phi
phi = lsim(beta, el);

%�œK�ȃp�����[�^ rho
rho = phi\ul;               % �s��`���ōŏ����@������(mldivide)

%�݌v��������� C
C = minreal(rho.' * beta);  % ���������߂�

%�]���֐� Jmr
Jmr = mean(ul - phi * rho); % �s��`���ŕ]���֐����m�F

%% ���\�̊m�F
% ���������������V�X�e���S�� G
G = minreal(feedback(P*C, 1));

% �X�e�b�v����
fig1 = figure('name', 'Step plot');
stepplot(G, M);

%�{�[�h���}�\��
fig2 = figure('name', 'Bode plot of controller');
bodeplot(G, M, {1,100});

figs = [fig1, fig2];

%% �f�[�^�̕ۑ�
isAppropriateInput = false;
while isAppropriateInput == false
    validStrings = {'y', 'n'};
    str = input('Do you want to save the result ?(y/n): ', 's');
    if strcmp(str, validStrings(1)) == true
        if ~exist('resultVRFT', 'dir')
            mkdir('resultVRFT');   % �t�H���_���Ȃ���΍쐬����
        end
        saveName = ['./resultVRFT/',...
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
