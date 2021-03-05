/*
  OpenedHeaterDw0.hpp
*/

#ifndef OpenedHeaterDw0_HPP
#define OpenedHeaterDw0_HPP

#include "common.hpp"

class OpenedHeaterDw0 : public CompBase
{
public:
  double heatAdded;
  double heatExtracted;

  // methods
  OpenedHeaterDw0(umComponent dictComp);
  ~OpenedHeaterDw0();

  void setportaddress();
  void state();
  int balance();
  string resultstring();
};

#endif /* OpenedHeaterDw0_hpp */
