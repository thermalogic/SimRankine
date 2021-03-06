/*
  Pump.cpp

*/

#include "pump.hpp"

Pump::Pump(umComponent dictComp)
{
    name = any_cast<const char *>(dictComp["name"]);
    ef = any_cast<double>(dictComp["ef"]);
    iPort = new Port(any_cast<mPort>(dictComp["iPort"]));
    oPort = new Port(any_cast<mPort>(dictComp["oPort"]));
    portdict = {{"iPort", iPort},
                {"oPort", oPort}};
    energy = WORKREQUIRED;
}

Pump::~Pump()
{
    delete iPort;
    delete oPort;
}

void Pump::state()
{
    oPort->h = iPort->h;
    double sout_s = iPort->s;
    double hout_s = seups(oPort->p, sout_s, 4);
    oPort->h = iPort->h + (hout_s - iPort->h) / ef;
    oPort->ph();
}

int Pump::balance()
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

    workRequired = iPort->fdot * (oPort->h - iPort->h);
    if (isnan(workRequired))
    {
        return 0;
    }
    else
        return 1;
}

void Pump::setportaddress()
{
    if (iPort != portdict["iPort"])
        iPort = portdict["iPort"];
    if (oPort != portdict["oPort"])
        oPort = portdict["oPort"];
}

string Pump::resultstring()
{
    string result;
    result = "\n" + name;
    result += "\n" + Port::title;
    result += "\n" + iPort->resultstring();
    result += "\n" + oPort->resultstring();
    result += "\nworkRequired(kJ/kg): " + to_string_with_precision<double>(workRequired, 3) + "\n";

    return result;
}