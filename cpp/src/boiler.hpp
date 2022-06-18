/*
   Boiler.hpp
*/

#ifndef Boiler_HPP
#define Boiler_HPP

#include "common.hpp"

class Boiler : public CompBase
{
public:
   // methods
    Boiler(umComponent dictComp);
    ~Boiler();

    void setportaddress();
    void state();
    int balance();
    string resultstring();
};

#endif /* Boiler_HPP */
