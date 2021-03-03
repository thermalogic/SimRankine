/*
   Boiler.hpp
*/

#ifndef Boiler_HPP
#define Boiler_HPP

#include "common.hpp"

class Boiler : public CompBase
{
public:
    double heatAdded;
    // methods
    Boiler(umComponent dictComp);
    ~Boiler();

    void setportaddress();
    void state();
    void balance();
    string resultstring();
};

#endif /* Boiler_HPP */
