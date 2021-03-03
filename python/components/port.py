"""
 The port of device
"""
import seuif97 as if97

class Port:

    title = ('{:^6} \t{:<8} \t{:>8} \t{:>10} \t{:>10} \t{:^10} \t{:^6} \t{:>10}'.format
             ("Index", "P(MPa)", "T(°C)", "H(kJ/kg)", "S(kJ/kg.K)",  "Quality", "FDOT","MDOT(kg/s)"))

    def __init__(self, dictnode):
        """ create the node object"""
        self.index = None
        try: 
           self.p =  float(dictnode['p'])
        except:  
           self.p=None  
        try:   
           self.t =  float(dictnode['t'])
        except:  
           self.t=None 
        try: 
           self.x = float(dictnode['x'])
        except:  
           self.x=None  

        try:
           self.fdot =  float(dictnode['fdot'])
        except:
           self.fdot = None

        self.h = None
        self.s = None
        self.v = None
        self.mdot = None

        if self.p is not None and self.t is not None:
            self.pt()
        elif self.p is not None and self.x is not None:
            self.px()
        elif self.t is not None and self.x is not None:
            self.tx()
    
    def calmdot(self, totalmass):
        self.mdot = totalmass * self.fdot


    def pt(self):
        self.h = if97.pt2h(self.p, self.t)
        self.s = if97.pt2s(self.p, self.t)
        self.v = if97.pt2v(self.p, self.t)
        self.x = if97.pt2x(self.p, self.t)

    def ph(self):
        self.t = if97.ph2t(self.p, self.h)
        self.s = if97.ph2s(self.p, self.h)
        self.v = if97.ph2v(self.p, self.h)
        self.x = if97.ph2x(self.p, self.h)

    def ps(self):
        self.t = if97.ps2t(self.p, self.s)
        self.h = if97.ps2h(self.p, self.s)
        self.v = if97.ps2v(self.p, self.s)
        self.x = if97.ps2x(self.p, self.s)

    def hs(self):
        self.t = if97.hs2t(self.h, self.s)
        self.p = if97.hs2p(self.h, self.s)
        self.v = if97.hs2v(self.h, self.s)
        self.x = if97.hs2x(self.h, self.s)

    def px(self):
        self.t = if97.px2t(self.p, self.x)
        self.h = if97.px2h(self.p, self.x)
        self.s = if97.px2s(self.p, self.x)
        self.v = if97.px2v(self.p, self.x)

    def tx(self):
        self.p = if97.tx2p(self.t, self.x)
        self.h = if97.tx2h(self.t, self.x)
        self.s = if97.tx2s(self.t, self.x)
        self.v = if97.tx2v(self.t, self.x)

   
    def __str__(self):
        result = '{:^6}'.format(self.index)
        OutStrs = [{"fstr": '\t{:>7.4}', 'prop': self.p, "sstr": '\t{:>7}'},
                   {"fstr": '\t{:>8.2f}', 'prop': self.t, "sstr": '\t{:>8}'},
                   {"fstr": '\t{:>10.2f}', 'prop': self.h, "sstr": '\t{:>10}'},
                   {"fstr": '\t{:>8.3f}',  'prop': self.s, "sstr": '\t{:>8}'},
                   {"fstr": '\t{:>10.4f}', 'prop': self.x, "sstr": '\t{:>10}'},
                   {"fstr": '\t\t{:>6.4f}',  'prop': self.fdot, "sstr": '\t{:>6}'},
                   {"fstr": '\t{:>8.2f}',  'prop': self.mdot, "sstr": '\t{:>8}'}
                   ]

        for item in OutStrs:
            try:
                result += item["fstr"].format(item["prop"])
            except:
                result += item["sstr"].format("")

        return result
