#ifndef __c2_ModelloCasaScambiatore_h__
#define __c2_ModelloCasaScambiatore_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc2_ModelloCasaScambiatoreInstanceStruct
#define typedef_SFc2_ModelloCasaScambiatoreInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c2_sfEvent;
  boolean_T c2_isStable;
  boolean_T c2_doneDoubleBufferReInit;
  uint8_T c2_is_active_c2_ModelloCasaScambiatore;
  real_T c2_ti_temp[68001];
  real_T c2_err1[68001];
  real_T c2_A[68001];
  real_T c2_b_A[68001];
  real_T c2_b[68001];
  real_T c2_b_err1[68001];
  real_T c2_c_A[68001];
  real_T c2_y[68001];
  real_T c2_dv0[68001];
  real_T c2_inData[68001];
  real_T c2_u[68001];
  real_T *c2_Km;
  real_T *c2_ti;
  real_T *c2_Tamb;
  real_T *c2_Gu;
  real_T *c2_tu;
} SFc2_ModelloCasaScambiatoreInstanceStruct;

#endif                                 /*typedef_SFc2_ModelloCasaScambiatoreInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c2_ModelloCasaScambiatore_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c2_ModelloCasaScambiatore_get_check_sum(mxArray *plhs[]);
extern void c2_ModelloCasaScambiatore_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
