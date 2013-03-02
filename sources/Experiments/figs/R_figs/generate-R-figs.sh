#!/bin/sh
Rscript config.r "./res_Turbofan/" "bpr"
Rscript config.r "./res_Turbofan/" "pi_c"
Rscript config.r "./res_Turbofan/" "o1"
Rscript config.r "./res_Turbofan/" "o2"

Rscript config.r "./res_Alexandrov/" "o"
Rscript config.r "./res_Alexandrov/" "l1"
Rscript config.r "./res_Alexandrov/" "l2"
Rscript config.r "./res_Alexandrov/" "s"

Rscript config.r "./res_Viennet1/" "viennet_o1"
Rscript config.r "./res_Viennet1/" "viennet_o2"
Rscript config.r "./res_Viennet1/" "viennet_o3"

Rscript config.r "./res_Rosenbrock/" "minimizer"
Rscript config.r "./res_Rosenbrock/" "x1"
Rscript config.r "./res_Rosenbrock/" "x2"

Rscript config-firstrun.r "./res_Alexandrov/" "o"
Rscript config-firstrun.r "./res_Alexandrov/" "l1"
Rscript config-firstrun.r "./res_Alexandrov/" "l2"
Rscript config-firstrun.r "./res_Alexandrov/" "s"

Rscript config-pertubated.r "./res_Alexandrov_pertubated/" "o"
Rscript config-pertubated.r "./res_Alexandrov_pertubated/" "l1"
Rscript config-pertubated.r "./res_Alexandrov_pertubated/" "l2"
Rscript config-pertubated.r "./res_Alexandrov_pertubated/" "s"

mv ./*.pdf ./generated/.
