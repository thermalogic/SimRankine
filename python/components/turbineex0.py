"""
 General Object-oriented Abstraction of Rankine Cycle 

    TurbineEx0 class: 
       
        iNode inlet steam   
                 ┌────────┐
              ↓ ╱         │ 
               ┤          │
                ╲         │
                 └────────┤
                          ↓  oNode exhausted steam   
extracted steam  0    

json object example

    {
            "name": "Turbine1",
            "type": "TURBINE-EX0",
            "ef": 1.00,
            "iPort":,
            "oPort":
    },

  Author:Cheng Maohua  Email: cmh@seu.edu.cn

"""
from seuif97 import *
from .port import *


class TurbineEx0:

    energy = 'workExtracted'
    devtype = 'TURBINE-EX0'

    def __init__(self, dictDev):
        self.name = dictDev['name']
        self.iPort=[Port(dictDev['iPort'])]
        self.oPort=[Port(dictDev['oPort'])]
        self.ef = dictDev['ef']

        # map the name of port to the port obj
        self.portdict = {
            "iPort": self.iPort,
            "oPort": self.oPort
        }

       
        self.workExtracted=0
        self.WExtracted=0 
     

    def state(self):
        if self.ef == 1.0:
            self.oPort[0].s =self.iPort[0].s
            self.oPort[0].ps()
        else:
            isoh =ps2h(self.oPort[0].p, self.iPort[0].s)
            self.oPort[0].h = self.iPort[0].h -  self.ef * (self.iPort[0].h - isoh)
            self.oPort[0].ph()


    def balance(self):
        """ mass and energy balance of the TurbineEx0"""
        # mass balance equation
        self.oPort[0].fdot = self.iPort[0].fdot
        # energy
        self.workExtracted = self.iPort[0].fdot *(self.iPort[0].h - self.oPort[0].h)

    def sm_energy(self):
        # mdot，get WExtracted
        self.WExtracted = self.iPort[0].mdot * (self.iPort[0].h - self.oPort[0].h)
        self.WExtracted /= (3600.0 * 1000.0)

    def __str__(self):
        result = '\n' + self.name
        result += '\n' + " PORT " + Port.title
        result += '\n' + " iPort " + self.iPort[0].__str__()
        result += '\n' +" oPort "+ self.oPort[0].__str__()
        result += '\nworkExtracted(kJ/kg): \t{:>.2f}'.format(self.workExtracted)
        result += '\nWExtracted(MW): \t{:>.2f}'.format(self.WExtracted)    
        return result
  
   
