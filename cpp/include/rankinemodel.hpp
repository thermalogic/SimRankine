/*
 The Rankine cycle model 

*/
#ifndef RANKINEMODEL_HPP
#define RANKINEMODEL_HPP

#include "common.hpp"

typedef vector<umComponent> Components;
typedef vector<tupConnector> Connectors;
typedef tuple<Components, Connectors> rankinecycle;
typedef vector<rankinecycle> rankinecycles;

Components Components81 = {
        {{"name", "Turbine1"},
         {"classstr", "TurbineEx0"},
         {"ef", 1.0},
         {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
         {"oPort", (mPort){{"p", 0.008}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}}},
        {{"name", "Condenser"},
         {"classstr", "Condenser"},
         {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
         {"oPort", (mPort){{"p", 0.008}, {"t", NAN}, {"x", 0.0}, {"fdot", NAN}}}},
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

Connectors Connectors81 = {
    {{"Turbine1", "oPort"}, {"Condenser", "iPort"}},
    {{"Condenser", "oPort"}, {"Pump1", "iPort"}},
    {{"Pump1", "oPort"}, {"Boiler1", "iPort"}},
    {{"Boiler1", "oPort"}, {"Turbine1", "iPort"}}};

rankinecycle rankine81 = {Components81, Connectors81};

Components Components82 = {
    {{"name", "Turbine1"},
     {"classstr", "TurbineEx0"},
     {"ef",0.85},
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
rankinecycles cycles= {rankine81, rankine82};

#endif /* RANKINEMODEL_hpp */
