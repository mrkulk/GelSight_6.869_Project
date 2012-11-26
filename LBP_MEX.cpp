/**************************************************************************
 * Author: Tejas D Kulkarni
 *************************************************************************/

#include <math.h>
#include "mex.h"

#define eps 0.0001
#define PI 3.1415926535897931
static inline double min(double x, double y) { return (x <= y ? x : y); }
static inline double max(double x, double y) { return (x <= y ? y : x); }
static inline int min(int x, int y) { return (x <= y ? x : y); }
static inline int max(int x, int y) { return (x <= y ? y : x); }
static inline int greater(double x,double y) {return (x > y ? 1 : 0);}

mxArray* computeLBP( double *I,int h, int w) {
    const int out[3] = {h,w,1};
    mxArray *mxH = mxCreateNumericArray(3, out, mxDOUBLE_CLASS, mxREAL);
    double *H = (double*) mxGetPr(mxH);
    int TELM=w*h;
  
    /*for(int i=0;i<w;i++) H[i] = 0;
    for(int i=0;i<w;i++) H[i+(h*(w-1))] = 0;
    for(int i=0;i<h;i++) H[i*(w-1)] = 0;
    for(int i=0;i<h;i++) H[(w-1) + (i*(w-1)))] = 0;
    */
        
    for(int j=1;j<(h-1);j++){
        for(int i=1;i<(w-1);i++){
            unsigned int code = 0;
            
            if(greater(I[i+w*j],I[(i-1)+(w*(j))]) == 1) {
                code = code | 0x01;
            }
           
            if(greater(I[i+w*j],I[(i-1)+(w*(j-1))])) {
                code = code | 0x02;
            }
            
            if(greater(I[i+w*j],I[(i)+(w*(j+1))])) {
                code = code | 0x04;
            }
          
            if(greater(I[i+w*j],I[(i+1)+(w*(j+1))])) {
                code = code | 0x08;
            }
          
            if(greater(I[i+w*j],I[(i+1)+(w*(j))]) == 1) {
                code = code | 0x010;
            }
         
            if(greater(I[i+w*j],I[(i+1)+(w*(j-1))]) == 1) {
                code = code | 0x20;
            }
         
            if(greater(I[i+w*j],I[(i)+(w*(j-1))]) == 1) {
                code = code | 0x40;
            }
            
            if(greater(I[i+w*j],I[(i-1)+(w*(j-1))]) == 1) {
                code = code | 0x80;
            }
  
            H[i+(w*j)] = (double) code;
        }
    }
    
    return mxH;
}

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[] ) {
    // Error checking
    if( nrhs<1 || nrhs>5 ) mexErrMsgTxt("One to four inputs expected.");
    if( nlhs>1 ) mexErrMsgTxt("One output expected.");
    int nDims=mxGetNumberOfDimensions(prhs[0]);
    const int *dims = mxGetDimensions(prhs[0]);
    int nCh=(nDims==2) ? 1 : dims[2];
    if( (nDims!=2 && nDims!=3) || mxGetClassID(prhs[0])!=mxDOUBLE_CLASS)
        mexErrMsgTxt("I must be a double 2 or 3 dim array.");
  
    double *I = (double*) mxGetPr(prhs[0]);
    plhs[0] = computeLBP(I,dims[0],dims[1]);
}
