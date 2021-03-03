"""
 General Object-oriented Abstraction of Rankine Cycle 

"""

import time
from platform import os
import getpass

from components.port import Port
from components.connector import Connector
from components import compdict

class RankineCycle:

    def __init__(self, dictcycle):
        """
          dictcycle={"type":typestring,
                     "name":namestring,
                     "components":[{component1},{component2},...],
                     "connectors":[((name1,port1),(name2,port2)),...]
                  }
          TO:     
             self.comps : dict of all component objects      
             self.curcon : the connector object
        """
        self.type = dictcycle["type"]
        self.name = dictcycle["name"]
        dictcomps = dictcycle["components"]
        listconnectors = dictcycle["connectors"]

        # 1 convert dict to the dict of device objects: {device name:device obiect}
        self.DevNum = len(dictcomps)
        self.comps = {}
        for curdev in dictcomps:
            self.comps[curdev['name']] = compdict[curdev['devtype']](curdev)

        self.curcon=Connector()
        # 2 use the dictconnectors to set the nodes value and alias between the item of nodes and the port of devices
        for tupconnector in listconnectors:
            self.curcon.AddConnector(tupconnector, self.comps)

        self.totalworkExtracted = 0
        self.totalworkRequired = 0
        self.totalheatAdded = 0

        self.netpoweroutput = 0
        self.efficiency = 100.0
        self.HeatRate = 0.0
        self.SteamRate = 0.0

        self.mdot = None
        self.Wcycledot = None

        self.totalWExtracted = 0
        self.totalWRequired = 0
        self.totalQAdded = 0

    def ComponentState(self):
        """ calculate the state of ports """
        # the ports state oof devices
        for key in self.comps:
            self.comps[key].state()

       
    def ComponentBalance(self):
        keys = list(self.comps.keys())
        deviceok = False

        i = 0  # i: the count of deviceok to avoid endless loop
        while (deviceok == False and i <= self.DevNum):

            for curdev in keys:
                try:
                    self.comps[curdev].balance()
                    keys.remove(curdev)
                except:
                    pass

            i += 1
            if (len(keys) == 0):
                deviceok = True

        # for debug: check the failed devices
        if (len(keys) > 0):
            print(keys)

    def simulator(self):
        self.ComponentState()
        self.ComponentBalance()
       
        self.totalworkExtracted = 0
        self.totalworkRequired = 0
        self.totalheatAdded = 0

        for key in self.comps:
            if self.comps[key].energy == "workExtracted":
                self.totalworkExtracted += self.comps[key].workExtracted
            elif self.comps[key].energy == "workRequired":
                self.totalworkRequired += self.comps[key].workRequired
            elif self.comps[key].energy == "heatAdded":
                self.totalheatAdded += self.comps[key].heatAdded

        self.netpoweroutput = self.totalworkExtracted - self.totalworkRequired
        self.efficiency = self.netpoweroutput / self.totalheatAdded
        self.HeatRate = 3600.0 / self.efficiency
        self.SteamRate = self.HeatRate / self.totalheatAdded

    def SpecifiedSimulator(self, SetPower=None, SetMass=None):
        if SetPower != None:
            self.Wcycledot = SetPower
            self.mdot = self.Wcycledot * self.SteamRate * 1000.0
        else:
            self.mdot = SetMass
            self.Wcycledot = self.mdot * \
                self.netpoweroutput / (1000.0 * 3600.0)

        for item in self.curcon.nodes:
            item[0].calmdot(self.mdot)

        self.totalWExtracted = 0
        self.totalWRequired = 0
        self.totalQAdded = 0
        for key in self.comps:
            self.comps[key].sm_energy()
            if self.comps[key].energy == "workExtracted":
                self.totalWExtracted += self.comps[key].WExtracted
            elif self.comps[key].energy == "workRequired":
                self.totalWRequired += self.comps[key].WRequired
            elif self.comps[key].energy == "heatAdded":
                self.totalQAdded += self.comps[key].QAdded

    def __setformatstr(self, formatstr, result):
        result += formatstr.format('Net Power(MW)', self.Wcycledot)
        result += formatstr.format('Mass Flow(kg/h)', self.mdot)
        result += formatstr.format('Cycle Efficiency(%)',
                                   self.efficiency*100.0)
        result += formatstr.format('Cycle Heat Rate(kJ/kWh)', self.HeatRate)
        result += formatstr.format('Steam Rate(kg/kWh)', self.SteamRate)
        result += formatstr.format('totalWExtracted(MW)', self.totalWExtracted)
        result += formatstr.format('totalWRequired(MW)', self.totalWRequired)
        result += formatstr.format('totalQAdded(MW)', self.totalQAdded)
        return result

    def __str__(self):
        str_curtime = time.strftime(
            "%Y/%m/%d %H:%M:%S", time.localtime(time.time()))
        result = "\n Rankine Cycle: {}, Time: {}\n".format(
            self.name, str_curtime)
        try:
            formatstr = "{:>20} {:>.2f}\n"
            result = self.__setformatstr(formatstr, result)
        except:
            formatstr = "{} {}\n"
            result = self.__setformatstr(formatstr, result)
        return result
