/*
  TurbineEx1.hpp
*/

#ifndef TurbineEx1_HPP
#define TurbineEx1_HPP

#include "common.hpp"

class TurbineEx1 : public CompBase
{
public:
  double ef;
  double workExtracted;

  // methods
  TurbineEx1(umComponent dictComp);
  ~TurbineEx1();

  void setportaddress();
  void state();
  int balance();
  string resultstring();
};

#endif /* TurbineEx1_hpp */
