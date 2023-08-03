clear all;
close all;
clc;
%% 定义全局变量
t0 = cputime;
global width;
global rmin;
width=4.05;
rmin=6;
%% 定义变量
n=8;%轨迹数量
T=100*n;%初始温度
L=100;%马尔科夫链长度
K=0.99;%衰减参数 在计算过程中论文应该指出设定的参数情况
num=1;%统计迭代次数
route=randperm(n);%初始化轨迹顺序
length(num)=calculate(route);%计算第一个解对应的路径长度
%%%%%%%%%%%%%%%优化过程%%%%%%%%%%%%%%%%%
while T>0.001
    for i=1:L
         %%%%%%%多次迭代扰动，温度降低之间多次试验%%%%%%%%%
        len1=calculate(route);%计算上一个轨迹顺序的路径长度
        %%%%%%产生随机两个数进行轨迹置换%%%%%%%%%%%
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
        %计算新的轨迹顺序的路径长度
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
xlabel("迭代次数")
ylabel("目标函数值")
title("适应度进化曲线")
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
%%%%%%%%目标函数%%%%%%%%  
%% 车辆从任意位置出发然后回到起始点
%% 计算路径的总长度 Len
function Len=calculate(route)
global width;
global rmin;
Len=0;
count =length(route);%数组的起始index是1
for i=1:count-1
    startIndex=route(i);
    endIndex=route(i+1);
%     if abs(endIndex-startIndex)<2
%         Len=Len+1000;
%     else
        m=floor(abs(endIndex-startIndex)/2);%取整
        n=abs(endIndex-startIndex)-m*2;%取余
        %%dis=0;
        if n==0
            dis=m*width;%% 直接等于作业行的宽度的m倍
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
        %% 根据dis 和rmin的大小计算len
        if dis>=2*rmin
            Len=Len+dis+(pi-2)*rmin;
        else
%             templeng=(pi+4*acos((dis+2*rmin)/(4*rmin)))*rmin;
            Len=Len+(pi+4*acos((dis+2*rmin)/(4*rmin)))*rmin;
        end
%     end
end
%%计算末尾到起始点的距离
startIndex=route(count);
endIndex=route(1);
% if abs(endIndex-startIndex)<2
%     Len=Len+1000;
% else
    m=floor(abs(endIndex-startIndex)/2);%取整
    n=abs(endIndex-startIndex)-m*2;%取余
    %%dis=0;
    if n==0
        dis=m*width;%% 直接等于作业行的宽度的m倍
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
    %% 根据dis 和rmin的大小计算len
    if dis>=2*rmin
        Len=Len+dis+(pi-2)*rmin;
    else
        Len=Len+(pi+4*acos((dis+2*rmin)/(4*rmin)))*rmin;
    end
% end
end
