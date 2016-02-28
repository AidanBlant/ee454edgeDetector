/* Include files */

#include <stddef.h>
#include "blas.h"
#include "edgeDet_try2_sfun.h"
#include "c1_edgeDet_try2.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "edgeDet_try2_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(sfGlobalDebugInstanceStruct,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)
#define c1_IN_NO_ACTIVE_CHILD          ((uint8_T)0U)
#define c1_IN_Do_Math                  ((uint8_T)1U)
#define c1_IN_FinalState               ((uint8_T)2U)
#define c1_IN_InitialState             ((uint8_T)3U)
#define c1_IN_Select_Matrix            ((uint8_T)4U)
#define c1_IN_WritetoFile              ((uint8_T)5U)

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
static void initialize_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance);
static void initialize_params_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance);
static void enable_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance);
static void disable_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance);
static void c1_update_debugger_state_c1_edgeDet_try2
  (SFc1_edgeDet_try2InstanceStruct *chartInstance);
static const mxArray *get_sim_state_c1_edgeDet_try2
  (SFc1_edgeDet_try2InstanceStruct *chartInstance);
static void set_sim_state_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_st);
static void c1_set_sim_state_side_effects_c1_edgeDet_try2
  (SFc1_edgeDet_try2InstanceStruct *chartInstance);
static void finalize_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance);
static void sf_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct *chartInstance);
static void initSimStructsc1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static int32_T c1_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static uint8_T c1_b_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_b_tp_Do_Math, const char_T *c1_identifier);
static uint8_T c1_c_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static real_T c1_d_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_b_x, const char_T *c1_identifier);
static real_T c1_e_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static void c1_f_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_b_y[9]);
static void c1_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_g_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_b_setSimStateSideEffectsInfo, const char_T
  *c1_identifier);
static const mxArray *c1_h_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static real_T c1_get_M(SFc1_edgeDet_try2InstanceStruct *chartInstance, uint32_T
  c1_b);
static void c1_set_M(SFc1_edgeDet_try2InstanceStruct *chartInstance, uint32_T
                     c1_b, real_T c1_c);
static real_T *c1_access_M(SFc1_edgeDet_try2InstanceStruct *chartInstance,
  uint32_T c1_b);
static void init_dsm_address_info(SFc1_edgeDet_try2InstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance)
{
  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c1_doSetSimStateSideEffects = 0U;
  chartInstance->c1_setSimStateSideEffectsInfo = NULL;
  chartInstance->c1_tp_Do_Math = 0U;
  chartInstance->c1_tp_FinalState = 0U;
  chartInstance->c1_tp_InitialState = 0U;
  chartInstance->c1_tp_Select_Matrix = 0U;
  chartInstance->c1_tp_WritetoFile = 0U;
  chartInstance->c1_is_active_c1_edgeDet_try2 = 0U;
  chartInstance->c1_is_c1_edgeDet_try2 = c1_IN_NO_ACTIVE_CHILD;
  chartInstance->c1_x = 0.0;
  chartInstance->c1_y = 0.0;
  chartInstance->c1_i = 0.0;
  chartInstance->c1_j = 0.0;
}

static void initialize_params_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance)
{
}

static void enable_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void c1_update_debugger_state_c1_edgeDet_try2
  (SFc1_edgeDet_try2InstanceStruct *chartInstance)
{
  uint32_T c1_prevAniVal;
  c1_prevAniVal = _SFD_GET_ANIMATION();
  _SFD_SET_ANIMATION(0U);
  _SFD_SET_HONOR_BREAKPOINTS(0U);
  if (chartInstance->c1_is_active_c1_edgeDet_try2 == 1U) {
    _SFD_CC_CALL(CHART_ACTIVE_TAG, 0U, chartInstance->c1_sfEvent);
  }

  if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_Do_Math) {
    _SFD_CS_CALL(STATE_ACTIVE_TAG, 0U, chartInstance->c1_sfEvent);
  } else {
    _SFD_CS_CALL(STATE_INACTIVE_TAG, 0U, chartInstance->c1_sfEvent);
  }

  if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_WritetoFile) {
    _SFD_CS_CALL(STATE_ACTIVE_TAG, 6U, chartInstance->c1_sfEvent);
  } else {
    _SFD_CS_CALL(STATE_INACTIVE_TAG, 6U, chartInstance->c1_sfEvent);
  }

  if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_Select_Matrix) {
    _SFD_CS_CALL(STATE_ACTIVE_TAG, 5U, chartInstance->c1_sfEvent);
  } else {
    _SFD_CS_CALL(STATE_INACTIVE_TAG, 5U, chartInstance->c1_sfEvent);
  }

  if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_InitialState) {
    _SFD_CS_CALL(STATE_ACTIVE_TAG, 2U, chartInstance->c1_sfEvent);
  } else {
    _SFD_CS_CALL(STATE_INACTIVE_TAG, 2U, chartInstance->c1_sfEvent);
  }

  if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_FinalState) {
    _SFD_CS_CALL(STATE_ACTIVE_TAG, 1U, chartInstance->c1_sfEvent);
  } else {
    _SFD_CS_CALL(STATE_INACTIVE_TAG, 1U, chartInstance->c1_sfEvent);
  }

  _SFD_SET_ANIMATION(c1_prevAniVal);
  _SFD_SET_HONOR_BREAKPOINTS(1U);
  _SFD_ANIMATE();
}

