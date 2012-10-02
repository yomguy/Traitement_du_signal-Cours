# -*- coding: utf-8 -*-
from scipy.signal import lfilter
from numpy import *
import matplotlib.pyplot as plt

fe = 44100

x = ones(64)

x[:16] = 0.0
x[48:] = 0.0


fc = 5000
b = 1/(1+fe/(2*pi*fc))
a = b-1.0
a = array([ 1.0, a ])

# low pass
b = array([ b ])

y = lfilter(b, a, x)

plt.plot(y, marker='o', color='r')
plt.plot(x, marker='x')
plt.show()

