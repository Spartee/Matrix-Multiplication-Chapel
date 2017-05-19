/* this is a distributed program run in parallel over multiple locales.
 */

use Random, Time;
use BlockDist;  // use the block distribution


/*
  Here we set up several config consts that represent, in order:
    - ``N``, the dimension for the square array ``A``
    - ``K``, the second dimension for arrays ``X`` and ``B``
    - ``epsilon``, the margin of error for success
    - ``seed``, a seed for random number generation
*/

config const N = 4;
config const K = 4;
config const seed = 100;
config const seed2 = 100;



// create a variable to create the space needed in block distribution
const Space = {1..N, 1..K};

// Create the arrays ``A``, ``X``, and ``B``. Fill ``A`` and ``X`` with random
// values.

const Aspace: domain(2) dmapped Block(boundingBox=Space) = Space;
var A : [Aspace] real;
fillRandom(A, seed);

const Xspace: domain(2) dmapped Block(boundingBox=Space) = Space;
var X : [Xspace] real;
fillRandom(X, seed2);

const Bspace: domain(2) dmapped Block(boundingBox=Space) = Space;
var B : [Bspace] real;

// variables for the time taken by the program.
var t:Timer;


// Matrix multiply ``A*X``, store result in ``B``
proc Mmultiply(N: int, K: int): void
{
    t.start(); // start timer
    forall i in 1..N do {
      forall j in 1..K do { 
        forall k in 1..N do { 
           B[i,j] += A[i,k] * X[k,j];
        }
      }
    }
    t.stop(); // stop timer
    writeln(t.elapsed()," seconds elapsed");
    t.clear();
}

// loop to print results of 10 executions of Mmultiply proc. 
for f in 1..10 do {
    Mmultiply(N, K);
 }

writeln(" 10 calculations complete");