static const mxArray *get_sim_state_c1_edgeDet_try2
  (SFc1_edgeDet_try2InstanceStruct *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_b_y = NULL;
  real_T c1_hoistedGlobal;
  real_T c1_u;
  const mxArray *c1_c_y = NULL;
  real_T c1_b_hoistedGlobal;
  real_T c1_b_u;
  const mxArray *c1_d_y = NULL;
  real_T c1_c_hoistedGlobal;
  real_T c1_c_u;
  const mxArray *c1_e_y = NULL;
  real_T c1_d_hoistedGlobal;
  real_T c1_d_u;
  const mxArray *c1_f_y = NULL;
  uint8_T c1_e_hoistedGlobal;
  uint8_T c1_e_u;
  const mxArray *c1_g_y = NULL;
  uint8_T c1_f_hoistedGlobal;
  uint8_T c1_f_u;
  const mxArray *c1_h_y = NULL;
  c1_st = NULL;
  c1_st = NULL;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_createcellarray(6), FALSE);
  c1_hoistedGlobal = chartInstance->c1_i;
  c1_u = c1_hoistedGlobal;
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_b_y, 0, c1_c_y);
  c1_b_hoistedGlobal = chartInstance->c1_j;
  c1_b_u = c1_b_hoistedGlobal;
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_b_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_b_y, 1, c1_d_y);
  c1_c_hoistedGlobal = chartInstance->c1_x;
  c1_c_u = c1_c_hoistedGlobal;
  c1_e_y = NULL;
  sf_mex_assign(&c1_e_y, sf_mex_create("y", &c1_c_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_b_y, 2, c1_e_y);
  c1_d_hoistedGlobal = chartInstance->c1_y;
  c1_d_u = c1_d_hoistedGlobal;
  c1_f_y = NULL;
  sf_mex_assign(&c1_f_y, sf_mex_create("y", &c1_d_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_b_y, 3, c1_f_y);
  c1_e_hoistedGlobal = chartInstance->c1_is_active_c1_edgeDet_try2;
  c1_e_u = c1_e_hoistedGlobal;
  c1_g_y = NULL;
  sf_mex_assign(&c1_g_y, sf_mex_create("y", &c1_e_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_b_y, 4, c1_g_y);
  c1_f_hoistedGlobal = chartInstance->c1_is_c1_edgeDet_try2;
  c1_f_u = c1_f_hoistedGlobal;
  c1_h_y = NULL;
  sf_mex_assign(&c1_h_y, sf_mex_create("y", &c1_f_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_b_y, 5, c1_h_y);
  sf_mex_assign(&c1_st, c1_b_y, FALSE);
  return c1_st;
}

static void set_sim_state_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_st)
{
  const mxArray *c1_u;
  c1_u = sf_mex_dup(c1_st);
  chartInstance->c1_i = c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 0)), "i");
  chartInstance->c1_j = c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 1)), "j");
  chartInstance->c1_x = c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 2)), "x");
  chartInstance->c1_y = c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 3)), "y");
  chartInstance->c1_is_active_c1_edgeDet_try2 = c1_b_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 4)),
     "is_active_c1_edgeDet_try2");
  chartInstance->c1_is_c1_edgeDet_try2 = c1_b_emlrt_marshallIn(chartInstance,
    sf_mex_dup(sf_mex_getcell(c1_u, 5)), "is_c1_edgeDet_try2");
  sf_mex_assign(&chartInstance->c1_setSimStateSideEffectsInfo,
                c1_g_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell
    (c1_u, 6)), "setSimStateSideEffectsInfo"), TRUE);
  sf_mex_destroy(&c1_u);
  chartInstance->c1_doSetSimStateSideEffects = 1U;
  c1_update_debugger_state_c1_edgeDet_try2(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void c1_set_sim_state_side_effects_c1_edgeDet_try2
  (SFc1_edgeDet_try2InstanceStruct *chartInstance)
{
  if (chartInstance->c1_doSetSimStateSideEffects != 0) {
    if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_Do_Math) {
      chartInstance->c1_tp_Do_Math = 1U;
    } else {
      chartInstance->c1_tp_Do_Math = 0U;
    }

    if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_FinalState) {
      chartInstance->c1_tp_FinalState = 1U;
    } else {
      chartInstance->c1_tp_FinalState = 0U;
    }

    if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_InitialState) {
      chartInstance->c1_tp_InitialState = 1U;
    } else {
      chartInstance->c1_tp_InitialState = 0U;
    }

    if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_Select_Matrix) {
      chartInstance->c1_tp_Select_Matrix = 1U;
    } else {
      chartInstance->c1_tp_Select_Matrix = 0U;
    }

    if (chartInstance->c1_is_c1_edgeDet_try2 == c1_IN_WritetoFile) {
      chartInstance->c1_tp_WritetoFile = 1U;
    } else {
      chartInstance->c1_tp_WritetoFile = 0U;
    }

    chartInstance->c1_doSetSimStateSideEffects = 0U;
  }
}

