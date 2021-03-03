
cycle = {}
cycle["type"] = "RANKINE"
cycle["name"] = "The Rankine82"
cycle["components"] = [
    {
        "name": "Boiler",
        "devtype": "BOILER",
        "iPort": {"p": None, "t": None,  "x": None, "fdot": None},
        "oPort": {"p": 8.0, "t": None,  "x": 1.0, "fdot": 1.0}
    },
    {
        "name": "TurbineEx0",
        "devtype": "TURBINEEX0",
        "ef": 0.85,
        "iPort":  {"p": None, "t": None,  "x": None, "fdot":None},
        "oPort":  {"p": 0.008, "t": None,  "x": None, "fdot": None}
    },
    {
        "name": "Condenser",
        "devtype": "CONDENSER",
        "iPort":  {"p": None, "t": None,  "x": None, "fdot": None}, 
        "oPort": {"p": 0.008, "t": None,  "x": 0.0, "fdot": None}
    },
    {
        "name": "FeedwaterPump",
        "devtype": "PUMP",
        "ef": 0.85,
        "iPort": {"p": None, "t": None,  "x": None, "fdot": None}, 
        "oPort": {"p": 8.0, "t": None,  "x": None, "fdot": None}
    }
]


cycle["connectors"] = [
    (("Boiler", "oPort"), ("TurbineEx0", "iPort")),
    (("TurbineEx0", "oPort"), ("Condenser", "iPort")),
    (("Condenser", "oPort"), ("FeedwaterPump", "iPort")),
    (("FeedwaterPump", "oPort"), ("Boiler", "iPort"))]

