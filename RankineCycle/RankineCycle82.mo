within RankineCycle;
model RankineCycle82 "Analyzing a Rankine Cycle with Irreversibilities, P444"
  parameter Units.Pressure boiler_ouelet_p=8;
  // Variables
 Components.Boiler_ph boiler(
    x_out=1,
    p_out=boiler_ouelet_p,
    x_flow_out=1)
    annotation (Placement(transformation(extent={{-94,14},{-52,56}})));
  Components.Turbine_ph turbine_ph(p_out=0.008, ef=85)
    annotation (Placement(transformation(extent={{22,28},{66,82}})));
  Components.Pump_ph pump_ph(p_out=8, ef=85)
    annotation (Placement(transformation(extent={{-42,-62},{-22,-42}})));

  Components.Condenser_ph condenser_ph(p_out=0.008, x_out=0.0)
    annotation (Placement(transformation(extent={{40,-32},{82,10}})));
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
      points={{60.775,37.99},{60.79,6.01}},
      color={238,46,47},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.None,Arrow.Filled}));
  connect(pump_ph.inlet, condenser_ph.outlet) annotation (Line(
      points={{-24,-52},{61.21,-52},{61.21,-23.81}},
      color={0,140,72},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.Filled,Arrow.None}));
  connect(turbine_ph.inlet, boiler.outlet) annotation (Line(
      points={{27.775,72.55},{27.775,86},{-73,86},{-73,54.32}},
      color={238,46,47},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.Filled,Arrow.None}));
  connect(pump_ph.outlet, boiler.inlet) annotation (Line(
      points={{-39.8,-52},{-72.58,-52},{-72.58,19.88}},
      color={0,140,72},
      pattern=LinePattern.Solid,
      thickness=0.5,
      arrow={Arrow.None,Arrow.Filled}));
  annotation (
    Dialog(group = "Global parameter"),
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Rectangle(lineColor = {28, 108, 200}, extent = {{-70, 66}, {76, -32}}), Text(lineColor = {28, 108, 200}, extent = {{-30, 32}, {36, 4}}, textString = "Rankine Cycle", fontSize = 16, textStyle = {TextStyle.Bold})}),
    Diagram(coordinateSystem(initialScale = 0.1)));
end RankineCycle82;
