/*
 
rankine.cpp
 - Input:
     * vector<umComponent> Components ={}
     * vector<tupConnector>  Connectors = {} 
*/

#include "rankine.hpp "

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
            cout <<name<<"\t"<<e.what() << endl;
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
    int devnum = 0;
    for (mComponentObj::iterator iter = Comps.begin(); iter != Comps.end(); iter++)
    {
        keys.push_back(iter->first);
        devnum += 1;
    };
    bool deviceok = false;
    int i = 0;
    while ((deviceok == false) & (i <= devnum))
    {
        for (auto &item : keys)
        {
            try
            {
                Comps[item]->balance();
                keys.remove(item); // delect the balanced compoment 
            }
            catch (...)
            {
            };
            i += 1;
        };
        if (keys.size() == 0)
        {
            deviceok = true;
        };
    };

    // for debug : check the failed devices
    if (keys.size() > 0)
    {
        for (auto &item : keys) 
        {
            cout<<item<<"\t";
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
            totalworkExtracted += ((TurbineEx0 *)iter->second)->workExtracted;
        }
        else
        {
            if (iter->second->energy == "HeatAdded")
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
    result += "\tThe Cycle Efficiency(%): " + to_string_with_precision<double>(100.0*efficiency, 3) + "\n";
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
