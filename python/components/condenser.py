
"""
 General Object-oriented Abstraction of Rankine Cycle

  class  Condenser

                    ↓   iPort exhausted steam
                ┌───┴───┐  
                │       │
                │       │
                │       │
                └───┬───┘
                    ↓ oPort condensate water
                           
json object example:

   {
            "name": "Condenser1",
            "devtype": "CONDENSER",
            "iPort[0]": i,
            "oPort[0]": j
   },

   Author:Cheng Maohua  Email: cmh@seu.edu.cn
"""

from .port import *


class Condenser:

    energy = "heatExtracted"
    devtype = "CONDENSER"

    def __init__(self, dictDev):
        """ Initializes the condenser """
        self.name = dictDev['name']
        self.iPort = [Port(dictDev['iPort'])]
        self.oPort = [Port(dictDev['oPort'])]
        # map the name of port to the port obj
        self.portdict = {
            "iPort": self.iPort,
            "oPort": self.oPort
        }

    def state(self):
        pass

    def balance(self):
        """ mass and energy balance of the condenser  """
        if self.iPort[0].fdot is not None:
            self.oPort[0].fdot = self.iPort[0].fdot
        elif self.oPort[0].fdot is not None:
            self.iPort[0].fdot = self.oPort[0].fdot

        self.heatExtracted = self.iPort[0].fdot * (self.iPort[0].h - self.oPort[0].h)

    def sm_energy(self):
        self.QExtracted = self.iPort[0].mdot * \
            (self.iPort[0].h - self.oPort[0].h)/(3600.0 * 1000.0)

    def __str__(self):
        result = '\n' + self.name
        result += '\n'+" PORTS " + Port.title
        result += '\n'+" iPort " + self.iPort[0].__str__()
        result += '\n'+" oPort " + self.oPort[0].__str__()
        result += '\nheatExtracted(kJ/kg)  \t{:>.2f}'.format(self.heatExtracted)
        result += '\nQExtracted(MW): \t{:>.2f}'.format(self.QExtracted)    
        return result

