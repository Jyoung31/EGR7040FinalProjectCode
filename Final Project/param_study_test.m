function param_study_test()
%xi~[0 1]
%x1,x2,x3


sn=10;
paramx=3;
xdata=ones(sn,3)*.5;
xs=linspace(0,1,sn);
xdata(:,paramx)=xs;

ydata=test_function(xdata)

figure,
plot(xs,ydata)
title(sprintf(' --- parameter %d study --- '    ,paramx))
%axis([0 1 0 5])

function ydata=test_function(xdata)

[sn,nd]= size(xdata);
ydata=[];

for i=1:sn
    xi=xdata(i,:);
    yi=func_eval(xi);
    ydata=[ydata;yi];
end

function yi=func_eval(xi);
%x1=xi(1);
%x2=xi(2);
%x3=xi(3);
%obj
c=[0 1 1 5 1];
yi=c(1)+c(2)*xi(1)^3+c(3)*exp(xi(2)*xi(3))-c(4)*xi(2)^2-c(5)*xi(1)*xi(2);