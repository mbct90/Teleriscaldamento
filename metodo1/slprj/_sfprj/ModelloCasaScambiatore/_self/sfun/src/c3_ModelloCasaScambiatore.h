#ifndef __c3_ModelloCasaScambiatore_h__
#define __c3_ModelloCasaScambiatore_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc3_ModelloCasaScambiatoreInstanceStruct
#define typedef_SFc3_ModelloCasaScambiatoreInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c3_sfEvent;
  boolean_T c3_isStable;
  boolean_T c3_doneDoubleBufferReInit;
  uint8_T c3_is_active_c3_ModelloCasaScambiatore;
  real_T c3_To_temp[28411];
  real_T c3_err2[28411];
  real_T c3_varargin_1[28411];
  real_T c3_Ti[28411];
  real_T c3_dv1[28411];
  real_T c3_b_err2[28411];
  real_T c3_b_varargin_1[28411];
  real_T c3_y[28411];
  real_T c3_dv2[28411];
  real_T c3_inData[28411];
  real_T c3_u[28411];
  real_T *c3_ti;
  real_T *c3_Alfa;
  real_T *c3_To;
  real_T *c3_S;
  real_T *c3_tu;
  real_T *c3_Gu;
  real_T *c3_b_Ti;
} SFc3_ModelloCasaScambiatoreInstanceStruct;

#endif                                 /*typedef_SFc3_ModelloCasaScambiatoreInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c3_ModelloCasaScambiatore_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c3_ModelloCasaScambiatore_get_check_sum(mxArray *plhs[]);
extern void c3_ModelloCasaScambiatore_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
