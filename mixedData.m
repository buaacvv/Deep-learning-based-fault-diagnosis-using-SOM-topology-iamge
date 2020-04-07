function [DataF1,DataF2,DataF3,DataF4,DataF5,DataF6,DataF7,DataF8,DataF9] = mixedData()
%UNTITLED2 此处显示有关此函数的摘要
%   mix load0~3
rng('default');% for repeatable
indx=randperm(100000,500);

load('105.mat');
load('106.mat');
load('107.mat');
load('108.mat');

DataF1=[X105_DE_time(indx,:);X106_DE_time(indx,:);X107_DE_time(indx,:);X108_DE_time(indx,:)];

load('118.mat');
load('119.mat');
load('120.mat');
load('121.mat');

DataF2=[X118_DE_time(indx,:);X119_DE_time(indx,:);X120_DE_time(indx,:);X121_DE_time(indx,:)];

load('130.mat');
load('131.mat');
load('132.mat');
load('133.mat');

DataF3=[X130_DE_time(indx,:);X131_DE_time(indx,:);X132_DE_time(indx,:);X133_DE_time(indx,:)];

load('169.mat');
load('170.mat');
load('171.mat');
load('172.mat');

DataF4=[X169_DE_time(indx,:);X170_DE_time(indx,:);X171_DE_time(indx,:);X172_DE_time(indx,:)];

load('185.mat');
load('186.mat');
load('187.mat');
load('188.mat');

DataF5=[X185_DE_time(indx,:);X186_DE_time(indx,:);X187_DE_time(indx,:);X188_DE_time(indx,:)];

load('197.mat');
load('198.mat');
load('199.mat');
load('200.mat');

DataF6=[X197_DE_time(indx,:);X198_DE_time(indx,:);X199_DE_time(indx,:);X200_DE_time(indx,:)];

load('209.mat');
load('210.mat');
load('211.mat');
load('212.mat');

DataF7=[X209_DE_time(indx,:);X210_DE_time(indx,:);X211_DE_time(indx,:);X212_DE_time(indx,:)];

load('222.mat');
load('223.mat');
load('224.mat');
load('225.mat');

DataF8=[X222_DE_time(indx,:);X223_DE_time(indx,:);X224_DE_time(indx,:);X225_DE_time(indx,:)];

load('234.mat');
load('235.mat');
load('236.mat');
load('237.mat');

DataF9=[X234_DE_time(indx,:);X235_DE_time(indx,:);X236_DE_time(indx,:);X237_DE_time(indx,:)];
end

