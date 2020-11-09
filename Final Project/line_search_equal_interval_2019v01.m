function [a_opt]=line_search_equal_interval_2019v01(fun,xk,dk)
close all
%fun='ex10_26_fx';
%xk=[1 1 1]'; %inital alpha
%dk=[-4 -8 -4]'; %direction vector alpha
% % %
LB=0.1;
UB=0.5;
delta=0.01;
r=0.2;
epsilon_tolerance=0.00001;
aopt_found=0;
iter=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% function plot
as=[LB:delta/10:UB]
sn=length(as);
ys=[];
ys
for i=1:sn
[yi]=func_a(fun,dk,xk,as(i));
ys=[ys;yi];
end
figure; hold on;
plot(as,ys);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Equal-Interval
while ~aopt_found
[new_LB, new_UB]=bound_search(fun, xk, dk, LB, UB, delta);
if abs(new_UB-new_LB) < epsilon_tolerance
aopt_found=1;
end
delta=r*delta;
LB=new_LB
UB=new_UB;
iter=iter+1;
end
iter=iter
a_opt=(UB+LB)/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% New bound search
function [new_LB, new_UB]=bound_search(fun, xk, dk, LB, UB, delta)
as=[LB:delta:UB];
q=1;
aq=as(q);
xq=xk+dk*aq;
[yq1]=func_a(fun,dk,xk,aq);
while 1
q=q+1;
aq=as(q);
[yq2]=func_a(fun,dk,xk,aq);
if yq1<yq2
new_LB=as(q-2);
new_UB=as(q);
return
end
yq1=yq2;

end
function [fi]=func_a(fun,dk,xk,ai)
xi=xk+ai*dk;
[fi]=feval(fun,xi);