static void finalize_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance)
{
  sf_mex_destroy(&chartInstance->c1_setSimStateSideEffectsInfo);
}

static void sf_c1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct *chartInstance)
{
  boolean_T c1_out;
  boolean_T c1_b_out;
  boolean_T c1_c_out;
  boolean_T c1_d_out;
  real_T *c1_height;
  real_T *c1_width;
  int32_T exitg1;
  int32_T exitg2;
  c1_width = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
  c1_height = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
  c1_set_sim_state_side_effects_c1_edgeDet_try2(chartInstance);
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  chartInstance->c1_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  if (chartInstance->c1_is_active_c1_edgeDet_try2 == 0U) {
    _SFD_CC_CALL(CHART_ENTER_ENTRY_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
    chartInstance->c1_is_active_c1_edgeDet_try2 = 1U;
    _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
    _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 2U, chartInstance->c1_sfEvent);
    chartInstance->c1_is_c1_edgeDet_try2 = c1_IN_InitialState;
    _SFD_CS_CALL(STATE_ACTIVE_TAG, 2U, chartInstance->c1_sfEvent);
    chartInstance->c1_tp_InitialState = 1U;
    chartInstance->c1_x = 0.0;
    chartInstance->c1_y = 0.0;
  } else {
    switch (chartInstance->c1_is_c1_edgeDet_try2) {
     case c1_IN_Do_Math:
      CV_CHART_EVAL(0, 0, 1);
      _SFD_CS_CALL(STATE_ENTER_DURING_FUNCTION_TAG, 0U,
                   chartInstance->c1_sfEvent);
      _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
      break;

     case c1_IN_FinalState:
      CV_CHART_EVAL(0, 0, 2);
      _SFD_CS_CALL(STATE_ENTER_DURING_FUNCTION_TAG, 1U,
                   chartInstance->c1_sfEvent);
      _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG, 1U, chartInstance->c1_sfEvent);
      break;

     case c1_IN_InitialState:
      CV_CHART_EVAL(0, 0, 3);
      _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 11U, chartInstance->c1_sfEvent);
      chartInstance->c1_x = 0.0;
      do {
        exitg2 = 0;
        _SFD_CT_CALL(TRANSITION_BEFORE_PROCESSING_TAG, 12U,
                     chartInstance->c1_sfEvent);
        c1_out = (CV_TRANSITION_EVAL(12U, (int32_T)_SFD_CCP_CALL(12U, 0,
                    chartInstance->c1_x < *c1_height != 0U,
                    chartInstance->c1_sfEvent)) != 0);
        if (c1_out) {
          _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 12U, chartInstance->c1_sfEvent);
          _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 14U, chartInstance->c1_sfEvent);
          chartInstance->c1_y = 0.0;
          _SFD_CT_CALL(TRANSITION_BEFORE_PROCESSING_TAG, 15U,
                       chartInstance->c1_sfEvent);
          c1_b_out = (CV_TRANSITION_EVAL(15U, (int32_T)_SFD_CCP_CALL(15U, 0,
            chartInstance->c1_y < *c1_width != 0U, chartInstance->c1_sfEvent))
                      != 0);
          if (c1_b_out) {
            _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 15U, chartInstance->c1_sfEvent);
            _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 3U, chartInstance->c1_sfEvent);
            chartInstance->c1_i = 0.0;
            _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 1U, chartInstance->c1_sfEvent);
            chartInstance->c1_tp_InitialState = 0U;
            _SFD_CS_CALL(STATE_INACTIVE_TAG, 2U, chartInstance->c1_sfEvent);
            chartInstance->c1_is_c1_edgeDet_try2 = c1_IN_WritetoFile;
            _SFD_CS_CALL(STATE_ACTIVE_TAG, 6U, chartInstance->c1_sfEvent);
            chartInstance->c1_tp_WritetoFile = 1U;
            exitg2 = 1;
          } else {
            _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 16U, chartInstance->c1_sfEvent);
            chartInstance->c1_x++;
            _SF_MEX_LISTEN_FOR_CTRL_C(chartInstance->S);
          }
        } else {
          _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 13U, chartInstance->c1_sfEvent);
          chartInstance->c1_tp_InitialState = 0U;
          _SFD_CS_CALL(STATE_INACTIVE_TAG, 2U, chartInstance->c1_sfEvent);
          chartInstance->c1_is_c1_edgeDet_try2 = c1_IN_FinalState;
          _SFD_CS_CALL(STATE_ACTIVE_TAG, 1U, chartInstance->c1_sfEvent);
          chartInstance->c1_tp_FinalState = 1U;
          exitg2 = 1;
        }
      } while (exitg2 == 0);

      _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG, 2U, chartInstance->c1_sfEvent);
      break;

     case c1_IN_Select_Matrix:
      CV_CHART_EVAL(0, 0, 4);
      _SFD_CS_CALL(STATE_ENTER_DURING_FUNCTION_TAG, 5U,
                   chartInstance->c1_sfEvent);
      _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG, 5U, chartInstance->c1_sfEvent);
      break;

     case c1_IN_WritetoFile:
      CV_CHART_EVAL(0, 0, 5);
      _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 0U, chartInstance->c1_sfEvent);
      chartInstance->c1_y++;
      do {
        exitg1 = 0;
        _SFD_CT_CALL(TRANSITION_BEFORE_PROCESSING_TAG, 15U,
                     chartInstance->c1_sfEvent);
        c1_c_out = (CV_TRANSITION_EVAL(15U, (int32_T)_SFD_CCP_CALL(15U, 0,
          chartInstance->c1_y < *c1_width != 0U, chartInstance->c1_sfEvent)) !=
                    0);
        if (c1_c_out) {
          _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 15U, chartInstance->c1_sfEvent);
          _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 3U, chartInstance->c1_sfEvent);
          chartInstance->c1_i = 0.0;
          _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 1U, chartInstance->c1_sfEvent);
          chartInstance->c1_tp_WritetoFile = 0U;
          _SFD_CS_CALL(STATE_INACTIVE_TAG, 6U, chartInstance->c1_sfEvent);
          chartInstance->c1_is_c1_edgeDet_try2 = c1_IN_WritetoFile;
          _SFD_CS_CALL(STATE_ACTIVE_TAG, 6U, chartInstance->c1_sfEvent);
          chartInstance->c1_tp_WritetoFile = 1U;
          exitg1 = 1;
        } else {
          _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 16U, chartInstance->c1_sfEvent);
          chartInstance->c1_x++;
          _SFD_CT_CALL(TRANSITION_BEFORE_PROCESSING_TAG, 12U,
                       chartInstance->c1_sfEvent);
          c1_d_out = (CV_TRANSITION_EVAL(12U, (int32_T)_SFD_CCP_CALL(12U, 0,
            chartInstance->c1_x < *c1_height != 0U, chartInstance->c1_sfEvent))
                      != 0);
          if (c1_d_out) {
            _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 12U, chartInstance->c1_sfEvent);
            _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 14U, chartInstance->c1_sfEvent);
            chartInstance->c1_y = 0.0;
            _SF_MEX_LISTEN_FOR_CTRL_C(chartInstance->S);
          } else {
            _SFD_CT_CALL(TRANSITION_ACTIVE_TAG, 13U, chartInstance->c1_sfEvent);
            chartInstance->c1_tp_WritetoFile = 0U;
            _SFD_CS_CALL(STATE_INACTIVE_TAG, 6U, chartInstance->c1_sfEvent);
            chartInstance->c1_is_c1_edgeDet_try2 = c1_IN_FinalState;
            _SFD_CS_CALL(STATE_ACTIVE_TAG, 1U, chartInstance->c1_sfEvent);
            chartInstance->c1_tp_FinalState = 1U;
            exitg1 = 1;
          }
        }
      } while (exitg1 == 0);

      _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG, 6U, chartInstance->c1_sfEvent);
      break;

     default:
      CV_CHART_EVAL(0, 0, 0);
      chartInstance->c1_is_c1_edgeDet_try2 = c1_IN_NO_ACTIVE_CHILD;
      _SFD_CS_CALL(STATE_INACTIVE_TAG, 0U, chartInstance->c1_sfEvent);
      break;
    }
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_edgeDet_try2MachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
}

