Clustering
==========

This is an implementation of clustering/scheduling for combinators, using ILP.
The version shown in the paper *Fusing Filters with Integer Linear Program* is in Program/Paper/*.

GLPK, and glpk-hs are required.


Example
=====
  $ ./Benchmarks benches/QuadTree.comb
  Clustering:
  Found a 3-length clustering
  1: { minx maxx miny maxy }
  2: { External(xmym) }
  3: { tl tr bl br }

