within RankineCycle;
model RankineCycle82 "The Simple Rankine Cycle"
  parameter Units.Pressure boiler_ouelet_p=8;
  // Variables
 Boiler_ph boiler(
    x_out=1,
    p_out=boiler_ouelet_p,
    x_flow_out=1)
    annotation (Placement(transformation(extent={{-94,14},{-52,56}})));
     Turbine_ph turbine_ph(p_out=0.008, ef=85)
    annotation (Placement(transformation(extent={{34,30},{78,84}})));
  Pump_ph pump_ph(p_out=8, ef=85)
    annotation (Placement(transformation(extent={{-60,-88},{-40,-68}})));

  Condenser_ph condenser_ph(p_out=0.008, x_out=0.0)
    annotation (Placement(transformation(extent={{56,-48},{98,-6}})));
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
      points={{70.575,36.21},{70,36.21},{70,-7.47},{70.91,-7.47}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(pump_ph.inlet, condenser_ph.outlet) annotation (Line(
      points={{-40.6,-77.8},{72,-77.8},{72,-41.91},{72.59,-41.91}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(turbine_ph.inlet, boiler.outlet) annotation (Line(
      points={{37.575,80.49},{-72,80.49},{-72,54},{-72.16,54},{-72.16,54.32}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(pump_ph.outlet, boiler.inlet) annotation (Line(
      points={{-59,-78},{-73,-78},{-73,16.1}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  annotation (
    Dialog(group = "Global parameter"),
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Rectangle(lineColor = {28, 108, 200}, extent = {{-70, 66}, {76, -32}}), Text(lineColor = {28, 108, 200}, extent = {{-30, 32}, {36, 4}}, textString = "Rankine Cycle", fontSize = 16, textStyle = {TextStyle.Bold})}),
    Diagram(coordinateSystem(initialScale = 0.1)));
end RankineCycle82;
