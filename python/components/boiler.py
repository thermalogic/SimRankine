"""
 General Object-oriented Abstraction   

  class Boiler

                    ↑    oPort[0]. main steam
                ┌───┼───┐ 
                │   │   │   
                │   │   │
                │   │   │
                └───┼───┘  
                    ↑    iPort[0]. main feedwater
                          
 json object example:

        {    
            "name": "Boiler",  
            "devtype": "BOILER",
            "iPort": {"p": 8.0, "t": None,  "x": None, "fdot": None},
            "oPort": {"p": 8.0, "t": None,  "x": 1.0, "fdot": 1.0}
        }

 Author:Cheng Maohua  Email: cmh@seu.edu.cn 

"""

from .port import *


class Boiler:

    energy = "heatAdded"
    devtype = "BOILER"

    def __init__(self, dictDev):
        """
        Initializes the boiler
        """
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
        """ mass and energy balance of the boiler """
        # mass blance equation
        if self.iPort[0].fdot is not None:
            self.oPort[0].fdot = self.iPort[0].fdot
        elif self.oPort[0].fdot is not None:
            self.iPort[0].fdot = self.oPort[0].fdot

        self.heatAdded = self.iPort[0].fdot * (self.oPort[0].h - self.iPort[0].h)

    def sm_energy(self):
        self.QAdded = self.iPort[0].mdot * \
            (self.oPort[0].h - self.iPort[0].h)
        self.QAdded /= (3600.0 * 1000.0)

    def __str__(self):
        result = '\n' + self.name
        result += '\n' + " PORTS " + Port.title
        result += '\n' + " iPort " + self.iPort[0].__str__()
        result += '\n' + " oPort " + self.oPort[0].__str__()
        result += '\nheatAdded(kJ/kg) \t{:>.2f}'.format(self.heatAdded)
        result += '\nQAdded(MW) \t{:>.2f}'.format(self.QAdded)
        return result
