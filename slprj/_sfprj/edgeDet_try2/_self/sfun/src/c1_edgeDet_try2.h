#ifndef __c1_edgeDet_try2_h__
#define __c1_edgeDet_try2_h__

/* Include files */
#include "sfc_sf.h"
#include "sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc1_edgeDet_try2InstanceStruct
#define typedef_SFc1_edgeDet_try2InstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c1_sfEvent;
  uint8_T c1_tp_Do_Math;
  uint8_T c1_tp_WritetoFile;
  uint8_T c1_tp_Select_Matrix;
  uint8_T c1_tp_InitialState;
  uint8_T c1_tp_FinalState;
  boolean_T c1_isStable;
  uint8_T c1_is_active_c1_edgeDet_try2;
  uint8_T c1_is_c1_edgeDet_try2;
  real_T c1_x;
  real_T c1_y;
  real_T c1_i;
  real_T c1_j;
  uint8_T c1_doSetSimStateSideEffects;
  const mxArray *c1_setSimStateSideEffectsInfo;
  real_T (*c1_M_address)[9];
  int32_T c1_M_index;
} SFc1_edgeDet_try2InstanceStruct;

#endif                                 /*typedef_SFc1_edgeDet_try2InstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c1_edgeDet_try2_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c1_edgeDet_try2_get_check_sum(mxArray *plhs[]);
extern void c1_edgeDet_try2_method_dispatcher(SimStruct *S, int_T method, void
  *data);

#endif
