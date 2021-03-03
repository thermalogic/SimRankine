/*
 The Rankine cycle simulator :81

*/
#include "rankine.hpp"

vector<umComponent> Components81 = {
    {{"name", "Turbine1"},
     {"classstr", "TurbineEx0"},
     {"ef", 1.0},
     {"iPort", (mPort){{"p", NAN}, {"t",NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 0.008}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}}},
    {{"name", "Condenser"},
     {"classstr", "Condenser"},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 0.008}, {"t", NAN}, {"x",0.0}, {"fdot", NAN}}}},
    {{"name", "Pump1"},
     {"classstr", "Pump"},
     {"ef", 1.0},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 8.0}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}}},
    {{"name", "Boiler1"},
     {"classstr", "Boiler"},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 8.0}, {"t", NAN}, {"x", 1.0}, {"fdot", 1.0}}}}

};

vector<tupConnector> Connectors81 = {
    {{"Turbine1", "oPort"}, {"Condenser", "iPort"}},
    {{"Condenser", "oPort"}, {"Pump1", "iPort"}},
    {{"Pump1", "oPort"}, {"Boiler1", "iPort"}},
    {{"Boiler1", "oPort"}, {"Turbine1", "iPort"}}};

int main()
{
  // --- init the cycle analysis ----
  ClassReg curclassreg;
  curclassreg.register_type_all();
  RankineCycle::compinstance = curclassreg.compinstance; // the instance of compfactory

  // --- start the cycle analysis -------
  unique_ptr<RankineCycle> curcycle(new RankineCycle(Components81, Connectors81));
  curcycle->Simulator();
  curcycle->outresults();
  return 0;
}