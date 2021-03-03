cycle = {}
cycle["type"] = "RANKINE"
cycle["name"] = "The Rankine85"
cycle["components"] = [
    {
        "name": "TurbineEx1",
        "devtype": "TURBINEEX1",
        "ef": 0.85,
        "iPort": {"p": None, "t": None,  "x": None, "fdot": None}, 
        "oPort": {"p": 0.008, "t": None,  "x": None, "fdot": None},
        "ePort": {"p": 0.7, "t": None,  "x": None, "fdot": None} 
    },
    {
        "name": "Condenser",
        "devtype": "CONDENSER",
        "iPort":  {"p": None, "t": None,  "x": None, "fdot": None},
        "oPort":  {"p": 0.008, "t": None,  "x": 0.0, "fdot": None}
    },
    {
        "name": "CondensatePump",
        "devtype": "PUMP",
        "ef": 1.00,
        "iPort":  {"p": None, "t": None,  "x": None, "fdot": None},
        "oPort":  {"p": 0.7, "t": None,  "x": 0.0, "fdot": None}
    },
    {
        "name": "OpenedFeedwaterHeater",
        "devtype": "OPENEDHEATERDW0",
        "iPort": {"p": None, "t": None,  "x": None, "fdot": None}, 
        "iPort_fw":  {"p": None, "t": None,  "x": None, "fdot": None}, 
        "oPort_fw":  {"p": 0.7, "t": None,  "x": 0.0, "fdot": None}
    },
    {
        "name": "FeedwaterPump",
        "devtype": "PUMP",
        "ef": 1.00,
        "iPort": {"p": None, "t": None,  "x": None, "fdot": None},
        "oPort":  {"p":8.0, "t": None,  "x": None, "fdot": None}
    },
    {
        "name": "Boiler",
        "devtype": "BOILER",
        "iPort":  {"p": None, "t": None,  "x": None, "fdot": None}, 
        "oPort":  {"p": 8.0, "t": 480.0,  "x": None, "fdot": 1.0}
    }
]

cycle["connectors"] = [
    (("Boiler", "oPort"), ("TurbineEx1", "iPort")),
    (("TurbineEx1", "ePort"), ("OpenedFeedwaterHeater", "iPort")),
    (("TurbineEx1", "oPort"), ("Condenser", "iPort")),
    (("Condenser", "oPort"), ("CondensatePump", "iPort")),
    (("CondensatePump", "oPort"), ("OpenedFeedwaterHeater", "iPort_fw")),
    (("OpenedFeedwaterHeater", "oPort_fw"), ("FeedwaterPump", "iPort")),
    (("FeedwaterPump", "oPort"), ("Boiler", "iPort"))]

