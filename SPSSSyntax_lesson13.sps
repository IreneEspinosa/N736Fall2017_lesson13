* Encoding: UTF-8.
* ==========================================.
* LESSON 13 - Multivariate Regression
* and variable selection
* ==========================================.

GET 
  FILE='C:\MyGithub\N736Fall2017_lesson13\helpmkh.sav'. 
DATASET NAME DataSet1 WINDOW=FRONT. 

* consider potential variables.

CORRELATIONS 
  /VARIABLES=pcs mcs pss_fr cesd indtot drugrisk sexrisk satreat 
  /PRINT=TWOTAIL NOSIG 
  /MISSING=PAIRWISE.
NONPAR CORR 
  /VARIABLES=pcs mcs pss_fr cesd indtot drugrisk sexrisk satreat 
  /PRINT=BOTH TWOTAIL NOSIG 
  /MISSING=PAIRWISE.

* look at distributions and descriptives.

FREQUENCIES VARIABLES=pss_fr pcs mcs cesd indtot drugrisk sexrisk 
  /NTILES=4 
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN 
  /HISTOGRAM 
  /ORDER=ANALYSIS.

* narrow down the list to focus on.

CORRELATIONS 
  /VARIABLES=indtot pss_fr pcs mcs cesd 
  /PRINT=TWOTAIL NOSIG 
  /MISSING=PAIRWISE.
NONPAR CORR 
  /VARIABLES=indtot pss_fr pcs mcs cesd 
  /PRINT=BOTH TWOTAIL NOSIG 
  /MISSING=PAIRWISE.

* enter all variables at one time.
* pay attention to collinearity stats.

REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS CI(95) R ANOVA COLLIN TOL CHANGE ZPP 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT indtot 
  /METHOD=ENTER cesd pss_fr pcs mcs 
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).

* stepwise variable selection.

REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS CI(95) R ANOVA COLLIN TOL CHANGE ZPP 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT indtot 
  /METHOD=STEPWISE cesd pss_fr pcs mcs 
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).

* use specific steps and order.
* cesd then mcs.

REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS CI(95) R ANOVA COLLIN TOL CHANGE ZPP 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT indtot 
  /METHOD=ENTER cesd 
  /METHOD=ENTER mcs 
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).

* change the order.
* mcs then cesd.

REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS CI(95) R ANOVA COLLIN TOL CHANGE ZPP 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT indtot 
  /METHOD=ENTER mcs 
  /METHOD=ENTER cesd 
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).


