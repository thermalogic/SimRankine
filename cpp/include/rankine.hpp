/*
  rankine.hpp
    
- The Factory Method Pattern: 
     typedef std::map<std::string, std::function<CompBase *(umComponent, mapPort)>> compfactory;
     class ClassReg
*/

#ifndef RANKINE_HPP
#define RANKINE_HPP

#include "common.hpp"
#include "port.hpp"
#include "connector.hpp"
#include "boiler.hpp"
#include "condenser.hpp"
#include "pump.hpp"
#include "turbineex0.hpp"
#include "turbineex1.hpp"
#include "openedheaterdw0.hpp"
#include <list>
#include <typeinfo>
#include <functional>

typedef std::map<std::string, std::function<CompBase *(umComponent)>> compfactory;

class ClassReg
{
public:
    compfactory compinstance;
    // register
    template <typename T>
    void register_type(const std::string &name)
    {
        compinstance[name] = [](umComponent item) { return new T(item); };
    }

    void register_type_all()
    { // if you have the new component class, register it here!
        register_type<Boiler>("Boiler");
        register_type<Condenser>("Condenser");
        register_type<Pump>("Pump");
        register_type<TurbineEx0>("TurbineEx0");
        register_type<TurbineEx1>("TurbineEx1");
        register_type<OpenedHeaterDw0>("OpenedHeaterDw0");
    }
};

class RankineCycle
{
public:
    inline static compfactory compinstance;
    Connector *curcon;
    mComponentObj Comps;

    double totalworkExtracted;
    double totalworkRequired;
    double totalheatAdded;
    double netpoweroutput;
    double efficiency;
    double HeatRate;
    double SteamRate;

    double mdot;
    double Wcycledot;
    double totalWExtracted;
    double totalWRequired;
    double totalQAdded;

    // methods
    RankineCycle(vector<umComponent> dictcomps, vector<tupConnector> vecConnectors);
    ~RankineCycle();

    void ComponentState();
    void ComponentBalance();
    void Simulator();
    string resultstr();
    void outdevresultstr();
    void outresults();
};

#endif /* RANKINE_hpp */
