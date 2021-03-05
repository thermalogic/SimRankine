/* 

  turbineex0.cpp

*/

#include "turbineex0.hpp"

TurbineEx0::TurbineEx0(umComponent dictComp)
{
    name = any_cast<const char *>(dictComp["name"]);
    ef = any_cast<double>(dictComp["ef"]);
    iPort = new Port(any_cast<mPort>(dictComp["iPort"]));
    oPort = new Port(any_cast<mPort>(dictComp["oPort"]));
    portdict = {{"iPort", iPort},
                {"oPort", oPort}};
    energy = "workExtracted";
    
}

TurbineEx0::~TurbineEx0()
{
    delete iPort;
    delete oPort;
}

void TurbineEx0::state()
{
    if (ef == 1.0)
    {
        oPort->s = iPort->s; //    Isentropic compression (ideal cycle)
        oPort->ps();
    }
    else
    {
       double isoh = seups(oPort->p,iPort->s,4);
       oPort->h = iPort->h - ef * (iPort->h - isoh);
       oPort->ph();
    }
}

int TurbineEx0::balance()
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
    //energy
    workExtracted = iPort->fdot * (iPort->h - oPort->h);
    if (isnan(workExtracted))
    {
        return 0;
    }
    else
        return 1;
}

void TurbineEx0::setportaddress()
{
    if (iPort != portdict["iPort"])
        iPort = portdict["iPort"];
    if (oPort != portdict["oPort"])
        oPort = portdict["oPort"];
}

string TurbineEx0::resultstring()
{
    string result;
    result = "\n" + name;
    result += "\n" + Port::title;
    result += "\n" + iPort->resultstring();
    result += "\n" + oPort->resultstring();
    result += "\nThe Turbine Work(kW): " + to_string_with_precision<double>(workExtracted, 3) + "\n";
    return result;
}