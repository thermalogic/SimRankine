/*
  TurbineEx0.hpp
*/

#ifndef TurbineEx0_HPP
#define TurbineEx0_HPP

#include "common.hpp"

class TurbineEx0 : public CompBase
{
public:
    double ef;
    double workExtracted;

    // methods
    TurbineEx0(umComponent dictComp);
    ~TurbineEx0();

    void setportaddress();
    void state();
    void balance();
    string resultstring();
};

#endif /* TurbineEx0_hpp */
