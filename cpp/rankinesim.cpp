/*
 The Rankine cycle simulator

*/
#include "rankinemodel.hpp"
#include "rankine.hpp"

int main()
{
  // --- init the cycle analysis ----
  ClassReg curclassreg;
  curclassreg.register_type_all();
  RankineCycle::compinstance = curclassreg.compinstance; // the instance of compfactory

  // --- start the cycle analysis -------
  for (auto &item : cycles)
  {
    unique_ptr<RankineCycle> curcycle(new RankineCycle(get<0>(item), get<1>(item)));
    curcycle->Simulator();
    curcycle->outresults();
  };
  return 0;
}