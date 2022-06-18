/*--------------------------------------------- 

   Port.cpp

-------------------------------------------------------*/

#ifndef PORT_HPP
#define PORT_HPP

#include <string>
#include <unordered_map>
#include <any>
#include <exception>
#include <cmath>
#include "seuif97.h"

using namespace std;

#define NONEINDEX -100

typedef unordered_map<string, any> mPort;

class Port
{
public:
  inline static const string title = "Port   	P(MPa)   T(C)  H(kJ/kg)	  S(kJ/kg.K)  Quality FDOT MDOT(kg/s)"; //C++17

  int index;

  double p;
  double t;
  double h;
  double s;
  double x;
  double fdot;
  double mdot;

  // methods
  Port(mPort curmPort);
  ~Port();

  void calmdot(double totalmass);
  void pt();
  void px();
  void tx();
  void ps();
  void ph();
  string resultstring();
};

#endif /* port_hpp */
