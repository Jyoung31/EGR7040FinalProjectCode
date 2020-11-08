##Jack Young EGR7040 Fall 2020

def fun(x):
    from sympy import symbols
    x1,x2,x3=symbols('x_1,x_2,x_3')
    y=(x[0]+x[1])**2+(x[1]+x[2])**2;
    return y


from matplotlib import *


def line_search_equal_interval(fun, xk, dk, LB, UB):
    from numpy import arange
    from numpy import append
    from matplotlib.pyplot import subplots
    from matplotlib.pyplot import plot
    from matplotlib.pyplot import show
    from matplotlib.pyplot import xlabel
    from matplotlib.pyplot import ylabel
    from matplotlib.pyplot import legend
    from matplotlib.pyplot import title
    from matplotlib.pyplot import tick_params
    from matplotlib.pyplot import grid
    from matplotlib.pyplot import ylim
    from matplotlib.pyplot import xlim
    from matplotlib.pyplot import xticks
    from matplotlib.pyplot import yticks

    fig, ax = subplots()
    xmin = LB
    xmax = UB
    delta = .01
    r = .2
    epsilon_tolerance = .00001
    aopt_found = 0
    iter = 1
    as1 = arange(LB, UB, delta / 10)
    sn = len(as1)
    sn = arange(0, sn, 1)
    ys = []

    for i in sn:
        yi = func_a(fun, dk, xk, as1[i])
        ys = append(ys, yi)
    CS = ax.plot(as1, ys)

    xlabel('x', fontsize=24, y=1.02)
    ylabel('f(x)', fontsize=24)
    title('Equal Interval Search Method Optimization technique', fontsize=24, y=1.02)
    tick_params(labelsize=24, pad=6)
    grid()

    while not (aopt_found == 1):
        (new_LB, new_UB) = bound_search(fun, xk, dk, LB, UB, delta)
        if abs(new_UB - new_LB) < epsilon_tolerance:
            aopt_found = 1;
        delta = r * delta
        LB = new_LB
        UB = new_UB
        plot(LB, 0)
        plot(UB, 0)
        iter = iter + 1
        a_opt = (UB + LB) / 2
        print(a_opt)
        ax.plot(UB, min(ys), 'b|', LB, min(ys), 'b|', markersize=20)
    ax.plot(a_opt, min(ys), 'ro', label='optimal design point')

    # Plot formatting
    legend(loc=0, fontsize=24)
    fig.set_size_inches(18.5, 10.5)
    xmax = max(as1)
    xtickstepsize = (xmax) / 10
    # xticks(arange(xmin,xmax,step=xtickstepsize),rotation=30)
    ymin = min(ys)
    ymax = max(ys)
    ytickstepsize = ymax / 10
    yticks(arange(ymin, ymax, ytickstepsize))
    xlim(xmin, xmax)
    ylim(ymin - ytickstepsize, ymax)
    show()
    # end plot formatting

    iter = iter

    return a_opt, iter

def bound_search(fun,xk,dk,LB,UB,delta):
    from numpy import arange
    from numpy import asarray
    as1= arange(LB,UB,delta)
    q=1
    aq=as1[q]
    xq=xk+asarray(dk)*aq
    yq1=func_a(fun,dk,xk,aq)
    while 1:
        q=q+1;
        aq=as1[q]
        yq2 = func_a(fun,dk,xk,aq)
        if yq1<yq2:
            new_LB=as1[q-2]
            new_UB=as1[q]
            break
        yq1=yq2
    return (new_LB,new_UB)

def func_a(fun,dk,xk,ai):
    from numpy import asarray
    xi = xk + ai*asarray(dk)
    fi= fun(xi)
    return fi

#line_search_equal_interval(function,xk,dk,LB,UB)

#uncomment line below to test function without calling externally
#line_search_equal_interval(fun,[1,1,1],[-4,-8,-4],0,1)

