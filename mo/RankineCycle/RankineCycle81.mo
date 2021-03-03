within RankineCycle;
model RankineCycle81 "Example 8.1: Analyzing an Ideal Rankine Cycle, P438"
  parameter Units.Pressure boiler_ouelet_p=8;
  // Variables
 Components.Boiler_ph boiler(
    x_out=1,
    p_out=boiler_ouelet_p,
    x_flow_out=1)
    annotation (Placement(transformation(extent={{-80,14},{-38,56}})));
 Components.Turbine_ph turbine_ph(p_out=0.008, ef=100)
    annotation (Placement(transformation(extent={{34,30},{78,84}})));
  Components.Pump_ph pump_ph(p_out=8, ef=100)
    annotation (Placement(transformation(extent={{-18,-58},{2,-38}})));

  Components.Condenser_ph condenser_ph(p_out=0.008, x_out=0.0)
    annotation (Placement(transformation(extent={{52,-26},{94,16}})));
  Units.WorkUnitMass totalworkExtracted,totalworkRequired,netpoweroutput;
  Units.HeatUnitMass totalheatAdded;
  Units.Efficiency  efficiency;
  Units.HeatRate HeatRate;
  Units.SteamRate SteamRate;
equation
  totalworkExtracted=turbine_ph.w;
  totalworkRequired=pump_ph.w;
  netpoweroutput = totalworkExtracted -totalworkRequired;
  totalheatAdded=boiler.q;
  efficiency = (netpoweroutput / totalheatAdded)*100;
  HeatRate = 3600.0 /(efficiency*0.01);
  SteamRate = HeatRate / totalheatAdded;
  connect(turbine_ph.outlet, condenser_ph.inlet) annotation (Line(
      points={{72.775,39.99},{72.79,12.01}},
      color={238,46,47},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.None,Arrow.Filled}));
  connect(pump_ph.inlet, condenser_ph.outlet) annotation (Line(
      points={{0,-48},{73.21,-48},{73.21,-17.81}},
      color={0,140,72},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.Filled,Arrow.None}));
  connect(turbine_ph.inlet, boiler.outlet) annotation (Line(
      points={{39.775,74.55},{39.775,86},{-59,86},{-59,54.32}},
      color={238,46,47},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.Filled,Arrow.None}));
  connect(pump_ph.outlet, boiler.inlet) annotation (Line(
      points={{-15.8,-48},{-58.58,-48},{-58.58,19.88}},
      color={0,140,72},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.None,Arrow.Filled}));
  annotation (
    Dialog(group = "Global parameter"),
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Rectangle(lineColor = {28, 108, 200}, extent = {{-70, 66}, {76, -32}}), Text(lineColor = {28, 108, 200}, extent = {{-30, 32}, {36, 4}}, textString = "Rankine Cycle", fontSize = 16, textStyle = {TextStyle.Bold})}),
    Diagram(coordinateSystem(initialScale = 0.1)));
end RankineCycle81;
