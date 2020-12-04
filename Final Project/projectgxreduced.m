function [g,dg,h,dh]=projectgxreduced(x)

x1=x(1);
x4=x(2);

g1=.01-x1;
g2=x1-.025;
g3=.1-x4;
g4=x4-.3;


g=[g1 g2 g3 g4];
dgdx1=[-1 1 0 0];
dgdx4=[0 0 -1 1];
dg=[dgdx1;dgdx4];
h=[];
dh=[];