#reading data into stata
insheet using "c:\Users\LENOVO PC\Documents\mira.csv",clear
encode country, gen(cont)
xtset cont period, yearly
xtsum exp imp tb fdi gdp
xtline lnex
xtline lnim
xtline fdi 
xtline lngdp
xtline exp, overlay
xtline imp, overlay
xtline fdi, overlay
xtline gdp, overlay
#correlation analysis 
pwcorr lngdp lnim lnex lnfdi tb
#panel unit root test for the individual variable
xtunitroot fisher lnex, dfuller drift lags(2) demean
xtunitroot fisher lnim, dfuller drift lags(2) demean
xtunitroot fisher gp, dfuller drift lags(4) demean
xtunitroot fisher lnfdi, dfuller drift lags(2) demean
xtunitroot fisher tb, dfuller drift lags(2) demean
corr exp imp
xtline lnim
xtline fdi
xtline lnim, overlay
xtline fdi, overlay
xtline lngdp, overlay
. regress exp gdp fdi exr 
. regress lnex lngdp lnfdi lnexr
. regress lnim lngdp lnfdi lnexr
. regress imp gdp fdi exr
. regress tb gdp fdi exr 
. regress tb lngdp lnfdi lnexr
. reg lnex i.cont lngdp lnexr lnfdi
. reg lnim i.cont lngdp lnexr lnfdi
. reg tb i.cont lngdp lnexr lnfdi 
. xtreg lnex lngdp lnfdi lnexr, fe i(cont)
. display
. di
. display e(mss) e(rss) sqrt(e(rss)/e(df_r))
. di e(rss)
. xtreg lnim lngdp lnfdi lnexr, fe i(cont)
. di e(rss)
. xtreg tb lngdp lnfdi lnexr, fe i (cont)
est sto fe
estat hottest 
. di e(rss)
. regress lnim lngdp lnfdi lnexr 
est sto ols 
xi: regress lnim lngdp lnfdi lnexr i.cont 
est sto ols_dum
est tab ols ols_dum, star stats(N rss r2 r2_a)
#random effect model estimation for the three models
#model 1 
. xtreg lnim lngdp lnfdi lnexr, re theta
est sto ran_i
. xttest0
. xtreg lnim lngdp lnfdi lnexr, re mle
est sto ran_ii 
est tab ran_i ran_ii, star stats(N rss r2 r2_a)
#model 2
. xtreg lnex lngdp lnfdi lnexr, re theta 
est sto ran_tu
. xttest0
. xtreg lnex lngdp lnfdi lnexr, re mle 
est sto ran_tr 
est tab ran_tu ran_tr, star stats(N rss r2 r2_a)
#model 3
. xtreg tb lngdp lnfdi lnexr, re theta 
est sto ran_fo
. xttest0
. xtreg tb lngdp lnfdi lnexr, re mle 
est sto ran_fv 
est tab ran_fo ran_fv, star stats(N rss r2 r2_a)
#comparing of fixed and random effect 
#model 1
. xtreg lnim lngdp lnfdi lnexr, re
est sto ran_md1
. xtreg lnim lngdp lnfdi lnexr, fe
est sto fix_md1
. hausman ran_md1 fix_md1
#model 2
. xtreg lnex lngdp lnfdi lnexr, re  
est sto ran_md2
. xtreg lnex lngdp lnfdi lnexr, fe
est sto fix_md2
. hausman ran_md2 fix_md2 
#model 3 
. xtreg tb lngdp lnfdi lnexr, re 
est sto ran_md3
. xtreg tb lngdp lnfdi lnexr, fe
est sto fix_md3
. hausman ran_md3 fix_md3 
#diagonastic test 
ssc install xtest3
. xtreg lnim lngdp lnfdi lnexr, re
. xttest3 



  
 







