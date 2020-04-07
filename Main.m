clear
clc
rng('default');%for reaptable-load mixed 0~3
load('97.mat');

[DataF1,DataF2,DataF3,DataF4,DataF5,DataF6,DataF7,DataF8,DataF9]=mixedData();% mix load 0~3


siz=2000;%2000 points are selected randomly
indx=randperm(120000,siz);
len=600;
classNum=10;

DataSet1=[
toR(X097_DE_time(indx,:),len);
toR(DataF1,len);
toR(DataF2,len);
toR(DataF3,len);
toR(DataF4,len);
toR(DataF5,len);
toR(DataF6,len);
toR(DataF7,len);
toR(DataF8,len);
toR(DataF9,len)];
%%%%%%
DataSet2=[
toG(X097_DE_time(indx,:),len);
toG(DataF1,len);
toG(DataF2,len);
toG(DataF3,len);
toG(DataF4,len);
toG(DataF5,len);
toG(DataF6,len);
toG(DataF7,len);
toG(DataF8,len);
toG(DataF9,len)];
%%%%%%%
DataSet3=[
toB(X097_DE_time(indx,:),len);
toB(DataF1,len);
toB(DataF2,len);
toB(DataF3,len);
toB(DataF4,len);
toB(DataF5,len);
toB(DataF6,len);
toB(DataF7,len);
toB(DataF8,len);
toB(DataF9,len)];
%%%%%

recommendDemen=floor(sqrt(sqrt(size(DataSet1,1)))*2.2)
%recommendDemen=32
%DataP=toPeak(DataSet,len,6);
%[inputs,PS]=mapminmax(DataSet');%归一化

%inputs=DataP';
inputs1=DataSet1';
inputs2=DataSet2';
inputs3=DataSet3';
% Create a Self-Organizing Map
dimension1 = recommendDemen;
dimension2 = recommendDemen;
net = selforgmap([dimension1 dimension2]);
net.trainParam.epochs=200;
% Train the Network
[SOMnet1,tr1] = train(net,inputs1);
[SOMnet2,tr2] = train(net,inputs2);
[SOMnet3,tr3] = train(net,inputs3);
%saved and loaded
%load('SOMnet');
outputs1 = SOMnet1(inputs1);
outputs2 = SOMnet2(inputs2);
outputs3 = SOMnet3(inputs3);

for i=1:size(inputs1,2)
    temp=inputs1(:,i)';
    temp1=SOMnet1.IW{1};
    temp2=temp1-temp;
    temp3=temp2.^2;
    rawMap1(i,:)=sum(temp3,2);
end
%%%
for i=1:size(inputs2,2)
    temp=inputs2(:,i)';
    temp1=SOMnet2.IW{1};
    temp2=temp1-temp;
    temp3=temp2.^2;
    rawMap2(i,:)=sum(temp3,2);
end
%%%
for i=1:size(inputs3,2)
    temp=inputs3(:,i)';
    temp1=SOMnet3.IW{1};
    temp2=temp1-temp;
    temp3=temp2.^2;
    rawMap3(i,:)=sum(temp3,2);
end



Map1=mapminmax(rawMap1, 0, 1);
Map2=mapminmax(rawMap2, 0, 1);
Map3=mapminmax(rawMap3, 0, 1);

Maps=cell(1,size(Map1,1));
% net = AlexNet;
% inputSize = net.Layers(1).InputSize;
inputSize=[32,32,3];%LeNet-5
cols=inputSize(1);
renum=floor(cols/dimension1);
restnum=cols-renum*dimension1;

for i=1:size(Map1,1)%图元扩展
    tempR=reshape(Map1(i,:),dimension1,dimension2);
    tempG=reshape(Map2(i,:),dimension1,dimension2);
    tempB=reshape(Map3(i,:),dimension1,dimension2);
    
    if restnum==0
        temp2R=repmat(tempR,renum,renum); 
        temp2G=repmat(tempG,renum,renum); 
        temp2B=repmat(tempB,renum,renum); 
    else
        temp21=repmat(tempR,renum,renum);         
        retc=repmat(tempR(:,1:restnum),renum,1); 
        retr=repmat(tempR(1:restnum,:),1,renum); 
        temp22=[temp21,retc];
        temp23=[retr,tempR(1:restnum,1:restnum)];
        temp2R=[temp22;temp23];
        
        temp21=repmat(tempG,renum,renum);         
        retc=repmat(tempG(:,1:restnum),renum,1); 
        retr=repmat(tempG(1:restnum,:),1,renum); 
        temp22=[temp21,retc];
        temp23=[retr,tempG(1:restnum,1:restnum)];
        temp2G=[temp22;temp23];
        
        temp21=repmat(tempB,renum,renum);         
        retc=repmat(tempB(:,1:restnum),renum,1); 
        retr=repmat(tempB(1:restnum,:),1,renum); 
        temp22=[temp21,retc];
        temp23=[retr,tempB(1:restnum,1:restnum)];
        temp2B=[temp22;temp23];
        
    end
    
    
    
    if (inputSize(3)>1)
        Maps{i}=cat(3,temp2R,temp2G,temp2B);
    else
        Maps{i}=temp2;
    end
end

filename='D:\Matlab codes\Case WR\Load 0-driven end bearing data-12Khz\Pics7\';%the address to save generated images, you can change it.

filenames_R{1}=[filename,'N'];
for i=1:classNum-1
    filenames_R{i+1}=[filename,'F',num2str(i)];
end
for i=1:length(filenames_R)
    rmdir(filenames_R{i},'s');
    mkdir(filenames_R{i});
end

%steps=floor(siz/len);
steps=size(DataSet1,1)/classNum;
for i=1:size(Maps,2)
    if(i<steps+1)
        file=[filename,'N\','N',num2str(i),'.png'];
        imwrite(Maps{i},file);
    elseif (i<steps*2+1)
        file=[filename,'F1\','F1',num2str(i),'.png'];
        imwrite(Maps{i},file);
    elseif (i<steps*3+1)
        file=[filename,'F2\','F2',num2str(i),'.png'];
        imwrite(Maps{i},file);
    elseif (i<steps*4+1)
        file=[filename,'F3\','F3',num2str(i),'.png'];
        imwrite(Maps{i},file);
    elseif (i<steps*5+1)
        file=[filename,'F4\','F4',num2str(i),'.png'];
        imwrite(Maps{i},file);
     elseif (i<steps*6+1)
        file=[filename,'F5\','F5',num2str(i),'.png'];
        imwrite(Maps{i},file);
     elseif (i<steps*7+1)
        file=[filename,'F6\','F6',num2str(i),'.png'];
        imwrite(Maps{i},file);
     elseif (i<steps*8+1)
        file=[filename,'F7\','F7',num2str(i),'.png'];
        imwrite(Maps{i},file);
    elseif (i<steps*9+1)
        file=[filename,'F8\','F8',num2str(i),'.png'];
        imwrite(Maps{i},file);
    else
        file=[filename,'F9\','F9',num2str(i),'.png'];
        imwrite(Maps{i},file);
    end
end
disp('It is done.')

%picfile='D:\Matlab codes\Case WR\Load 0-driven end bearing data-12Khz\Pics7';
picfile=filename;
imds = imageDatastore(picfile,'IncludeSubfolders',true,'LabelSource','foldernames');
figure;

perm=zeros(1,40);
for i=1:10
    perm((i-1)*4+1:4*i)=[randperm(steps,4)+steps*(i-1)];
end


for i = 1:40
    subplot(10,4,i);
    imshow(imds.Files{perm(i)});
end
deepLearning(picfile);