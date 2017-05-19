def StrassenMM (A : [?Da] real, B : [?Db]real) : [Da] real{
  
  //Split the source domains into quadrants

  var D = normalizeDomain(Da);
  var (Q11,Q12,Q21,Q22) = domainQuadrants(D);
  var (A11,A12,A21,A22) = domainQuadrants(Da);
  var (B11,B12,B21,B22) = domainQuadrants(Db);


  // Create temporaries to hold precomputed factors

  var A11p22, B11p22, A21p22, B12m22, B21m11, A11p12,
    A21m11, B11p12, A12m22, B21p22 : [Q11] real;

  // Precompute matrix multiplication factors

	cobegin {A11p22 = A[A11] + A[A22];
    B11p22 = B[B11] + B[B22];
    A21p22 = A[A21] + A[A22];
    B12m22 = B[B12] - B[B22];
    B21m11 = B[B21] - B[B11];
    A11p12 = A[A11] + A[A12];
    A21m11 = A[A21] - A[A11];
    B11p12 = B[B11] + B[B12];
    A12m22 = A[A12] - A[A22];
    B21p22 = B[B21] + B[B22];
	}

  var M : [1..7][Q11] real; //Define temporaries to store results

  if (D.dim(1).high<=MMThresh){
    cobegin {M[1] = MatMul(A11p22,B11p22);
    M[2] = MatMul(A21p22,B[B11]);
    M[3] = MatMul(A[A11],B12m22);
    M[4] = MatMul(A[A22],B21m11);
    M[5] = MatMul(A11p12,B[B22]);
    M[6] = MatMul(A21m11,B11p12);
    M[7] = MatMul(A12m22,B21p22);
  }
} else {
  cobegin {
    M[1] = StrassenMM(A11p22,B11p22);
    M[2] = StrassenMM(A21p22,B[B11]);
    M[3] = StrassenMM(A[A11],B12m22);
    M[4] = StrassenMM(A[A22],B21m11);
    M[5] = StrassenMM(A11p12,B[B22]);
    M[6] = StrassenMM(A21m11,B11p12);
    M[7] = StrassenMM(A12m22,B21p22);
	}
 }
var C : [D] real;
cobegin {C[Q11] = M[1] + M[4] - M[5] + M[7];
  C[Q12] = M[3] + M[5];
  C[Q21] = M[2] + M[4];
  C[Q22] = M[1] - M[2] + M[3] + M[6];
}
return C;
writeln(C)
}


