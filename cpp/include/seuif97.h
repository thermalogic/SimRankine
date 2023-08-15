/*
This is header file of SEUIF97 

License: this code is in the public domain

Author:   Cheng Maohua
Email:    cmh@seu.edu.cn

Last modified: 2016.4.20
*/

#ifndef SEUIF97_H
#define SEUIF97_H

#ifdef __cplusplus
extern "C" {
#endif

double pt(double p, double t, int o_id);
double ph(double p, double h, int o_id);
double ps(double p, double s, int o_id);
double pv(double p, double v, int o_id);

double th(double t, double h, int o_id);
double ts(double t, double s, int o_id);
double tv(double t, double v, int o_id);

double hs(double h, double s, int o_id);

double px(double p, double x, int o_id);
double tx(double t, double x, int o_id);
double hx(double h, double x, int o_id);
double sx(double s, double x, int o_id);


#ifdef __cplusplus
}
#endif

#endif
