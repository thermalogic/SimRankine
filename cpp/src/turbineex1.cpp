/* 

  turbineex1.cpp

*/

#include "turbineex1.hpp"

TurbineEx1::TurbineEx1(umComponent dictComp)
{
    name = any_cast<const char *>(dictComp["name"]);
    ef = any_cast<double>(dictComp["ef"]);
    iPort = new Port(any_cast<mPort>(dictComp["iPort"]));
    oPort = new Port(any_cast<mPort>(dictComp["oPort"]));
    ePort = new Port(any_cast<mPort>(dictComp["ePort"]));

    portdict = {{"iPort", iPort},
                {"oPort", oPort},
                {"ePort", ePort}};
    energy = WORKEXTRACTED;
}

TurbineEx1::~TurbineEx1()
{
    delete iPort;
    delete oPort;
    delete ePort;
}

void TurbineEx1::state()
{
    if (ef == 1.0)
    {
        ePort->s = iPort->s;
        ePort->ps();
        oPort->s = iPort->s;
        oPort->ps();
    }
    else
    {
        double isoh = seups(ePort->p, iPort->s, 4);
        ePort->h = iPort->h - ef * (iPort->h - isoh);
        ePort->ph();
        isoh = seups(oPort->p, ePort->s, 4);
        oPort->h = ePort->h - ef * (ePort->h - isoh);
        oPort->ph();
    };
}

int TurbineEx1::balance()
{

    oPort->fdot = iPort->fdot - ePort->fdot;
    double ienergy = iPort->fdot * iPort->h;
    double oenergy = ePort->fdot * ePort->h + oPort->fdot * oPort->h;
    workExtracted = ienergy - oenergy;
    if (isnan(workExtracted))
    {
        return 0;
    }
    else
        return 1;
}

void TurbineEx1::setportaddress()
{
    if (iPort != portdict["iPort"])
        iPort = portdict["iPort"];
    if (oPort != portdict["oPort"])
        oPort = portdict["oPort"];
    if (ePort != portdict["ePort"])
        ePort = portdict["ePort"];
}

string TurbineEx1::resultstring()
{
    string result;
    result = "\n" + name;
    result += "\n" + Port::title;
    result += "\n" + iPort->resultstring();
    result += "\n" + oPort->resultstring();
    result += "\n" + ePort->resultstring();
    result += "\nworkExtracted(kJ/kg): " + to_string_with_precision<double>(workExtracted, 3) + "\n";
    return result;
}