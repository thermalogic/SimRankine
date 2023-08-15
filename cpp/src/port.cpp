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
      pt_prop();
   }
   else
   {
      if (!isnan(t) & !isnan(x))
      {
         tx_prop();
      }
      else
      {
         if (!isnan(p) & !isnan(x))
         {
            px_prop();
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

void Port::pt_prop()
{
   h =  pt(p, t, 4);
   s =  pt(p, t, 5);
   x =  pt(p, t, 15);
}

void Port::tx_prop()
{
   p =  tx(t, x, 0);
   h =  tx(t, x, 4);
   s =  tx(t, x, 5);
}

void Port::px_prop()
{
   t =  px(p, x, 1);
   h =  px(p, x, 4);
   s =  px(p, x, 5);
}

void Port::ps_prop()
{
   t =  ps(p, s, 1);
   h =  ps(p, s, 4);
   x =  ps(p, s, 15);
}

void Port::ph_prop()
{
   t =  ph(p, h, 1);
   s =  ph(p, h, 5);
   x =  ph(p, s, 15);
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