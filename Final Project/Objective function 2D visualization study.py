from sympy import symbols
import math
import numpy as np
import matplotlib.pyplot as plt
from IPython.display import Image



Pi,po,a,g,A,t,W,ro=symbols('P_i,P_atm,a,g,A,t,W,r_o')
a = g*(((Pi-po)*A)/W-1)


r=symbols('r')
A1 = math.pi*r**2
a = a.subs(A,A1)




ri,h,V,rho,w1=symbols('r_i, h,V,rho,w1')
V = math.pi*(ro**2-ri**2)*h+(4/3)*math.pi*(ro**3-ri**3)

w1 = rho*V*g
w1


a = a.subs(W,w1)




x1,x2,x3,x4,x5=symbols('x_1,x_2,x_3,x_4,x_5')
a = a.subs(r,x1)
a = a.subs(ri,x2)
a = a.subs(ro,x3)
a = a.subs(h,x4)
a = a.subs(Pi,x5)




g1,g2,g3,Pcr=symbols('g_1,g_2,g_3,Pcr')

g1 = Pcr-Pi <= 0
g2 = ri-ro-.002 <= 0
g3 = ro-.200 <= 0


g1 = g1.subs(Pi,x5)
g2 = g2.subs(ri,x2)
g2 = g2.subs(ro,x3)
g3 = g3.subs(ro,x3)

a = a.subs(x1,x3)#104 cm radius
a = a.subs(x2,.094)#inner radius of rocket
#a = a.subs(x3,.104)#outer radius of the rocket
#a = a.subs(x4,.109)#109 mm height
a = a.subs(x5,101325+861845)#125 psi converted to pascals internal pressure, this value was chosen within an assumed range
a = a.subs(po,101325)#101325 pascal atmopsheric pressure
a = a.subs(rho,1.24*.2)#1.24 Kg/m^3 with 20% infill density
a = a.subs(g,-9.81)#m/s^2 gravitational constant


a=a/9.81



delta = 0.003
x3max=.1
x3min=.095
x4max=.4
x4min=.1
x3 = np.arange(x3min-delta,x3max+delta, delta)
x4 = np.arange(x4min-delta,x4max+delta, delta)
X3,X4 = np.meshgrid(x3,x4)
a = a.subs(x3,X3)
a = a.subs(x4,X4)
fx = 1+((354248.8737*math.pi*X3**2)/(math.pi*X4*(X3**2-.008836)+1.3333*math.pi*(X3**3-.000830584)))


fig,ax=plt.subplots()
CS=ax.contourf(X3,X4,fx,1000,cmap='Spectral')
plt.xlim(x3min,x3max)
plt.ylim(x4min,x4max)
plt.xlabel('x3-outer radius')
plt.ylabel('x4-height of midsection')
plt.colorbar(CS)
fig.set_size_inches(18.5, 10.5)
x3 = np.arange(-1,2,delta)
x4 = np.arange(-1,2,delta)
x2 = .094
g4 = x3*0+x2+.002
g5 = x4*0+.37



g1p=plt.plot(g4*.9998,x3,color='green',linewidth=6,linestyle='--')
g2p=plt.plot(g4,x3,color='green',label='g2:x2−x3−0.002≤0')
g3p=plt.plot(x4,g5*1.005,color='blue',linewidth=6,linestyle='--')
g4p=plt.plot(x4,g5,color='blue',label='g4:x4−0.37≤0')
plt.title('height of midsection and outer radius 2D parameter study')

legend = plt.legend(loc=0)