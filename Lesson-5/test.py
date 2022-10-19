import numpy as np
x=np.ones((8,8))
# print(x)
x[0:-1,1::-1] = 0
print(x)