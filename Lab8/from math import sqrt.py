 
import scipy
import scipy.linalg   # SciPy Linear Algebra Library

A = scipy.array([[1, -2], [4, 2]])  # From the Wikipedia Article on QR Decomposition
Q, R = scipy.linalg.qr(A)
print(Q)
print(R)