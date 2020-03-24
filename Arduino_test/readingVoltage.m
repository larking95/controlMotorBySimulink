
clearvars;
close all;

% �{�[�h���擾
myboard = arduino('COM6', 'Uno');

% �T���v�����O����
Ts = 0.1;

% �V�~�����[�V��������
Tend = 10;

% �f�[�^��
N = Tend/Ts;

% ���͓d��
u = nan([N, 1]);

c = 1;
disp('start');
tic
% �J��Ԃ�����
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
