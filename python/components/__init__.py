"""
    Components Package  
"""

from .port import Port
from .connector import Connector
from .boiler import Boiler
from .turbineex0 import TurbineEx0
from .turbineex1 import TurbineEx1
from .condenser import Condenser
from .openedheaterdw0 import OpenedheaterDw0
from .pump import Pump


# ------------------------------------------------------------------------------
# compdict(jump table)
#  1: key:value-> Type String: class  name
#  2    add the new key:value to the dict after you add the new device class/type
# --------------------------------------------------------------------------------

compdict = {
    "BOILER": Boiler,
    "CONDENSER": Condenser,
    "PUMP": Pump,
    "TURBINEEX0": TurbineEx0,
    "TURBINEEX1": TurbineEx1,
    "OPENEDHEATERDW0": OpenedheaterDw0
}
