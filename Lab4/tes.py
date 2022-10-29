import math
import numpy as np
from pyphysim.modulators.fundamental import BPSK, QAM, QPSK, Modulator
 
num_symbols = int(1e3)

# We need the data to be in the interval [0, M), where M is the
# number of symbols in the constellation 

qam = QAM(16)
print((qam.modulate(1)))