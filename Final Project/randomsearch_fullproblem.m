function randomsearch_fullproblem()
%func_obj='projectfxreduced'
%func_gx='projectgxreduced'
func_obj='projectfxfull'
func_gx='projectgxfull'
%func_obj='hmw7fx'
%func_gx='hmw7gx'

%% graphics
%close all
%figure, hold on
[x1,x2]=meshgrid(-50:2:100,-50:2:100);
[x3,x4]=meshgrid(-50:2:100,-50:2:100);
[x5,x6]=meshgrid(-50:2:100,-50:2:100);
for i=1:length(x1(:,1))
    for j=1:length(x2(:,1))
        xi=[x1(i,j) x2(i,j) x3(i,j) x4(i,j) x5(i,j)];
        [fk,dfk]=feval(func_obj,xi);
        [gk,dgk]=feval(func_gx,xi);
        f(i,j)=fk;
%         g1(i,j)=gk(1);
%         g2(i,j)=gk(2);
%         g3(i,j)=gk(3);
%         g4(i,j)=gk(4);
%         g5(i,j)=gk(5);
%         g6(i,j)=gk(6);
%         g7(i,j)=gk(7);
%         g8(i,j)=gk(8);
%         g9(i,j)=gk(9);
%         g10(i,j)=gk(10);
    end
end
% [const1,h]=contour(x1,x2,f,250);
% cv1=[0.001 0.0015]*max(max(g1));
% [const1,h]=contour(x1,x2,g1,cv1,'k','LineWidth',2);
% cv1=[0.001 0.0015]*max(max(g2));
% [const1,h]=contour(x1,x2,g2,cv1,'k','LineWidth',2);
% cv1=[0.001 0.0015]*max(max(g3));
% [const1,h]=contour(x1,x2,g3,cv1,'k','LineWidth',2);
% cv1=[0.001 0.0015]*max(max(g4));
% [const1,h]=contour(x1,x2,g4,cv1,'k','LineWidth',2);

lb=[0 0 0 0 0];
ub=[.025 .0950 .15 .3 2*101325];
SN=10000;
fopt=inf;
k1=0;
for i=1:5000
    xs=rand(SN,5);
    xs(:,1)=xs(:,1)*(ub(1)-lb(1))+lb(1);
    xs(:,2)=xs(:,2)*(ub(2)-lb(2))+lb(2);
    xs(:,3)=xs(:,3)*(ub(3)-lb(3))+lb(3);
    xs(:,4)=xs(:,4)*(ub(4)-lb(4))+lb(4);
    xs(:,5)=xs(:,5)*(ub(5)-lb(5))+lb(5);
    
    fs=[];
    gs=[];
    for k=1:SN
        xx = xs(k,:)';
        fi=feval(func_obj,xx);
        gi=feval(func_gx,xx);
        fs=[fs;fi];
        gs=[gs;max(gi)];
    end
    
    feasible=find(gs<=0);
    fs=fs(feasible);
    gs=gs(feasible);
    xs=xs(feasible,:);
    [fmin,minid]=min(fs);
    
    if fmin<fopt
        fopt=fmin;
        gopt=gs(minid);
        xopt=xs(minid,:);
    end
    %scatter(xs(:,1),xs(:,2),'b.')
    %scatter(xopt(1),xopt(2),'r.')
    k1=k1+1
end
%xlim([0,.05])
%ylim([.05,.35])
fopt
xopt