/*
 The Rankine cycle model 82

*/
#ifndef RANKINE82_HPP
#define RANKINE82_HPP

#include "common.hpp"

Components Components82 = {
    {{"name", "Turbine1"},
     {"classstr", "TurbineEx0"},
     {"ef", 0.85},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 0.008}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}}},
    {{"name", "Condenser"},
     {"classstr", "Condenser"},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 0.008}, {"t", NAN}, {"x", 0.0}, {"fdot", NAN}}}},
    {{"name", "Pump1"},
     {"classstr", "Pump"},
     {"ef", 0.85},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 8.0}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}}},
    {{"name", "Boiler1"},
     {"classstr", "Boiler"},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 8.0}, {"t", NAN}, {"x", 1.0}, {"fdot", 1.0}}}}

};

Connectors Connectors82 = {
    {{"Turbine1", "oPort"}, {"Condenser", "iPort"}},
    {{"Condenser", "oPort"}, {"Pump1", "iPort"}},
    {{"Pump1", "oPort"}, {"Boiler1", "iPort"}},
    {{"Boiler1", "oPort"}, {"Turbine1", "iPort"}}};

rankinecycle rankine82 = {Components82, Connectors82};

#endif /* RANKINE82_hpp */