static void initSimStructsc1_edgeDet_try2(SFc1_edgeDet_try2InstanceStruct
  *chartInstance)
{
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber)
{
}

const mxArray *sf_c1_edgeDet_try2_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  sf_mex_assign(&c1_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), FALSE);
  return c1_nameCaptureInfo;
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_u;
  const mxArray *c1_b_y = NULL;
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(int32_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 6, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, FALSE);
  return c1_mxArrayOutData;
}

static int32_T c1_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_b_y;
  int32_T c1_i0;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_i0, 1, 6, 0U, 0, 0U, 0);
  c1_b_y = c1_i0;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_b_y;
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_b_y = c1_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  uint8_T c1_u;
  const mxArray *c1_b_y = NULL;
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(uint8_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, FALSE);
  return c1_mxArrayOutData;
}

static uint8_T c1_b_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_b_tp_Do_Math, const char_T *c1_identifier)
{
  uint8_T c1_b_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_b_y = c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_tp_Do_Math),
    &c1_thisId);
  sf_mex_destroy(&c1_b_tp_Do_Math);
  return c1_b_y;
}

static uint8_T c1_c_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_b_y;
  uint8_T c1_u0;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u0, 1, 3, 0U, 0, 0U, 0);
  c1_b_y = c1_u0;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_tp_Do_Math;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  uint8_T c1_b_y;
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)chartInstanceVoid;
  c1_b_tp_Do_Math = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_b_y = c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_tp_Do_Math),
    &c1_thisId);
  sf_mex_destroy(&c1_b_tp_Do_Math);
  *(uint8_T *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  real_T c1_u;
  const mxArray *c1_b_y = NULL;
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(real_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, FALSE);
  return c1_mxArrayOutData;
}

