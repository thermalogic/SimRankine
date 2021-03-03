
"""
General Object-oriented Abstraction  of Rankine Cycle 

The Simulator of Rankine Cycle 
  * Input :Rankine cycle dict model
  * Output: text file
Run: 
   python rankineapp.py
"""
from rankine.rankineobj import RankineCycle
from rankine.utils import OutFiles
from rankinemodel import cycles
from platform import os


class SimRankineCycle:
    """ Input :rankine dict"""

    def __init__(self, rankinecycle):
        self.idictcycle = rankinecycle
        self.cycle = RankineCycle(self.idictcycle)
        curpath = os.path.abspath(os.path.dirname(__file__))
        self.prefixResultFileName = curpath+'\\' + \
            './result/'+self.idictcycle['name']

    def Simulator(self):
        self.cycle.simulator()

    def SpecifiedSimulator(self, SetPower=None, SetMass=None):
        # Specified Simulating： Power or Mass Flow
        self.cycle.SpecifiedSimulator(SetPower, SetMass)

        # output to files
        if SetPower != None:
            outprefix = self.prefixResultFileName + '-sp'
        else:
            outprefix = self.prefixResultFileName + '-sm'
        # output to text
        OutFiles(self.cycle)
        OutFiles(self.cycle, outprefix + '.txt')


if __name__ == "__main__":
    Wcycledot = 100  # MW
    mdot = 150*3600  # kg/h

    for curcycle in cycles:
        cycle = SimRankineCycle(curcycle.cycle)
        # 1 1kg
        cycle.Simulator()

        # 2 Specified Net Output Power(MW)
        cycle.SpecifiedSimulator(SetPower=Wcycledot)

        # 3 Specified Mass Flow(kg/h)
        cycle.SpecifiedSimulator(SetMass=mdot)
