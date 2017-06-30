# Defect Unaware Logic Mapping Algorithms Comparison

Defect-unaware methods determine the size of an n x n nano-crossbar in order to obtain a k x k defect-free sub-crossbar, so it is possible to know the required size of a crossbar in advance to implement a given logic function. Using the defect-free sub-crossbar, a straightforward mapping process can be applied. This problem is equivalent to finding a maximum balanced biclique in a bipartite graph. 

Proposed algorithms use graph based models and heuristics to solve the maximum independent set problem in a complement graph. Finding the compelement graph is shown in the figure below.

/fig/bipartite_complement.jpg

All proposed algorithms offer similar node removal heuristics, so implementation is very  straightforward once an initial coding is done.  Heuristics summary is shown in the figure below. 

/fig/heuristic.jpg

