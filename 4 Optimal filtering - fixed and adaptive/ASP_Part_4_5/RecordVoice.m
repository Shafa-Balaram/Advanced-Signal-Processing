% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                 Script to record the sounds e, a, s, t and x            %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

clear all; clc;
% Sampling frequency, fs
fs = 44100;

% Sample length 
N = 1000;

% duration of recording
time = fs/N;
recObj = audiorecorder(fs, 16, 2);
get(recObj)

% Record your voice for 5 seconds.
recObj = audiorecorder;
disp('Say the letter "x".')
recordblocking(recObj, 1);
disp('End of Recording.');

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording = getaudiodata(recObj);

% Plot the waveform.
plot(myRecording);
