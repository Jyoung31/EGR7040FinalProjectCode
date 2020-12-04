function SQP_QN_reduced_problem()
%close all
format long
%fx_fun='hmw7fx'
%gx_fun='hmw7gx'
fx_fun='projectfxreduced'
gx_fun='projectgxreduced'
%fx_fun='projectfxfull'
%gx_fun='projectgxfull'

%% graphing section
figure, hold on

[x1,x2]=meshgrid(-50:2:100,-50:2:100);
%[x3,x4]=meshgrid(-50:2:100,-50:2:100);
%x5=meshgrid(-50:2:100,-50:2:100);
%[x1,x2]=meshgrid(-4:0.1:4.5,-4:0.1:4.5);
[x1,x2]=meshgrid(linspace(.005,.03,100),linspace(.05,.35,100));
for i=1:length(x1(:,1))
    for j=1:length(x2(:,1))
        xi=[x1(i,j) x2(i,j)];% x3(i,j) x4(i,j) x5(i,j)];
        [fk,dfk]=feval(fx_fun,xi);
        [gk,dgk]=feval(gx_fun,xi);
        f(i,j)=fk;
        g1(i,j)=gk(1);
        g2(i,j)=gk(2);
        g3(i,j)=gk(3);
        g4(i,j)=gk(4);
    end
end

[const1,h]=contour(x1,x2,f,100);
cv1=[0.0001 0.0015]*max(max(g1));
[const1,h]=contour(x1,x2,g1,cv1,'k','LineWidth',2);
cv1=[0.0001 0.0015]*max(max(g2));
[const1,h]=contour(x1,x2,g2,cv1,'k','LineWidth',2);
cv1=[0.0001 0.0015]*max(max(g3));
[const1,h]=contour(x1,x2,g3,cv1,'k','LineWidth',2);
cv1=[0.0001 0.0015]*max(max(g4));
[const1,h]=contour(x1,x2,g4,cv1,'k','LineWidth',2);
xlabel('x1')
ylabel('x4')

%% Initialization
DVn = 2;
%xk=[-1 3.5]';
xk=[.015, .2]';%xk for reduced problem study project%
%xk=[.015, .75,.120,.15,150000]';%xk for full problem
Rk=2;
tol=0.0001;
k=0;
Hk=eye(DVn);
iter_x_history=[];
iter_y_history=[];
iter_g_history=[];

%% Design Iteration

while 1 
    
    [fk,dfk]=feval(fx_fun,xk);
    [gk,dgk,hk,dhk]=feval(gx_fun,xk);
    
    iter_x_history=[iter_x_history;xk];
    iter_y_history=[iter_y_history;fk];
    iter_g_history=[iter_g_history;gk];
    scatter3(xk(1),xk(2),fk,50,'MarkerEdgeColor','b','MarkerFaceColor','b')
    
    %% BFGS Updating Section
    if k>1
        sk=ak0*dk0;
        zk=Hk*sk;
        yk=(dfk+dgk*usk0)-(dfk0+dgk0*usk0);
        zail=sk'*yk;
        zai2=sk'*zk;
        
        if zail>=0.2*zai2
            theta=1;
        else
            theta=0.8*zai2/(zai2-zai1);
        end
        
        wk=theta*yk+(1-theta)*zk;
        zai3=sk'*wk;
        
        Dk=(1/zai3)*wk*wk';
        Ek=(1/zai2)*zk*zk';
        Hk=Hk+Dk-Ek;
    end
    %% Quadratic Programming Subproblem
    ci=dfk;
    A=dgk';
    b=-gk;
    Aeq=dhk';
    beq=-hk;
    [dxp,fval,exitflag,output,lambda]=quadprog(Hk,ci,A,b,Aeq,beq);
    dk=dxp;
    %% Line Search Section
    usk=lambda.ineqlin;
    vsk=lambda.eqlin;
    rk=sum(usk)+sum(abs(vsk));
    Vk=max([0,gk]);
    if Vk>0
        Rk=2.0;
    end
    
    Rk=max(Rk,rk);
    delta=0.01;
    [ak,fak,x_history,y_history]=SQP_ch12_golden_section_with_x_mod01(fx_fun,gx_fun,xk,dk,Rk,delta);
    xlp=xk+ak*dk;
    scatter3(xlp(1),xlp(2),fval,50,'MarkerEdgeColor','r','MarkerFaceColor','r')
    
    if norm(dk)<tol
        break;
    end
    
    ak0=ak; dk0=dk; xk0=xk;
    usk0=usk; vsk0=vsk;
    fk0=fk; dfk0=dfk; gk0=gk; dgk0=dgk; hk0=hk; dhk0=dhk;
    xk=xlp;
    k=k+1;
end

xk
    