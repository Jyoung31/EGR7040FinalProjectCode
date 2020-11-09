function param_study_test2D()
%xi~[0 1]
%x1,x2,x3
gridn=10;
paramx=[1,2];
xs=linspace(0,1,gridn);
[xs1,xs2]=meshgrid(xs,xs);
shape=size(xs1);
xs1=xs1(:);
xs2=xs2(:);
sn=length(xs1);
xdata(:,paramx)=[xs1,xs2];

ydata=test_function(xdata)

xs1=reshape(xs1,shape);
xs2=reshape(xs2,shape);
ydata=reshape(ydata,shape);
figure,
surf(xs1,xs2,ydata)
title(sprintf(' --- parameter %d & %d study --- ',paramx(1),paramx(2)))

function ydata=test_function(xdata);

[sn,nd]=size(xdata);
ydata=[];
for i=1:sn
    xi=xdata(i,:);
    yi=func_eval(xi);
    ydata=[ydata;yi];
end

function yi=func_eval(xi);
x1=xi(1);
x2=xi(2);
%x3=xi(3);
%obj
c=[0 1 1 5 1];
yi=c(1)+c(2)*x1^3+c(3)*exp(x2)-c(4)*x2^2-c(5)*x1*x2;