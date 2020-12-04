function [g,dg,h,dh]=projectgxfull(x)

x1=x(1);
x2=x(2);
x3=x(3);
x4=x(4);
x5=x(5);

g1=.01-x1;
g2=x1-.025;
g3=.065-x2;
g4=x2-.095;
g5=.115-x3;
g6=x3-.15;
g7=.1-x4;
g8=x4-.3;
g9=101325-x5;
g10=x5-202650;


g=[g1 g2 g3 g4 g5 g6 g7 g8 g9 g10];
dgdx1=[-1 1 0 0 0 0 0 0 0 0];
dgdx2=[0 0 -1 1 0 0 0 0 0 0];
dgdx3=[0 0 0 0 -1 1 0 0 0 0];
dgdx4=[0 0 0 0 0 0 -1 1 0 0];
dgdx5=[0 0 0 0 0 0 0 0 -1 1];
dg=[dgdx1;dgdx2;dgdx3;dgdx4;dgdx5];
h=[];
dh=[];