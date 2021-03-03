/*
   xpansionValveExpansionValve.cpp
*/

#ifndef EXPANSIONVALVE_HPP
#define EXPANSIONVALVE_HPP

#include "common.hpp"

class Pump : public CompBase
{
public:
   double workRequired;
   double ef;
   // methods
   Pump(umComponent dictComp);
   ~Pump();

   void setportaddress();
   void state();
   void balance();
   string resultstring();
};

#endif /* EXPANSIONVALVE_hpp */
