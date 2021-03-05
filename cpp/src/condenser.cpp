/* 

  condenser.cpp

*/

#include "condenser.hpp"

Condenser::Condenser(umComponent dictComp)
{
    name = any_cast<const char *>(dictComp["name"]);
    iPort = new Port(any_cast<mPort>(dictComp["iPort"]));
    oPort = new Port(any_cast<mPort>(dictComp["oPort"]));
    portdict = {{"iPort", iPort},
                {"oPort", oPort}};
}

Condenser::~Condenser()
{
    delete iPort;
    delete oPort;
}

void Condenser::state()
{
    
}

int Condenser::balance()
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
    };

    heatExtracted =iPort->fdot * (iPort->h - oPort->h);
    if (isnan(heatExtracted))
    {
       return 0;
    }
    else
    {
        return 1;
    }   
}

void Condenser:: setportaddress()
{
  if (iPort!=portdict["iPort"])
      iPort=portdict["iPort"];
  if (oPort!=portdict["oPort"])
      oPort=portdict["oPort"];
}

string Condenser::resultstring()
{
    string result;
    result = "\n" + name;
    result += "\n" + Port::title;
    result += "\n" + iPort->resultstring();
    result += "\n" + oPort->resultstring();
    result += "\nheatExtracted(kJ/kg): " + to_string_with_precision<double>(heatExtracted, 3) + "\n";
    return result;
}