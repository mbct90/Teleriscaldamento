/* Include files */

#include "ModelloCasaScambiatore_sfun.h"
#include "ModelloCasaScambiatore_sfun_debug_macros.h"
#include "c1_ModelloCasaScambiatore.h"
#include "c2_ModelloCasaScambiatore.h"
#include "c3_ModelloCasaScambiatore.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
uint32_T _ModelloCasaScambiatoreMachineNumber_;

/* Function Declarations */

/* Function Definitions */
void ModelloCasaScambiatore_initializer(void)
{
}

void ModelloCasaScambiatore_terminator(void)
{
}

/* SFunction Glue Code */
unsigned int sf_ModelloCasaScambiatore_method_dispatcher(SimStruct *simstructPtr,
  unsigned int chartFileNumber, const char* specsCksum, int_T method, void *data)
{
  if (chartFileNumber==1) {
    c1_ModelloCasaScambiatore_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==2) {
    c2_ModelloCasaScambiatore_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==3) {
    c3_ModelloCasaScambiatore_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  return 0;
}

extern void sf_ModelloCasaScambiatore_uses_exported_functions(int nlhs, mxArray *
  plhs[], int nrhs, const mxArray * prhs[])
{
  plhs[0] = mxCreateLogicalScalar(0);
}

unsigned int sf_ModelloCasaScambiatore_process_check_sum_call( int nlhs, mxArray
  * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[20];
  if (nrhs<1 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the checksum */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"sf_get_check_sum"))
    return 0;
  plhs[0] = mxCreateDoubleMatrix( 1,4,mxREAL);
  if (nrhs>1 && mxIsChar(prhs[1])) {
    mxGetString(prhs[1], commandName,sizeof(commandName)/sizeof(char));
    commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
    if (!strcmp(commandName,"machine")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(149364020U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1737700672U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2494909916U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(68960844U);
    } else if (!strcmp(commandName,"exportedFcn")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0U);
    } else if (!strcmp(commandName,"makefile")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1519104769U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(220510839U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1694518749U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(818889294U);
    } else if (nrhs==3 && !strcmp(commandName,"chart")) {
      unsigned int chartFileNumber;
      chartFileNumber = (unsigned int)mxGetScalar(prhs[2]);
      switch (chartFileNumber) {
       case 1:
        {
          extern void sf_c1_ModelloCasaScambiatore_get_check_sum(mxArray *plhs[]);
          sf_c1_ModelloCasaScambiatore_get_check_sum(plhs);
          break;
        }

       case 2:
        {
          extern void sf_c2_ModelloCasaScambiatore_get_check_sum(mxArray *plhs[]);
          sf_c2_ModelloCasaScambiatore_get_check_sum(plhs);
          break;
        }

       case 3:
        {
          extern void sf_c3_ModelloCasaScambiatore_get_check_sum(mxArray *plhs[]);
          sf_c3_ModelloCasaScambiatore_get_check_sum(plhs);
          break;
        }

       default:
        ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0.0);
      }
    } else if (!strcmp(commandName,"target")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2515920432U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3908508645U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2530489944U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2924353608U);
    } else {
      return 0;
    }
  } else {
    ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1249918713U);
    ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3605484735U);
    ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1117464605U);
    ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1689590637U);
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_ModelloCasaScambiatore_autoinheritance_info( int nlhs, mxArray *
  plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[32];
  char aiChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the autoinheritance_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_autoinheritance_info"))
    return 0;
  mxGetString(prhs[2], aiChksum,sizeof(aiChksum)/sizeof(char));
  aiChksum[(sizeof(aiChksum)/sizeof(char)-1)] = '\0';

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(aiChksum, "elAWGY8nm4xJJZiuqQyvH") == 0) {
          extern mxArray *sf_c1_ModelloCasaScambiatore_get_autoinheritance_info
            (void);
          plhs[0] = sf_c1_ModelloCasaScambiatore_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 2:
      {
        if (strcmp(aiChksum, "oXKauJBVztfOg8b0S2bIjF") == 0) {
          extern mxArray *sf_c2_ModelloCasaScambiatore_get_autoinheritance_info
            (void);
          plhs[0] = sf_c2_ModelloCasaScambiatore_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 3:
      {
        if (strcmp(aiChksum, "rbH3ZfO7SuEeBd5jYAGWcH") == 0) {
          extern mxArray *sf_c3_ModelloCasaScambiatore_get_autoinheritance_info
            (void);
          plhs[0] = sf_c3_ModelloCasaScambiatore_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_ModelloCasaScambiatore_get_eml_resolved_functions_info( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[64];
  if (nrhs<2 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the get_eml_resolved_functions_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_eml_resolved_functions_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        extern const mxArray
          *sf_c1_ModelloCasaScambiatore_get_eml_resolved_functions_info(void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c1_ModelloCasaScambiatore_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 2:
      {
        extern const mxArray
          *sf_c2_ModelloCasaScambiatore_get_eml_resolved_functions_info(void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c2_ModelloCasaScambiatore_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 3:
      {
        extern const mxArray
          *sf_c3_ModelloCasaScambiatore_get_eml_resolved_functions_info(void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c3_ModelloCasaScambiatore_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_ModelloCasaScambiatore_third_party_uses_info( int nlhs, mxArray *
  plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the third_party_uses_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_third_party_uses_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(tpChksum, "X0XW9W8xGRNRSREbsJ3u2G") == 0) {
          extern mxArray *sf_c1_ModelloCasaScambiatore_third_party_uses_info
            (void);
          plhs[0] = sf_c1_ModelloCasaScambiatore_third_party_uses_info();
          break;
        }
      }

     case 2:
      {
        if (strcmp(tpChksum, "Nn2Q49ev59ZyMvXXBs5DgF") == 0) {
          extern mxArray *sf_c2_ModelloCasaScambiatore_third_party_uses_info
            (void);
          plhs[0] = sf_c2_ModelloCasaScambiatore_third_party_uses_info();
          break;
        }
      }

     case 3:
      {
        if (strcmp(tpChksum, "MKVxpBPmwoBKg41dELZzLG") == 0) {
          extern mxArray *sf_c3_ModelloCasaScambiatore_third_party_uses_info
            (void);
          plhs[0] = sf_c3_ModelloCasaScambiatore_third_party_uses_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

unsigned int sf_ModelloCasaScambiatore_jit_fallback_info( int nlhs, mxArray *
  plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the jit_fallback_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_jit_fallback_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(tpChksum, "X0XW9W8xGRNRSREbsJ3u2G") == 0) {
          extern mxArray *sf_c1_ModelloCasaScambiatore_jit_fallback_info(void);
          plhs[0] = sf_c1_ModelloCasaScambiatore_jit_fallback_info();
          break;
        }
      }

     case 2:
      {
        if (strcmp(tpChksum, "Nn2Q49ev59ZyMvXXBs5DgF") == 0) {
          extern mxArray *sf_c2_ModelloCasaScambiatore_jit_fallback_info(void);
          plhs[0] = sf_c2_ModelloCasaScambiatore_jit_fallback_info();
          break;
        }
      }

     case 3:
      {
        if (strcmp(tpChksum, "MKVxpBPmwoBKg41dELZzLG") == 0) {
          extern mxArray *sf_c3_ModelloCasaScambiatore_jit_fallback_info(void);
          plhs[0] = sf_c3_ModelloCasaScambiatore_jit_fallback_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

unsigned int sf_ModelloCasaScambiatore_updateBuildInfo_args_info( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the updateBuildInfo_args_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_updateBuildInfo_args_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(tpChksum, "X0XW9W8xGRNRSREbsJ3u2G") == 0) {
          extern mxArray *sf_c1_ModelloCasaScambiatore_updateBuildInfo_args_info
            (void);
          plhs[0] = sf_c1_ModelloCasaScambiatore_updateBuildInfo_args_info();
          break;
        }
      }

     case 2:
      {
        if (strcmp(tpChksum, "Nn2Q49ev59ZyMvXXBs5DgF") == 0) {
          extern mxArray *sf_c2_ModelloCasaScambiatore_updateBuildInfo_args_info
            (void);
          plhs[0] = sf_c2_ModelloCasaScambiatore_updateBuildInfo_args_info();
          break;
        }
      }

     case 3:
      {
        if (strcmp(tpChksum, "MKVxpBPmwoBKg41dELZzLG") == 0) {
          extern mxArray *sf_c3_ModelloCasaScambiatore_updateBuildInfo_args_info
            (void);
          plhs[0] = sf_c3_ModelloCasaScambiatore_updateBuildInfo_args_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

void sf_ModelloCasaScambiatore_get_post_codegen_info( int nlhs, mxArray * plhs[],
  int nrhs, const mxArray * prhs[] )
{
  unsigned int chartFileNumber = (unsigned int) mxGetScalar(prhs[0]);
  char tpChksum[64];
  mxGetString(prhs[1], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  switch (chartFileNumber) {
   case 1:
    {
      if (strcmp(tpChksum, "X0XW9W8xGRNRSREbsJ3u2G") == 0) {
        extern mxArray *sf_c1_ModelloCasaScambiatore_get_post_codegen_info(void);
        plhs[0] = sf_c1_ModelloCasaScambiatore_get_post_codegen_info();
        return;
      }
    }
    break;

   case 2:
    {
      if (strcmp(tpChksum, "Nn2Q49ev59ZyMvXXBs5DgF") == 0) {
        extern mxArray *sf_c2_ModelloCasaScambiatore_get_post_codegen_info(void);
        plhs[0] = sf_c2_ModelloCasaScambiatore_get_post_codegen_info();
        return;
      }
    }
    break;

   case 3:
    {
      if (strcmp(tpChksum, "MKVxpBPmwoBKg41dELZzLG") == 0) {
        extern mxArray *sf_c3_ModelloCasaScambiatore_get_post_codegen_info(void);
        plhs[0] = sf_c3_ModelloCasaScambiatore_get_post_codegen_info();
        return;
      }
    }
    break;

   default:
    break;
  }

  plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
}

void ModelloCasaScambiatore_debug_initialize(struct SfDebugInstanceStruct*
  debugInstance)
{
  _ModelloCasaScambiatoreMachineNumber_ = sf_debug_initialize_machine
    (debugInstance,"ModelloCasaScambiatore","sfun",0,3,0,0,0);
  sf_debug_set_machine_event_thresholds(debugInstance,
    _ModelloCasaScambiatoreMachineNumber_,0,0);
  sf_debug_set_machine_data_thresholds(debugInstance,
    _ModelloCasaScambiatoreMachineNumber_,0);
}

void ModelloCasaScambiatore_register_exported_symbols(SimStruct* S)
{
}

static mxArray* sRtwOptimizationInfoStruct= NULL;
mxArray* load_ModelloCasaScambiatore_optimization_info(void)
{
  if (sRtwOptimizationInfoStruct==NULL) {
    sRtwOptimizationInfoStruct = sf_load_rtw_optimization_info(
      "ModelloCasaScambiatore", "ModelloCasaScambiatore");
    mexMakeArrayPersistent(sRtwOptimizationInfoStruct);
  }

  return(sRtwOptimizationInfoStruct);
}

void unload_ModelloCasaScambiatore_optimization_info(void)
{
  if (sRtwOptimizationInfoStruct!=NULL) {
    mxDestroyArray(sRtwOptimizationInfoStruct);
    sRtwOptimizationInfoStruct = NULL;
  }
}
