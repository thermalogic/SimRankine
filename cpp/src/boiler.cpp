/* 

  Boiler.cpp

*/

#include "boiler.hpp"

Boiler::Boiler(umComponent dictComp)
{
    name = any_cast<const char *>(dictComp["name"]);
    iPort = new Port(any_cast<mPort>(dictComp["iPort"]));
    oPort = new Port(any_cast<mPort>(dictComp["oPort"]));
    portdict = {{"iPort", iPort},
                {"oPort", oPort}};
    energy = HEATADDED;
}

Boiler::~Boiler()
{
    delete iPort;
    delete oPort;
}

void Boiler::state()
{
}

int Boiler::balance()
{
    // mass and energy balance
    // mass balance
    if (!isnan(iPort->fdot))
    {
        oPort->fdot = iPort->fdot;
    }
    else
    {
        if (!isnan(oPort->fdot))
            iPort->fdot = oPort->fdot;
    }
    heatAdded = iPort->fdot * (oPort->h - iPort->h);
    if (isnan(heatAdded))
    {
        return 0;
    }
    else
        return 1;
}

void Boiler::setportaddress()
{
    if (iPort != portdict["iPort"])
        iPort = portdict["iPort"];
    if (oPort != portdict["oPort"])
        oPort = portdict["oPort"];
}

string Boiler::resultstring()
{
    string result;
    result = "\n" + name;
    result += "\n" + Port::title;
    result += "\n" + iPort->resultstring();
    result += "\n" + oPort->resultstring();
    result += "\nheatAdded(kJ/kg)): " + to_string_with_precision<double>(heatAdded, 3) + "\n";
    return result;
}