static real_T c1_d_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_b_x, const char_T *c1_identifier)
{
  real_T c1_b_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_b_y = c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_x), &c1_thisId);
  sf_mex_destroy(&c1_b_x);
  return c1_b_y;
}

static real_T c1_e_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_b_y;
  real_T c1_d0;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_b_y = c1_d0;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_x;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_b_y;
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)chartInstanceVoid;
  c1_b_x = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_b_y = c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_x), &c1_thisId);
  sf_mex_destroy(&c1_b_x);
  *(real_T *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_i1;
  int32_T c1_i2;
  int32_T c1_i3;
  real_T c1_b_inData[9];
  int32_T c1_i4;
  int32_T c1_i5;
  int32_T c1_i6;
  real_T c1_u[9];
  const mxArray *c1_b_y = NULL;
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_i1 = 0;
  for (c1_i2 = 0; c1_i2 < 3; c1_i2++) {
    for (c1_i3 = 0; c1_i3 < 3; c1_i3++) {
      c1_b_inData[c1_i3 + c1_i1] = (*(real_T (*)[9])c1_inData)[c1_i3 + c1_i1];
    }

    c1_i1 += 3;
  }

  c1_i4 = 0;
  for (c1_i5 = 0; c1_i5 < 3; c1_i5++) {
    for (c1_i6 = 0; c1_i6 < 3; c1_i6++) {
      c1_u[c1_i6 + c1_i4] = c1_b_inData[c1_i6 + c1_i4];
    }

    c1_i4 += 3;
  }

  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 2, 3, 3), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, FALSE);
  return c1_mxArrayOutData;
}

static void c1_f_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_b_y[9])
{
  real_T c1_dv0[9];
  int32_T c1_i7;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_dv0, 1, 0, 0U, 1, 0U, 2, 3, 3);
  for (c1_i7 = 0; c1_i7 < 9; c1_i7++) {
    c1_b_y[c1_i7] = c1_dv0[c1_i7];
  }

  sf_mex_destroy(&c1_u);
}

static void c1_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_M;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_b_y[9];
  int32_T c1_i8;
  int32_T c1_i9;
  int32_T c1_i10;
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)chartInstanceVoid;
  c1_M = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_f_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_M), &c1_thisId, c1_b_y);
  sf_mex_destroy(&c1_M);
  c1_i8 = 0;
  for (c1_i9 = 0; c1_i9 < 3; c1_i9++) {
    for (c1_i10 = 0; c1_i10 < 3; c1_i10++) {
      (*(real_T (*)[9])c1_outData)[c1_i10 + c1_i8] = c1_b_y[c1_i10 + c1_i8];
    }

    c1_i8 += 3;
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_g_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_b_setSimStateSideEffectsInfo, const char_T
  *c1_identifier)
{
  const mxArray *c1_b_y = NULL;
  emlrtMsgIdentifier c1_thisId;
  c1_b_y = NULL;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  sf_mex_assign(&c1_b_y, c1_h_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_setSimStateSideEffectsInfo), &c1_thisId), FALSE);
  sf_mex_destroy(&c1_b_setSimStateSideEffectsInfo);
  return c1_b_y;
}

