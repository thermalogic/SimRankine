
/*
 The Rankine cycle model 85

*/
#ifndef RANKINE85_HPP
#define RANKINE85_HPP

#include "common.hpp"

Components Components85 = {
    {{"name", "TurbineEx1"},
     {"classstr", "TurbineEx1"},
     {"ef", 0.85},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 0.008}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"ePort", (mPort){{"p", 0.7}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}}},

    {{"name", "Condenser"},
     {"classstr", "Condenser"},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 0.008}, {"t", NAN}, {"x", 0.0}, {"fdot", NAN}}}},

    {{"name", "CondensatePump"},
     {"classstr", "Pump"},
     {"ef", 1.0},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 0.7}, {"t", NAN}, {"x", 0.0}, {"fdot", NAN}}}},

    {{"name", "OpenedFeedwaterHeater"},
     {"classstr", "OpenedHeaterDw0"},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"iPort_fw", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort_fw", (mPort){{"p", 0.7}, {"t", NAN}, {"x", 0.0}, {"fdot", NAN}}}},

    {{"name", "FeedwaterPump"},
     {"classstr", "Pump"},
     {"ef", 1.0},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 8.0}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}}},

    {{"name", "Boiler1"},
     {"classstr", "Boiler"},
     {"iPort", (mPort){{"p", NAN}, {"t", NAN}, {"x", NAN}, {"fdot", NAN}}},
     {"oPort", (mPort){{"p", 8.0}, {"t", 480.0}, {"x", NAN}, {"fdot", 1.0}}}}};

Connectors Connectors85 = {
    {{"Boiler1", "oPort"}, {"TurbineEx1", "iPort"}},
    {{"TurbineEx1", "ePort"}, {"OpenedFeedwaterHeater", "iPort"}},
    {{"TurbineEx1", "oPort"}, {"Condenser", "iPort"}},
    {{"Condenser", "oPort"}, {"CondensatePump", "iPort"}},
    {{"CondensatePump", "oPort"}, {"OpenedFeedwaterHeater", "iPort_fw"}},
    {{"OpenedFeedwaterHeater", "oPort_fw"}, {"FeedwaterPump", "iPort"}},
    {{"FeedwaterPump", "oPort"}, {"Boiler1", "iPort"}}

};

rankinecycle rankine85 = {Components85, Connectors85};

#endif /* RANKINE85_hpp */