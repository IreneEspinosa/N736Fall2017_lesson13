
* make a copy to WORK;
data helpmkh;
  set library.helpmkh;
  run;

* look at correlations;
proc corr data=helpmkh;
  var indtot cesd mcs pcs pss_fr;
  run;

* fit a model of cesd and mcs
  get VIF and standardized betas
  CI for betas
  run various tests;
proc reg data=helpmkh;
  model indtot = cesd mcs / CLB VIF STB;
  testcesd: test cesd=0;
  testmcs:  test mcs=0;
  run;

* fit a full model and test a reduced;
  proc reg data=helpmkh;
  model indtot = cesd mcs pcs pss_fr;
  test2: test pcs=0, pss_fr=0;
  run;

* fit a model with all 4 variables
  add TOL and COLLIN;
proc reg data=helpmkh
         plots=(RStudentByLeverage(label) residuals(smooth));
  model indtot = cesd mcs pcs pss_fr / STB CLB VIF TOL COLLIN;
  run;

* variable selection;
  proc reg data=helpmkh;
  model indtot = cesd mcs pcs pss_fr / selection = forward;
  run;

  proc reg data=helpmkh;
  model indtot = cesd mcs pcs pss_fr / selection = backward;
  run;

proc reg data=helpmkh;
  model indtot = cesd mcs pcs pss_fr / selection = stepwise;
  run;

* get best variable subset
  using C(p) option for variable selection;
proc reg data=helpmkh;
  model indtot = cesd mcs pcs pss_fr / selection = cp best = 5;
  run;
