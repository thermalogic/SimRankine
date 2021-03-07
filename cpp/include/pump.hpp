/*
   pump.hpp
*/

#ifndef PUMP_HPP
#define PUMP_HPP

#include "common.hpp"

class Pump : public CompBase
{
public:
   double ef;
   // methods
   Pump(umComponent dictComp);
   ~Pump();

   void setportaddress();
   void state();
   int balance();
   string resultstring();
};

#endif /* PUMP_hpp */
