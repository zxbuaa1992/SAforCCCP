clear all;
close all;
clc;
%% ����ȫ�ֱ���
t0 = cputime;
global width;
global rmin;
width=4.05;
rmin=6;
%% �������
n=8;%�켣����
T=100*n;%��ʼ�¶�
L=100;%����Ʒ�������
K=0.99;%˥������ �ڼ������������Ӧ��ָ���趨�Ĳ������
num=1;%ͳ�Ƶ�������
route=randperm(n);%��ʼ���켣˳��
length(num)=calculate(route);%�����һ�����Ӧ��·������
%%%%%%%%%%%%%%%�Ż�����%%%%%%%%%%%%%%%%%
while T>0.001
    for i=1:L
         %%%%%%%��ε����Ŷ����¶Ƚ���֮��������%%%%%%%%%
        len1=calculate(route);%������һ���켣˳���·������
        %%%%%%����������������й켣�û�%%%%%%%%%%%
        p1=floor(1+n*rand());
        p2=floor(1+n*rand());
        while p1==p2
              p1=floor(1+n*rand());
              p2=floor(1+n*rand());  
        end
        temp_route=route;
        temp=temp_route(p1);
        temp_route(p1)=temp_route(p2);
        temp_route(p2)=temp;
        %�����µĹ켣˳���·������
        len2=calculate(temp_route);
        delta=len2-len1;
        if delta<0
            route=temp_route;
        else
            if exp(-delta/T)>rand()
                route=temp_route;
            end
        end
    end
    num=num+1;
    length(num)=calculate(route);
    T=T*K;
end
shortestDis = length(end)
t1=cputime-t0
figure
plot(length)
xlabel("��������")
ylabel("Ŀ�꺯��ֵ")
title("��Ӧ�Ƚ�������")
% route=[1 8 2 9 3 10 4 11 5 12 6 13 7 14];
% length=calculate(route);
% route=[5	7	4	13	9	11	10	8	12	2	14	1	6	3];
% length=calculate(route)
%route=[1 5 2 6 3 7 4 8];
% length=calculate(route)
%  route=[1	11	2	12	3	13	4	14	5	15	6	16	7	17 8 18 9 19 10 20];
% length=calculate(route)
%route=[1 8	2	7	3	5	4  6];
%route=[1 9 2 10 3 11 4 12 5 13 6 14 7 15 8 16];
%route=[1 6 2  7 3 8 4 9 5 10];
%length=calculate(route)
%%%%%%%%Ŀ�꺯��%%%%%%%%  
%% ����������λ�ó���Ȼ��ص���ʼ��
%% ����·�����ܳ��� Len
function Len=calculate(route)
global width;
global rmin;
Len=0;
count =length(route);%�������ʼindex��1
for i=1:count-1
    startIndex=route(i);
    endIndex=route(i+1);
%     if abs(endIndex-startIndex)<2
%         Len=Len+1000;
%     else
        m=floor(abs(endIndex-startIndex)/2);%ȡ��
        n=abs(endIndex-startIndex)-m*2;%ȡ��
        %%dis=0;
        if n==0
            dis=m*width;%% ֱ�ӵ�����ҵ�еĿ�ȵ�m��
        else
            if endIndex>startIndex
                max=endIndex;
            else
                max=startIndex;
            end
            if mod(max,2)==0
                dis=m*width+1;
            else
                dis=m*width+3;
            end    
        end
        %% ����dis ��rmin�Ĵ�С����len
        if dis>=2*rmin
            Len=Len+dis+(pi-2)*rmin;
        else
%             templeng=(pi+4*acos((dis+2*rmin)/(4*rmin)))*rmin;
            Len=Len+(pi+4*acos((dis+2*rmin)/(4*rmin)))*rmin;
        end
%     end
end
%%����ĩβ����ʼ��ľ���
startIndex=route(count);
endIndex=route(1);
% if abs(endIndex-startIndex)<2
%     Len=Len+1000;
% else
    m=floor(abs(endIndex-startIndex)/2);%ȡ��
    n=abs(endIndex-startIndex)-m*2;%ȡ��
    %%dis=0;
    if n==0
        dis=m*width;%% ֱ�ӵ�����ҵ�еĿ�ȵ�m��
    else
        if endIndex>startIndex
            max=endIndex;
        else
            max=startIndex;
        end
        if mod(max,2)==0
            dis=m*width+1.05;
        else
            dis=m*width+3;
        end    
    end
    %% ����dis ��rmin�Ĵ�С����len
    if dis>=2*rmin
        Len=Len+dis+(pi-2)*rmin;
    else
        Len=Len+(pi+4*acos((dis+2*rmin)/(4*rmin)))*rmin;
    end
% end
end
