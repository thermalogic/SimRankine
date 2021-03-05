/* 

  OpenedHeaterDw0.cpp

*/

#include "openedheaterdw0.hpp"

OpenedHeaterDw0::OpenedHeaterDw0(umComponent dictComp)
{
    name = any_cast<const char *>(dictComp["name"]);
    iPort = new Port(any_cast<mPort>(dictComp["iPort"]));
    iPort_fw = new Port(any_cast<mPort>(dictComp["iPort_fw"]));
    oPort_fw = new Port(any_cast<mPort>(dictComp["oPort_fw"]));

    portdict = {{"iPort", iPort},
                {"iPort_fw", iPort_fw},
                {"oPort_fw", oPort_fw}};
    energy = "internel";
}

OpenedHeaterDw0::~OpenedHeaterDw0()
{
    delete iPort;
    delete iPort_fw;
    delete oPort_fw;
}

void OpenedHeaterDw0::state()
{
}

int OpenedHeaterDw0::balance()
{
    // energy balance equation
    double qes1 = iPort->h - oPort_fw->h;
    double qfw1 = oPort_fw->h - iPort_fw->h;
    iPort->fdot = oPort_fw->fdot * qfw1 / (qes1 + qfw1);
    //mass balance equation
    iPort_fw->fdot = oPort_fw->fdot - iPort->fdot;

    heatAdded = iPort_fw->fdot * qfw1;
    heatExtracted = iPort->fdot * qes1;
    if (isnan(heatAdded))
    {
        return 0;
    }
    else
        return 1;
}

void OpenedHeaterDw0::setportaddress()
{
    if (iPort != portdict["iPort"])
        iPort = portdict["iPort"];
    if (iPort_fw != portdict["iPort_fw"])
        iPort_fw = portdict["iPort_fw"];
    if (oPort_fw != portdict["oPort_fw"])
        oPort_fw = portdict["oPort_fw"];
}

string OpenedHeaterDw0::resultstring()
{
    string result;
    result = "\n" + name;
    result += "\n" + Port::title;
    result += "\n" + iPort->resultstring();
    result += "\n" + iPort_fw->resultstring();
    result += "\n" + oPort_fw->resultstring();
    result += "\nheatAdded(kJ/kg): " + to_string_with_precision<double>(heatAdded, 3);
    result += "\nheatExtracted(kJ/kg): " + to_string_with_precision<double>(heatExtracted, 3) + "\n";
    return result;
}