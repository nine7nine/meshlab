/*********************************************************************/
/*                                                                   */
/*             Optimized BLAS libraries                              */
/*                     By Kazushige Goto <kgoto@tacc.utexas.edu>     */
/*                                                                   */
/* Copyright (c) The University of Texas, 2009. All rights reserved. */
/* UNIVERSITY EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES CONCERNING  */
/* THIS SOFTWARE AND DOCUMENTATION, INCLUDING ANY WARRANTIES OF      */
/* MERCHANTABILITY, FITNESS FOR ANY PARTICULAR PURPOSE,              */
/* NON-INFRINGEMENT AND WARRANTIES OF PERFORMANCE, AND ANY WARRANTY  */
/* THAT MIGHT OTHERWISE ARISE FROM COURSE OF DEALING OR USAGE OF     */
/* TRADE. NO WARRANTY IS EITHER EXPRESS OR IMPLIED WITH RESPECT TO   */
/* THE USE OF THE SOFTWARE OR DOCUMENTATION.                         */
/* Under no circumstances shall University be liable for incidental, */
/* special, indirect, direct or consequential damages or loss of     */
/* profits, interruption of business, or related expenses which may  */
/* arise from use of Software or Documentation, including but not    */
/* limited to those resulting from defects in Software and/or        */
/* Documentation, or loss or inaccuracy of data of any kind.         */
/*********************************************************************/

#include <stdio.h>
#include <ctype.h>
#include "common.h"
#include "symcopy.h"

int CNAME(BLASLONG m, BLASLONG offset, FLOAT alpha_r, FLOAT alpha_i, 
	 FLOAT *a, BLASLONG lda, FLOAT *x, BLASLONG incx, FLOAT *y, BLASLONG incy, FLOAT *buffer){

  BLASLONG is, min_i;
  FLOAT *X = x;
  FLOAT *Y = y;
  FLOAT *symbuffer  = buffer;
  FLOAT *gemvbuffer = (FLOAT *)(((BLASLONG)buffer + SYMV_P * SYMV_P * sizeof(FLOAT) * 2 + 4095) & ~4095);
  FLOAT *bufferY    = gemvbuffer;
  FLOAT *bufferX    = gemvbuffer;

  if (incy != 1) {
    Y = bufferY;
    bufferX    = (FLOAT *)(((BLASLONG)bufferY + m * sizeof(FLOAT) * 2 + 4095) & ~4095);
    gemvbuffer = bufferX;
    COPY_K(m, y, incy, Y, 1);
  }

  if (incx != 1) {
    X = bufferX;
    gemvbuffer = (FLOAT *)(((BLASLONG)bufferX + m * sizeof(FLOAT) * 2 + 4095) & ~4095);
    COPY_K(m, x, incx, X, 1);
  }

#ifndef LOWER
  for(is = m - offset; is < m; is += SYMV_P){
    min_i = MIN(m - is, SYMV_P);
#else
  for(is = 0; is < offset; is += SYMV_P){
    min_i = MIN(offset - is, SYMV_P);
#endif

#ifndef LOWER
    if (is > 0){
#ifndef HEMVREV
      GEMV_C(is, min_i, 0, alpha_r, alpha_i, 
	      a + is * lda * 2,  lda,
	      X,          1,
	      Y + is * 2, 1, gemvbuffer);

      GEMV_N(is, min_i, 0, alpha_r, alpha_i,
	      a + is * lda * 2,  lda,
	      X + is * 2, 1,
	      Y,          1, gemvbuffer);
#else
      GEMV_T(is, min_i, 0, alpha_r, alpha_i, 
	      a + is * lda * 2,  lda,
	      X,          1,
	      Y + is * 2, 1, gemvbuffer);

      GEMV_R(is, min_i, 0, alpha_r, alpha_i,
	      a + is * lda * 2,  lda,
	      X + is * 2, 1,
	      Y,          1, gemvbuffer);
#endif
    }
#endif

#ifndef HEMVREV
#ifdef LOWER
    ZHEMCOPY_L(min_i, a + (is + is * lda) * 2, lda, symbuffer);
#else
    ZHEMCOPY_U(min_i, a + (is + is * lda) * 2, lda, symbuffer);
#endif
#else
#ifdef LOWER
    ZHEMCOPY_M(min_i, a + (is + is * lda) * 2, lda, symbuffer);
#else
    ZHEMCOPY_V(min_i, a + (is + is * lda) * 2, lda, symbuffer);
#endif
#endif

    GEMV_N(min_i, min_i, 0, alpha_r, alpha_i, 
	    symbuffer, min_i,
	    X + is * 2, 1, 
	    Y + is * 2, 1, gemvbuffer);
    
#ifdef LOWER
    if (m - is - min_i > 0){

#ifndef HEMVREV
      GEMV_C(m - is - min_i, min_i, 0, alpha_r, alpha_i,
	      a + ((is + min_i) + is * lda) * 2, lda,
	      X + (is + min_i) * 2, 1,
	      Y +  is           * 2, 1, gemvbuffer);

      GEMV_N(m - is - min_i, min_i, 0, alpha_r, alpha_i,
	      a + ((is + min_i) + is * lda) * 2, lda,
	      X +  is           * 2,  1,
	      Y + (is + min_i) * 2,  1, gemvbuffer);
#else
      GEMV_T(m - is - min_i, min_i, 0, alpha_r, alpha_i,
	      a + ((is + min_i) + is * lda) * 2, lda,
	      X + (is + min_i) * 2, 1,
	      Y +  is           * 2, 1, gemvbuffer);

      GEMV_R(m - is - min_i, min_i, 0, alpha_r, alpha_i,
	      a + ((is + min_i) + is * lda) * 2, lda,
	      X +  is           * 2,  1,
	      Y + (is + min_i) * 2,  1, gemvbuffer);
#endif

    }
#endif

  } /* end of is */

  if (incy != 1) {
    COPY_K(m, Y, 1, y, incy);
  }

  return 0;
}

