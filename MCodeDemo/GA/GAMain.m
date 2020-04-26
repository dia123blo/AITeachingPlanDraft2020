%% *�Ŵ��㷨������*
function  GAMain()
    clc,clear,tic
    % ������ʼ��
    maxgen=100; %������������������������ʼԤ��ֵѡΪ100
    popsize=200; %��Ⱥ��ģ����ʼԤ��ֵѡΪ100
    pcross=0.9; %�������ѡ��0��1֮�䣬һ��ȡ0.9
    pmutation=0.01; %�������ѡ��0��1֮�䣬һ��ȡ0.01
    individuals=struct('fitness',zeros(1,popsize),'chrom',[]);
    %��Ⱥ����Ⱥ��popsize��Ⱦɫ��(chrom)��ÿ��Ⱦɫ�����Ӧ��(fitness)���
    avgfitness=[];
    %��¼ÿһ����Ⱥ��ƽ����Ӧ�ȣ����ȸ���һ��������
    bestfitness=[];
    %��¼ÿһ����Ⱥ�������Ӧ�ȣ����ȸ���һ��������
    bestchrom=[];
    %��¼��Ӧ����õ�Ⱦɫ�壬���ȸ���һ��������
    %��ʼ����Ⱥ
    %%���������
    dataa
    for i=1:popsize
        %�������һ����Ⱥ
        individuals.chrom(i,:)=4000*rand(1,12);
        %��12��0~4000�������������Ⱥ�е�һ��Ⱦɫ�壬����K=4����������
        x=individuals.chrom(i,:);
        %����ÿ��Ⱦɫ�����Ӧ��
        individuals.fitness(i)=fitness(x,dataf);
    end
    %%����õ�Ⱦɫ��
    [bestfitness bestindex]=max(individuals.fitness);
    %�ҳ���Ӧ������Ⱦɫ�壬����¼����Ӧ�ȵ�ֵ(bestfitness)��Ⱦɫ�����ڵ�λ��(bestindex)
    bestchrom=individuals.chrom(bestindex,:);
    %����õ�Ⱦɫ�帳������bestchrom
    avgfitness=sum(individuals.fitness)/popsize;
    %����Ⱥ����Ⱦɫ���ƽ����Ӧ��

    trace=[avgfitness bestfitness];
    %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��

    for i=1:maxgen
        sprintf('%d',i)
        %�����������
        individuals=Select(individuals,popsize);
        avgfitness=sum(individuals.fitness)/popsize;
        %����Ⱥ����ѡ����������������Ⱥ��ƽ����Ӧ��
        individuals.chrom=Cross(pcross,individuals.chrom,popsize);
        %����Ⱥ�е�Ⱦɫ����н������
        individuals.chrom=Mutation(pmutation,individuals.chrom,popsize);
        %����Ⱥ�е�Ⱦɫ����б������
            for j=1:popsize
                x=individuals.chrom(j,:);%����
                [individuals.fitness(j)]=fitness(x,dataf);
            end
        %���������Ⱥ��ÿ��Ⱦɫ�����Ӧ��
        [newbestfitness,newbestindex]=max(individuals.fitness);
        [worestfitness,worestindex]=min(individuals.fitness);
        %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
        if bestfitness<newbestfitness
            bestfitness=newbestfitness;
            bestchrom=individuals.chrom(newbestindex,:);
        end
        %������һ�ν�������õ�Ⱦɫ��
        individuals.chrom(worestindex,:)=bestchrom;
        individuals.fitness(worestindex)=bestfitness;
        %��̭��Ӧ�����ĸ���
        avgfitness=sum(individuals.fitness)/popsize;
        trace=[trace;avgfitness bestfitness];
        %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
    end
    figure(1)
    plot(trace(:,1),'-*r');
    title('��Ӧ�Ⱥ�������(100*100)')
    hold on
    plot(trace(:,2),'-ob');
    legend('ƽ����Ӧ������','�����Ӧ������','location','southeast')
    %%������Ӧ�ȱ仯����
    clc
    %�����������
    kernal=[bestchrom(1:3);bestchrom(4:6);bestchrom(7:9);bestchrom(10:12)];
    %�������Ѿ�������
    [n,m]=size(data1);
    %������������ݵ�����������
    index=cell(4,1);
    %��������������
    dist=0;
    %��������׼����
    for i=1:n
        dis(1)=norm(kernal(1,:)-data1(i,:));
        dis(2)=norm(kernal(2,:)-data1(i,:));
        dis(3)=norm(kernal(3,:)-data1(i,:));
        dis(4)=norm(kernal(4,:)-data1(i,:));
        %����������������е�һ�㵽�����������ĵľ���
        [value,index1]=min(dis);
        %�ҳ���̾������������ĵ�����
        cid(i)=index1;
        %������¼���ݱ����ֵ������
        index{index1,1}=[index{index1,1} i];
        dist=dist+value;
        %����׼����
    end
    % %��ͼ
    hold off
    figure(2)
    plot3(bestchrom(1),bestchrom(2),bestchrom(3),'ro');
    title('result100*100') 
    hold on
    %������������
    colstr={'bo', 'go','ko','k*'};
    for ii=2:4
        index1=index{ii,1};
        for i=1:length(index1)
            plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'ro')
            hold on
        end
        plot3(bestchrom(2*(ii-1)+1),bestchrom(2*(ii-1)+2),bestchrom(2*(ii-1)+3),colstr{ii});
        hold on
    end   
    toc
    pause(10)
    close all
 end
