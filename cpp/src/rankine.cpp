/*
 
rankine.cpp
 - Input:
     * vector<umComponent> Components ={}
     * vector<tupConnector>  Connectors = {} 
*/

#include "rankine.hpp"

RankineCycle::~RankineCycle()
{
    delete curcon;

    for (mComponentObj::iterator iter = Comps.begin(); iter != Comps.end(); iter++)
        delete iter->second;
    Comps.clear();
}

RankineCycle::RankineCycle(vector<umComponent> dictComps, vector<tupConnector> vecConnectors)
{
    // 1 components
    for (auto &item : dictComps)
    {
        string classstr = any_cast<const char *>(item["classstr"]);
        string name = any_cast<const char *>(item["name"]);
        try
        { // register_type
            Comps.insert(mComponentObj::value_type(name, compinstance[classstr](item)));
        }
        catch (exception &e)
        {
            cout << name << "\t" << e.what() << endl;
        }
    }
    // 2 connectors
    curcon = new Connector();
    for (auto &tconn : vecConnectors)
        curcon->AddConnector(tconn, Comps);
}

void RankineCycle::ComponentState()
{
    // the  state by process
    for (mComponentObj::iterator iter = Comps.begin(); iter != Comps.end(); iter++)
    {
        iter->second->state();
    };
}

void RankineCycle::ComponentBalance()
{
    list<string> keys;
    vector<bool> balanceok;
    int devnum = 0;
    for (mComponentObj::iterator iter = Comps.begin(); iter != Comps.end(); iter++)
    {
        keys.push_back(iter->first);
        balanceok.push_back(false);
        devnum += 1;
    };
    int numdeviceok = 0;
    int numiter = 0;
    int rtn;
    while ((numiter <= devnum) & (numdeviceok <= devnum))
    {
        int i = 0;
        for (auto &item : keys)
        {
            if (balanceok[i] == false)
            {
                try
                {
                    rtn = Comps[item]->balance();
                    if (rtn == 1)
                    {
                        balanceok[i] = true;
                        numdeviceok = +1;
                    }
                }
                catch (...)
                {
                };
            };
            i += 1;
        };
        numiter += 1;
    };
    // for debug : check the failed devices
    if (numdeviceok < devnum)
    {
        int i = 0;
        for (auto &item : keys)
        {
            if (balanceok[i] == false)
            {
                cout << item << "\t";
            }
            i += 1;
        };
    };
}

void RankineCycle::Simulator()
{
    ComponentState();
    ComponentBalance();

    totalworkExtracted = 0;
    totalworkRequired = 0;
    totalheatAdded = 0;

    for (mComponentObj::iterator iter = Comps.begin(); iter != Comps.end(); iter++)
    {
        if (iter->second->energy == "workExtracted")
        {
            try
            {
                totalworkExtracted += ((TurbineEx0 *)iter->second)->workExtracted;
            }
            catch (...)
            {
                try
                {
                    totalworkExtracted += ((TurbineEx1 *)iter->second)->workExtracted;
                }
                catch (...)
                {
                };
            };
        };
        if (iter->second->energy == "heatAdded")
        {
            totalheatAdded = ((Boiler *)iter->second)->heatAdded;
        };
        if (iter->second->energy == "workRequired")
        {
            totalworkRequired += ((Pump *)iter->second)->workRequired;
        };
    };
    netpoweroutput = totalworkExtracted - totalworkRequired;
    efficiency = netpoweroutput / totalheatAdded;
    HeatRate = 3600.0 / efficiency;
    SteamRate = HeatRate / totalheatAdded;
}

string RankineCycle::resultstr()
{
    string result;
    result = "\n --- The Rankine Cycle ---\n";
    result += "\tTurbine  Work(kW): " + to_string_with_precision<double>(totalworkExtracted, 3) + "\n";
    result += "\tWorkRequired(kW): " + to_string_with_precision<double>(totalworkRequired, 3) + "\n";
    result += "\tNetPower(kW): " + to_string_with_precision<double>(netpoweroutput, 3) + "\n";
    result += "\tHeatAdded(kW): " + to_string_with_precision<double>(totalheatAdded, 3) + "\n";
    result += "\tThe Cycle Efficiency(%): " + to_string_with_precision<double>(100.0 * efficiency, 3) + "\n";
    return result;
}

void RankineCycle::outdevresultstr()
{
    // 1 component's results
    for (mComponentObj::iterator iter = Comps.begin(); iter != Comps.end(); iter++)
    {
        cout << iter->second->resultstring() << endl;
    }
    // 2 node's results
    cout << "\n"
         << Port::title << endl;
    for (auto &item : curcon->Nodes)
    {
        cout << item->resultstring() << endl;
    }
}

void RankineCycle::outresults()
{
    cout << resultstr() << endl;
    outdevresultstr();
}
