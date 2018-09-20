% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                             4.5 Speech Recognition                      %
%     Script to change sampling frequency from 44100 Hz to 16000 Hz       %
%                         Original version - March 2018                   %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

close all; clear all; clc;

fs = 16000;
load('sound_x.mat');
audiowrite('new_x.wav',sound_x,fs);
clear