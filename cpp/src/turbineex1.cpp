/* 

  turbineex1.cpp

*/

#include "turbineex1.hpp"

TurbineEx1::TurbineEx1(umComponent dictComp)
{
    name = any_cast<const char *>(dictComp["name"]);
    iPort = new Port(any_cast<mPort>(dictComp["iPort"]));
    oPort = new Port(any_cast<mPort>(dictComp["oPort"]));
    portdict = {{"iPort", iPort},
                {"oPort", oPort}};
    energy = "WorkExtracted";
}

TurbineEx1::~TurbineEx1()
{
    delete iPort;
    delete oPort;
}

void TurbineEx1::state()
{
    //    Isentropic compression (ideal VCR cycle)
    oPort->s = iPort->s;
}

void TurbineEx1::balance()
{
    // mass and energy balance
    // mass balance
    if (!isnan(iPort->mdot))
    {
        oPort->mdot = iPort->mdot;
    }
    else
    {
        if (!isnan(oPort->mdot))
            iPort->mdot = oPort->mdot;
    }
    //energy
    workExtracted = iPort->mdot * (oPort->h - iPort->h);
}

void TurbineEx1::setportaddress()
{
    if (iPort != portdict["iPort"])
        iPort = portdict["iPort"];
    if (oPort != portdict["oPort"])
        oPort = portdict["oPort"];
}

string TurbineEx1::resultstring()
{
    string result;
    result = "\n" + name;
    result += "\n" + Port::title;
    result += "\n" + iPort->resultstring();
    result += "\n" + oPort->resultstring();
    result += "\nThe Turbine Work(kW): " + to_string_with_precision<double>(workExtracted, 3) + "\n";
    return result;
}