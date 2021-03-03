within RankineCycle;
model RankineCycle84 "Evaluating Performance of a Reheat Cycle with Turbine Irreversibility, P451"
  Components.Pump_ph pump_ph_fw(p_out=8, ef=100)
    annotation (Placement(transformation(extent={{-30,-24},{-10,-4}})));
  Components.Condenser_ph condenser_ph(p_out=0.008, x_out=0)
    annotation (Placement(transformation(extent={{50,4},{70,24}})));
  Components.BoilerReheat_ph boilerReheat_ph(
    t_out=480,
    p_out=8,
    x_flow_out=1,
    t_ouletRH=440,
    p_ouletRH=0.7)
    annotation (Placement(transformation(extent={{-68,24},{-48,44}})));
  Components.Turbine_ph turbine1(p_out=0.7, ef=85)
    annotation (Placement(transformation(extent={{-12,48},{4,68}})));
  Components.Turbine_ph turbine2(p_out=0.008, ef=85)
    annotation (Placement(transformation(extent={{16,46},{34,68}})));
  //_________________cycle_______________
  Units.WorkUnitMass totalworkExtracted,totalworkRequired,netpoweroutput;
  Units.HeatUnitMass totalheatAdded;
  Units.Efficiency  efficiency;
  Units.HeatRate HeatRate;
  Units.SteamRate SteamRate;

equation
  totalworkExtracted=turbine1.w+turbine2.w;
  totalworkRequired=pump_ph_fw.w;
  netpoweroutput = totalworkExtracted -totalworkRequired;
  totalheatAdded=boilerReheat_ph.q;
  efficiency = (netpoweroutput / totalheatAdded)*100;
  HeatRate = 3600.0 /(efficiency*0.01);
  SteamRate = HeatRate / totalheatAdded;
  connect(boilerReheat_ph.outlet, turbine1.inlet) annotation (Line(
      points={{-62,42.6},{-62,64.5},{-9.9,64.5}},
      color={238,46,47},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.None,Arrow.Filled}));
  connect(boilerReheat_ph.inletRH, turbine1.outlet) annotation (Line(
      points={{-53.7,26.9},{-53.7,14},{2.1,14},{2.1,51.7},{2.1,51.7}},
      color={238,46,47},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.Filled,Arrow.None}));
  connect(boilerReheat_ph.inlet, pump_ph_fw.outlet) annotation (Line(
      points={{-62.3,26.9},{-62.3,-14},{-27.8,-14}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.Filled,Arrow.None}));
  connect(condenser_ph.outlet, pump_ph_fw.inlet) annotation (Line(
      points={{60.1,7.9},{60.1,-14},{-12,-14}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.None,Arrow.Filled}));
  connect(condenser_ph.inlet, turbine2.outlet) annotation (Line(
      points={{59.9,22.1},{59.9,50.07},{31.8625,50.07}},
      color={0,140,72},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.Filled,Arrow.None}));
  connect(boilerReheat_ph.outletRH, turbine2.inlet) annotation (Line(
      points={{-53.9,39.7},{-53.9,80},{18.3625,80},{18.3625,64.15}},
      color={238,46,47},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.None,Arrow.Filled}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = false), graphics={Rectangle(origin = {2, 26},lineColor = {28, 108, 200}, extent = {{-92, 62}, {94, -64}}), Text(origin = {30, 58},lineColor = {255, 0, 0}, extent = {{-106, -84}, {36, 8}}, textString = "Rankine85", textStyle = {TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold, TextStyle.Bold})}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Line(
          points={{-16,58},{40,58}},
          color={0,0,0},
          thickness=0.5)}),
    Documentation);
end RankineCycle84;
