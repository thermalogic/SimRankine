
"""
 General Object-oriented Abstraction of Rankine Cycle 

    class Pump

                   ┌───────┐
                   │       │
    oPort        ← ┼───────┼← iPort
                   │       │  
                   └───────┘  
 
  json object example:
     {
            "name": "Feedwater Pump1",
            "devtype": "PUMP",
            "ef": 1.00,
            "iPort": {"p": 8.0, "t": None,  "x": None, "fdot": None},
            "oPort": {"p": 8.0, "t": None,  "x": 1.0, "fdot": 1.0}
        
        }

  Author:Cheng Maohua  Email: cmh@seu.edu.cn               

"""
from seuif97 import ps2h
from .port import *


class Pump():

    energy = "workRequired"
    devtype = "PUMP"

    def __init__(self, dictDev):
        """
        Initializes the pump with the conditions
        """
        self.name = dictDev['name']
        self.ef = dictDev['ef']
        self.iPort = [Port(dictDev['iPort'])]
        self.oPort = [Port(dictDev['oPort'])]

        # map the name of port to the port obj
        self.portdict = {
            "iPort": self.iPort,
            "oPort": self.oPort
        }

    def state(self):
        """
        calc oPort[0] of the pump 
        """
        sout_s = self.iPort[0].s
        hout_s = ps2h(self.oPort[0].p, sout_s)
        self.oPort[0].h = self.iPort[0].h + (hout_s - self.iPort[0].h)/self.ef
        self.oPort[0].ph()

    def balance(self):
        """  mass and energy balance the pump    """
        # mass balance
        if self.iPort[0].fdot is not None:
            self.oPort[0].fdot = self.iPort[0].fdot
        elif self.oPort[0].fdot is not None:
            self.iPort[0].fdot = self.oPort[0].fdot

        # energy
        self.workRequired = self.iPort[0].fdot * (self.oPort[0].h - self.iPort[0].h)

    def sm_energy(self):
        self.WRequired = self.iPort[0].mdot * \
            (self.oPort[0].h - self.iPort[0].h)/(3600.0 * 1000.0)

    def __str__(self):
        result = '\n' + self.name
        result += '\n' + " PORT " +Port.title
        result += '\n'+" iPort " + self.iPort[0].__str__()
        result += '\n'+" oPort " + self.oPort[0].__str__()

        result += '\nworkRequired(kJ/kg): \t{:>.2f}'.format(self.workRequired)
        result += '\nWRequired(MW): \t{:>.2f}'.format(self.WRequired)
        return result