static const mxArray *c1_h_emlrt_marshallIn(SFc1_edgeDet_try2InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  const mxArray *c1_b_y = NULL;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_duplicatearraysafe(&c1_u), FALSE);
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static real_T c1_get_M(SFc1_edgeDet_try2InstanceStruct *chartInstance, uint32_T
  c1_b)
{
  ssReadFromDataStoreElement(chartInstance->S, 0, NULL, c1_b);
  if (chartInstance->c1_M_address == 0) {
    sf_mex_error_message("Invalid access to Data Store Memory data \'M\' (#41) in the initialization routine of the chart.\n");
  }

  return (*chartInstance->c1_M_address)[c1_b];
}

static void c1_set_M(SFc1_edgeDet_try2InstanceStruct *chartInstance, uint32_T
                     c1_b, real_T c1_c)
{
  ssWriteToDataStoreElement(chartInstance->S, 0, NULL, c1_b);
  if (chartInstance->c1_M_address == 0) {
    sf_mex_error_message("Invalid access to Data Store Memory data \'M\' (#41) in the initialization routine of the chart.\n");
  }

  (*chartInstance->c1_M_address)[c1_b] = c1_c;
}

static real_T *c1_access_M(SFc1_edgeDet_try2InstanceStruct *chartInstance,
  uint32_T c1_b)
{
  real_T *c1_c;
  ssReadFromDataStore(chartInstance->S, 0, NULL);
  if (chartInstance->c1_M_address == 0) {
    sf_mex_error_message("Invalid access to Data Store Memory data \'M\' (#41) in the initialization routine of the chart.\n");
  }

  c1_c = *chartInstance->c1_M_address;
  if (c1_b == 0) {
    ssWriteToDataStore(chartInstance->S, 0, NULL);
  }

  return c1_c;
}

static void init_dsm_address_info(SFc1_edgeDet_try2InstanceStruct *chartInstance)
{
  ssGetSFcnDataStoreNameAddrIdx(chartInstance->S, "M", (void **)
    &chartInstance->c1_M_address, &chartInstance->c1_M_index);
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c1_edgeDet_try2_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2970331209U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1468049574U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2908643425U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3091310698U);
}

