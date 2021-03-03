"""
General Object-oriented Abstraction  of Rankine Cycle 

    TurbineEx1 class: 
       
        iPort inlet steam   
                 ┌────────┐
              ↓ ╱         │ 
               ┤          │
                ╲         │
                 └──┬─────┤
          ePort     ↓     ↓  oPort exhausted steam  
extracted steam     1    
  

json object example

     {
            "name": "Turbine1",
            "type": "TURBINEEX1",
            "ef": 0.85,
            "iPort":,
            "oPort": j,
            "ePort": k
      } 

 Author:Cheng Maohua  Email: cmh@seu.edu.cn

"""
from seuif97 import *
from .port import *


class TurbineEx1:

    energy = 'workExtracted'
    devtype = 'TURBINEEX1'

    def __init__(self, dictDev):
        self.name = dictDev['name']
        self.iPort = [Port(dictDev['iPort'])]
        self.oPort = [Port(dictDev['oPort'])]
        self.ePort = [Port(dictDev['ePort'])]

        self.ef = dictDev['ef']

        # map the name of port to the port obj
        self.portdict = {
            "iPort": self.iPort,
            "oPort": self.oPort,
            "ePort": self.ePort
        }

        self.workExtracted = 0
        self.WExtracted = 0

    def state(self):
        if self.ef == 1.0:
            self.ePort[0].s = self.iPort[0].s
            self.ePort[0].ps()
            self.oPort[0].s = self.iPort[0].s
            self.oPort[0].ps()
        else:
            isoh = ps2h(self.ePort[0].p, self.iPort[0].s)
            self.ePort[0].h = self.iPort[0].h - \
                self.ef * (self.iPort[0].h - isoh)
            self.ePort[0].ph()
            isoh = ps2h(self.oPort[0].p, self.ePort[0].s)
            self.oPort[0].h = self.ePort[0].h - \
                self.ef * (self.ePort[0].h - isoh)
            self.oPort[0].ph()

    def balance(self):
        """ mass and energy balance of the TurbineEx1
            work=ienergy - oenergy
        """
        self.oPort[0].fdot = self.iPort[0].fdot - self.ePort[0].fdot

        ienergy = self.iPort[0].fdot * self.iPort[0].h
        oenergy = self.ePort[0].fdot*self.ePort[0].h + \
            self.oPort[0].fdot*self.oPort[0].h
        self.workExtracted = ienergy - oenergy

    def sm_energy(self):
        """ mdot，get WExtracted """
        ienergy = self.iPort[0].mdot * self.iPort[0].h
        oenergy = self.ePort[0].mdot*self.ePort[0].h + \
            self.oPort[0].mdot*self.oPort[0].h
        self.WExtracted = ienergy - oenergy
        self.WExtracted /= (3600.0 * 1000.0)

    def __str__(self):
        result = '\n' + self.name
        result += '\n' + " PORT " + Port.title
        result += '\n' + " iPort " + self.iPort[0].__str__()
        result += '\n' + " oPort " + self.oPort[0].__str__()
        result += '\n' + " ePprt " + self.ePort[0].__str__()
        result += '\nworkExtracted(kJ/kg): \t{:>.2f}'.format(
            self.workExtracted)
        result += '\nWExtracted(MW): \t{:>.2f}'.format(self.WExtracted)
        return result
