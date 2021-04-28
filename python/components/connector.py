"""

class Connector

"""

from .port import *

class Connector:

    def __init__(self):
        self.nodes=[]
        self.index=0
       
    def combined_node_value(self, node,port):
        """ 
           the node is the connector of two ports ,so the node may get values from all of two ports
            the values is the union set of the not-none values within two ports 
        """
        for key in node[0].__dict__.keys():
            nodevalue = getattr(node[0], key)
            portvalue = getattr(port[0], key)
            if nodevalue is None and portvalue is not None:
               setattr(node[0], key, portvalue)


    def add_node(self, tupConnector,comps):
        comp0, port0 =tupConnector[0] 
        comp1, port1 =tupConnector[1]
        # 1 get the index of port in nodes
        comps[comp0].portdict[port0][0].index = self.index
        # 2 cerate the node with port0
        self.nodes.append(comps[comp0].portdict[port0])
        # 3 join port1 info into  nodes[self.index]
        self.combined_node_value(
            self.nodes[self.index], comps[comp1].portdict[port1])
        # 4 set port1 pointer to nodes[self.index][0] 
        comps[comp1].portdict[port1][0] =self.nodes[self.index][0]

        self.index += 1