mxArray *sf_c1_edgeDet_try2_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("UcYrmZgVYFY9QhvaBgSvuG");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c1_edgeDet_try2_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c1_edgeDet_try2_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c1_edgeDet_try2(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x6'type','srcId','name','auxInfo'{{M[3],M[81],T\"i\",},{M[3],M[82],T\"j\",},{M[3],M[19],T\"x\",},{M[3],M[20],T\"y\",},{M[8],M[0],T\"is_active_c1_edgeDet_try2\",},{M[9],M[0],T\"is_c1_edgeDet_try2\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 6, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_edgeDet_try2_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_edgeDet_try2InstanceStruct *chartInstance;
    chartInstance = (SFc1_edgeDet_try2InstanceStruct *) ((ChartInfoStruct *)
      (ssGetUserData(S)))->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _edgeDet_try2MachineNumber_,
           1,
           7,
           18,
           7,
           0,
           0,
           0,
           0,
           0,
           &(chartInstance->chartNumber),
           &(chartInstance->instanceNumber),
           ssGetPath(S),
           (void *)S);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          init_script_number_translation(_edgeDet_try2MachineNumber_,
            chartInstance->chartNumber);
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,_edgeDet_try2MachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _edgeDet_try2MachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,0,0,0,"x");
          _SFD_SET_DATA_PROPS(1,0,0,0,"y");
          _SFD_SET_DATA_PROPS(2,11,0,0,"M");
          _SFD_SET_DATA_PROPS(3,1,1,0,"height");
          _SFD_SET_DATA_PROPS(4,1,1,0,"width");
          _SFD_SET_DATA_PROPS(5,0,0,0,"i");
          _SFD_SET_DATA_PROPS(6,0,0,0,"j");
          _SFD_STATE_INFO(0,0,0);
          _SFD_STATE_INFO(1,0,0);
          _SFD_STATE_INFO(2,0,0);
          _SFD_STATE_INFO(5,0,0);
          _SFD_STATE_INFO(6,0,0);
          _SFD_CH_SUBSTATE_COUNT(5);
          _SFD_CH_SUBSTATE_DECOMP(0);
          _SFD_CH_SUBSTATE_INDEX(0,0);
          _SFD_CH_SUBSTATE_INDEX(1,1);
          _SFD_CH_SUBSTATE_INDEX(2,2);
          _SFD_CH_SUBSTATE_INDEX(3,5);
          _SFD_CH_SUBSTATE_INDEX(4,6);
          _SFD_ST_SUBSTATE_COUNT(0,0);
          _SFD_ST_SUBSTATE_COUNT(1,0);
          _SFD_ST_SUBSTATE_COUNT(2,0);
          _SFD_ST_SUBSTATE_COUNT(5,0);
          _SFD_ST_SUBSTATE_COUNT(6,0);
        }

        _SFD_CV_INIT_CHART(5,1,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        {
          _SFD_CV_INIT_STATE(1,0,0,0,0,0,NULL,NULL);
        }

        {
          _SFD_CV_INIT_STATE(2,0,0,0,0,0,NULL,NULL);
        }

        {
          _SFD_CV_INIT_STATE(5,0,0,0,0,0,NULL,NULL);
        }

        {
          _SFD_CV_INIT_STATE(6,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(16,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(14,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(1,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(11,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(2,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(7,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(3,0,NULL,NULL,0,NULL);

        {
          static unsigned int sStartGuardMap[] = { 1 };

          static unsigned int sEndGuardMap[] = { 4 };

          static int sPostFixPredicateTree[] = { 0 };

          _SFD_CV_INIT_TRANS(4,1,&(sStartGuardMap[0]),&(sEndGuardMap[0]),1,
                             &(sPostFixPredicateTree[0]));
        }

        _SFD_CV_INIT_TRANS(5,0,NULL,NULL,0,NULL);

        {
          static unsigned int sStartGuardMap[] = { 1 };

          static unsigned int sEndGuardMap[] = { 6 };

          static int sPostFixPredicateTree[] = { 0 };

          _SFD_CV_INIT_TRANS(8,1,&(sStartGuardMap[0]),&(sEndGuardMap[0]),1,
                             &(sPostFixPredicateTree[0]));
        }

        _SFD_CV_INIT_TRANS(6,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(9,0,NULL,NULL,0,NULL);
        _SFD_CV_INIT_TRANS(10,0,NULL,NULL,0,NULL);

        {
          static unsigned int sStartGuardMap[] = { 1 };

          static unsigned int sEndGuardMap[] = { 8 };

          static int sPostFixPredicateTree[] = { 0 };

          _SFD_CV_INIT_TRANS(15,1,&(sStartGuardMap[0]),&(sEndGuardMap[0]),1,
                             &(sPostFixPredicateTree[0]));
        }

        {
          static unsigned int sStartGuardMap[] = { 1 };

          static unsigned int sEndGuardMap[] = { 9 };

          static int sPostFixPredicateTree[] = { 0 };

          _SFD_CV_INIT_TRANS(12,1,&(sStartGuardMap[0]),&(sEndGuardMap[0]),1,
                             &(sPostFixPredicateTree[0]));
        }

        _SFD_CV_INIT_TRANS(13,0,NULL,NULL,0,NULL);

        {
          static unsigned int sStartGuardMap[] = { 1, 7 };

          static unsigned int sEndGuardMap[] = { 5, 11 };

          static int sPostFixPredicateTree[] = { 0, 1, -3 };

          _SFD_CV_INIT_TRANS(17,2,&(sStartGuardMap[0]),&(sEndGuardMap[0]),3,
                             &(sPostFixPredicateTree[0]));
        }

        _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_c_sf_marshallOut,(MexInFcnForType)c1_c_sf_marshallIn);
        _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_c_sf_marshallOut,(MexInFcnForType)c1_c_sf_marshallIn);

        {
          unsigned int dimVector[2];
          dimVector[0]= 3;
          dimVector[1]= 3;
          _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c1_d_sf_marshallOut,(MexInFcnForType)
            c1_d_sf_marshallIn);
        }

        _SFD_SET_DATA_COMPILED_PROPS(3,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_c_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(4,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_c_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(5,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_c_sf_marshallOut,(MexInFcnForType)c1_c_sf_marshallIn);
        _SFD_SET_DATA_COMPILED_PROPS(6,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_c_sf_marshallOut,(MexInFcnForType)c1_c_sf_marshallIn);

        {
          real_T *c1_height;
          real_T *c1_width;
          c1_width = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
          c1_height = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
          _SFD_SET_DATA_VALUE_PTR(0U, &chartInstance->c1_x);
          _SFD_SET_DATA_VALUE_PTR(1U, &chartInstance->c1_y);
          _SFD_SET_DATA_VALUE_PTR(2U, *chartInstance->c1_M_address);
          _SFD_SET_DATA_VALUE_PTR(3U, c1_height);
          _SFD_SET_DATA_VALUE_PTR(4U, c1_width);
          _SFD_SET_DATA_VALUE_PTR(5U, &chartInstance->c1_i);
          _SFD_SET_DATA_VALUE_PTR(6U, &chartInstance->c1_j);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _edgeDet_try2MachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "wfU3SWW2Dk92kMqAT3hs3G";
}

static void sf_opaque_initialize_c1_edgeDet_try2(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc1_edgeDet_try2InstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*)
    chartInstanceVar);
  initialize_c1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c1_edgeDet_try2(void *chartInstanceVar)
{
  enable_c1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c1_edgeDet_try2(void *chartInstanceVar)
{
  disable_c1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c1_edgeDet_try2(void *chartInstanceVar)
{
  sf_c1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*) chartInstanceVar);
}

extern const mxArray* sf_internal_get_sim_state_c1_edgeDet_try2(SimStruct* S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c1_edgeDet_try2
    ((SFc1_edgeDet_try2InstanceStruct*)chartInfo->chartInstance);/* raw sim ctx */
  prhs[3] = (mxArray*) sf_get_sim_state_info_c1_edgeDet_try2();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_raw2high'.\n");
  }

  return plhs[0];
}

extern void sf_internal_set_sim_state_c1_edgeDet_try2(SimStruct* S, const
  mxArray *st)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_high2raw");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = mxDuplicateArray(st);      /* high level simctx */
  prhs[3] = (mxArray*) sf_get_sim_state_info_c1_edgeDet_try2();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*)
    chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray* sf_opaque_get_sim_state_c1_edgeDet_try2(SimStruct* S)
{
  return sf_internal_get_sim_state_c1_edgeDet_try2(S);
}

static void sf_opaque_set_sim_state_c1_edgeDet_try2(SimStruct* S, const mxArray *
  st)
{
  sf_internal_set_sim_state_c1_edgeDet_try2(S, st);
}

static void sf_opaque_terminate_c1_edgeDet_try2(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_edgeDet_try2InstanceStruct*) chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_edgeDet_try2_optimization_info();
    }

    finalize_c1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*) chartInstanceVar);
    utFree((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*)
    chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_edgeDet_try2(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_edgeDet_try2((SFc1_edgeDet_try2InstanceStruct*)
      (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c1_edgeDet_try2(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_edgeDet_try2_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,1,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,1,
      "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(S,sf_get_instance_specialization(),infoStruct,1);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,1,2);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=0; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 2; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,1);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(545025370U));
  ssSetChecksum1(S,(4194505060U));
  ssSetChecksum2(S,(2229390207U));
  ssSetChecksum3(S,(42500447U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,0);
}

static void mdlRTW_c1_edgeDet_try2(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Stateflow");
  }
}

static void mdlStart_c1_edgeDet_try2(SimStruct *S)
{
  SFc1_edgeDet_try2InstanceStruct *chartInstance;
  chartInstance = (SFc1_edgeDet_try2InstanceStruct *)utMalloc(sizeof
    (SFc1_edgeDet_try2InstanceStruct));
  memset(chartInstance, 0, sizeof(SFc1_edgeDet_try2InstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 0;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway = sf_opaque_gateway_c1_edgeDet_try2;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c1_edgeDet_try2;
  chartInstance->chartInfo.terminateChart = sf_opaque_terminate_c1_edgeDet_try2;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c1_edgeDet_try2;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c1_edgeDet_try2;
  chartInstance->chartInfo.getSimState = sf_opaque_get_sim_state_c1_edgeDet_try2;
  chartInstance->chartInfo.setSimState = sf_opaque_set_sim_state_c1_edgeDet_try2;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c1_edgeDet_try2;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c1_edgeDet_try2;
  chartInstance->chartInfo.mdlStart = mdlStart_c1_edgeDet_try2;
  chartInstance->chartInfo.mdlSetWorkWidths = mdlSetWorkWidths_c1_edgeDet_try2;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->S = S;
  ssSetUserData(S,(void *)(&(chartInstance->chartInfo)));/* register the chart instance with simstruct */
  init_dsm_address_info(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  sf_opaque_init_subchart_simstructs(chartInstance->chartInfo.chartInstance);
  chart_debug_initialization(S,1);
}

void c1_edgeDet_try2_method_dispatcher(SimStruct *S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_edgeDet_try2(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_edgeDet_try2(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_edgeDet_try2(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_edgeDet_try2_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
