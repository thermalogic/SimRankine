/*----------------------------------------------------

  port.cpp
----------------------------------------------------------*/

#include "common.hpp"
#include "port.hpp"

Port::Port(mPort curmPort)
{
   index = NONEINDEX;
   try
   {
      p = any_cast<double>(curmPort["p"]);
   }
   catch (...)
   {
      p = NAN;
   }

   try
   {
      t = any_cast<double>(curmPort["t"]);
   }
   catch (...)
   {
      t = NAN;
   }
   try
   {
      x = any_cast<double>(curmPort["x"]);
   }
   catch (...)
   {
      x = NAN;
   }
   try
   {
      fdot = any_cast<double>(curmPort["fdot"]);
   }
   catch (...)
   {
      fdot = NAN;
   }
   h = NAN;
   s = NAN;
   mdot = NAN;

   
   if (!isnan(p) & !isnan(t))
   {
      pt();
   }
   else
   {
      if (!isnan(t) & !isnan(x))
      {
         tx();
      }
      else
      {
          if (!isnan(p) & !isnan(x))
         {
            px();
         }
      }
   }
}   

Port::~Port()
{
}

void Port::calmdot(double totalmass)
{
   mdot = totalmass * fdot;
}

void Port::pt()
{
   h = seupt(p, t, 4);
   s = seupt(p, t, 5);
   x = seupt(p, t, 15);
}

void Port::tx()
{
   p = seutx(t, x, 0);
   h = seutx(t, x, 4);
   s = seutx(t, x, 5);
}

void Port::px()
{
   t = seupx(p, x, 1);
   h = seupx(p, x, 4);
   s = seupx(p, x, 5);
}

void Port::ps()
{
   t = seups(p, s, 1);
   h = seups(p, s, 4);
   x = seups(p, s, 15);
}

void Port::ph()
{
   t = seuph(p, h, 1);
   s = seuph(p, h, 5);
   x = seuph(p, s, 15);
}

string Port::resultstring()
{
   string result;
   result = to_string(index);
   result += "\t" + to_string_with_precision<double>(p, 3);
   result += "\t" + to_string_with_precision<double>(t, 3);
   result += "\t" + to_string_with_precision<double>(h, 3);
   result += "\t\040\040\040" + to_string_with_precision<double>(s, 3);
   result += "\t" + to_string_with_precision<double>(x, 3);
   result += "\t" + to_string_with_precision<double>(fdot, 3);
   result += "\t" + to_string_with_precision<double>(mdot, 3);
   return result;
}