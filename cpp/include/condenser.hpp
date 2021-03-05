/*
  Condenser.cpp
*/

#ifndef CONDENSER_HPP
#define CONDENSER_HPP

#include "common.hpp"

class Condenser : public CompBase
{
public:
  // methods
  double heatExtracted;
  Condenser(umComponent dictComp);
  ~Condenser();
 
  void setportaddress();
  void state();
  int balance();
  string resultstring();
 
};

#endif /* Condenser_hpp */
