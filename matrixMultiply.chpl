/* a sequential chapel program to multiply two matrices that are rendomly generated*/

use Random;
use Time;

/*
  Here we set up several config consts that represent, in order:
    - ``N``, the dimension for the square array ``A``
    - ``K``, the second dimension for arrays ``X`` and ``B``
    - ``seed``, a seed for random number generation
*/
config const N = 4;
config const K = 4;
config const seed = 100;
config const seed2 = 100;

// variables for the time taken by the program.
var t:Timer;

// Create the arrays ``A``, ``X``, and ``B``. Fill ``A`` and ``X`` with random
// values.
var A : [1..N, 1..N] real;  // first matrix
fillRandom(A, seed);

var X : [1..N, 1..K] real; // second matrix
fillRandom(X, seed2);

var B : [1..N, 1..K] real; // matrix for results. 

// Matrix multiply ``A*X``, store result in ``B``
proc Mmultiply(N: int, K: int): void {

  t.start();
  for i in 1..N do {
    for j in 1..K do {
      for k in 1..N do {
         B[i,j] += A[i,k] * X[k,j];
      }
    }
  }
  t.stop();
  writeln(t.elapsed()," seconds elapsed");
  t.clear();
}


// loop to print results of 10 executions of Mmultiply proc. 
for f in 1..10 do {
    Mmultiply(N, K);
 }

writeln(" 10 calculations complete");



// print results

// writeln("Matrix A:\n", A, "\n");
// writeln("Matrix X:\n", X, "\n");
// writeln("Matrix B:\n", B, "\n");
//writeln(t.elapsed()," seconds elapsed");