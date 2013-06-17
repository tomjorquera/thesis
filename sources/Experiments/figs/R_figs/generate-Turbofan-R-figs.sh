#!/bin/sh
Rscript config-turbofan-pertubated.r "./res_Turbofan_perturbated/" "pi_c"
Rscript config-turbofan-pertubated.r "./res_Turbofan_perturbated/" "bpr"
Rscript config-turbofan-pertubated.r "./res_Turbofan_perturbated/" "c1"
Rscript config-turbofan-pertubated.r "./res_Turbofan_perturbated/" "c2"
Rscript config-turbofan-pertubated.r "./res_Turbofan_perturbated/" "o1"
Rscript config-turbofan-pertubated.r "./res_Turbofan_perturbated/" "o2"

mv ./*.pdf ./generated/.
