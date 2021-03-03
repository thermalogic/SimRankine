"""
 General Object-oriented Abstraction and JSON Textual Model of Rankine Cycle 

class Openedheaterdw0

                      ↓   inPort extracted steam
                  ┌───┴───┐
 feedwater        │       │
 outPort_fw     ← ┤       │← inPort_fw  feedwater
                  │       │
                  └───────┘

 json object example:

     {
            "name": "OpenedFeedwaterHeater1",
            "devtype": "FWH-OPEN-DW0",
            "iPort":i,
            "iPort_fw":j,
            "oPort_fw":k
     }

  Author:Cheng Maohua  Email: cmh@seu.edu.cn

"""
from .port import *

class OpenedheaterDw0:

    energy = 'internel'
    devtype = "FWH-OPEN-DW0"

    def __init__(self, dictDev):
        """
        Initializes the Opened feedwater with the conditions
        """
        self.name = dictDev['name']
        self.iPort = [Port(dictDev['iPort'])]
        self.iPort_fw = [Port(dictDev['iPort_fw'])]
        self.oPort_fw = [Port(dictDev['oPort_fw'])]

        # map the name of port to the port obj
        self.portdict = {
            "iPort": self.iPort,
            "iPort_fw": self.iPort_fw, 
            "oPort_fw": self.oPort_fw
        }

        self.heatAdded = 0
        self.heatExtracted = 0
        self.QExtracted = 0

    def state(self):
        pass

    def balance(self):
        """ mass and energy balance of the opened feedwater heater """
        # energy balance equation
        qes1 = self.iPort[0].h - self.oPort_fw[0].h
        qfw1 = self.oPort_fw[0].h - self.iPort_fw[0].h
        self.iPort[0].fdot = self.oPort_fw[0].fdot * qfw1/(qes1 + qfw1)
        # mass balance equation
        self.iPort_fw[0].fdot = self.oPort_fw[0].fdot - self.iPort[0].fdot

        self.heatAdded = self.iPort_fw[0].fdot * qfw1
        self.heatExtracted = self.iPort[0].fdot * qes1

    def sm_energy(self):
        ucovt = 3600.0 * 1000.0
        self.QExtracted = self.iPort[0].mdot * \
            (self.iPort[0].h - self.oPort_fw[0].h)/ucovt
        self.QAdded = self.iPort_fw[0].mdot * \
            (self.oPort_fw[0].h - self.iPort_fw[0].h)/ucovt

    def __str__(self):
        result = '\n' + self.name
        result += '\n' + " PORT " + Port.title
        result += '\n'+" iPort " + self.iPort[0].__str__()
        result += '\n'+" iPort_fw " + self.iPort_fw[0].__str__()
        result += '\n' +" oPort_fw "+ self.oPort_fw[0].__str__()

        result += '\nheatAdded(kJ/kg) \t{:>.2f}'.format(self.heatAdded)
        result += '\nheatExtracted(kJ/kg) \t{:>.2f}'.format(self.heatExtracted)
        result += '\nQAdded(MW) \t{:>.2f}'.format(self.QAdded)
        result += '\nQExtracted(MW)  \t{:>.2f}'.format(self.QExtracted)
        return result