%%
%% *���������Ӧ��ֵ
function fit=fitness(x,dataf)
    %x    input   ����
    %fit  output  ��Ӧ��ֵ
     
    kernel=[x(1:3);x(4:6);x(7:9);x(10:12)];
    fit1=0;
    [n,m]=size(dataf);
    for i=1:n
    
        dist1=norm(dataf(i,1:3)-kernel(1,:)); 
         dist2=norm(dataf(i,1:3)-kernel(2,:));  
          dist3=norm(dataf(i,1:3)-kernel(3,:));  
           dist4=norm(dataf(i,1:3)-kernel(4,:));  
    
        a=[dist1 dist2 dist3 dist4];
        mindist=min(a);
        fit1=mindist+fit1;
    end
    fit=1/fit1;
end

%%
%% *ѡ�����*
function ret=Select(individuals,popsize)
% ��ÿһ����Ⱥ�е�Ⱦɫ�����ѡ���Խ��к���Ľ���ͱ���
% individuals input  : ��Ⱥ��Ϣ
% popsize     input  : ��Ⱥ��ģ
% ret         output : ����ѡ������Ⱥ



sumfitness=sum(individuals.fitness);
sumf=(individuals.fitness)./sumfitness;
index=[];

for i=1:popsize   %תpopsize������
    pick=rand;
    while pick==0    
        pick=rand;        
    end
    for i=1:popsize    
        pick=pick-sumf(i);        
        if pick<0        
            index=[index i];            
            break;  
        end
    end
end
individuals.chrom=individuals.chrom(index,:);
individuals.fitness=individuals.fitness(index);
ret=individuals;
end

%%
%% *�������*
function ret=Mutation(pmutation,chrom,popsize)
    % �������
    % pcorss                input  : �������
    % lenchrom              input  : Ⱦɫ�峤��
    % chrom                 input  : Ⱦɫ��Ⱥ
    % popsize               input  : ��Ⱥ��ģ
    % bound                 input  : ÿ��������Ͻ���½�
    % ret                   output : ������Ⱦɫ��

    for i=1:popsize

        % ������ʾ�������ѭ���Ƿ���б���
        pick=rand;
        if pick>pmutation
            continue;
        end

        pick=rand;
        while pick==0
            pick=rand;
        end
        index=ceil(pick*popsize);    

        % ����λ��
        pick=rand;
        while pick==0
            pick=rand;
        end
        pos=ceil(pick*3); 

        chrom(index,pos)=rand*4000;    
    end
    ret=chrom;
end

%%
%% *�������*
function ret=Cross(pcross,chrom,popsize)
    %�������
    % pcorss                input  : �������
    % lenchrom              input  : Ⱦɫ��ĳ���
    % chrom     input  : Ⱦɫ��Ⱥ
    % popsize               input  : ��Ⱥ��ģ
    % ret                   output : ������Ⱦɫ��
    for i=1:popsize

        % ������ʾ����Ƿ���н���
        pick=rand;
        while pick==0
            pick=rand;
        end
        if pick>pcross
            continue;
        end

        % ���ѡ�񽻲����
        index=ceil(rand(1,2).*popsize);
        while (index(1)==index(2)) | index(1)*index(2)==0
            index=ceil(rand(1,2).*popsize);
        end

        % ���ѡ�񽻲�λ��
        pos=ceil(rand*3);
        while pos==0
            pos=ceil(rand*3);
        end

        temp=chrom(index(1),pos);
        chrom(index(1),pos)=chrom(index(2),pos);
        chrom(index(2),pos)=temp;
    end
    ret=chrom;
end
