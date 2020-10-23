within RankineCycle;
model RankineCycle85
  Components.Boiler_ph boiler_ph(
    t_out=480.00,
    p_out=8.0,
    x_flow_out=1)
    annotation (Placement(transformation(extent={{-82,18},{-62,38}})));
  Components.TurbineEX1_ph turbineEX1_ph(
    p_out=0.008,
    p_ex=0.7,
    ef=85) annotation (Placement(transformation(extent={{-20,40},{12,80}})));
  Components.Pump_ph pump_ph_fw(p_out=8, ef=100)
    annotation (Placement(transformation(extent={{-58,-44},{-38,-24}})));
  Components.OpenedheaterDw0_ph openedheaterDw0_ph(x_out=0, p_out=0.7)
    annotation (Placement(transformation(extent={{-26,-52},{10,-16}})));
  Components.Condenser_ph condenser_ph(p_out=0.008, x_out=0)
    annotation (Placement(transformation(extent={{74,-4},{94,16}})));
  Components.Pump_ph pump_ph_cd(p_out=0.7, ef=100)
    annotation (Placement(transformation(extent={{34,-44},{54,-24}})));

  Units.WorkUnitMass totalworkExtracted,totalworkRequired,netpoweroutput;
  Units.HeatUnitMass totalheatAdded;
  Units.Efficiency  efficiency;
  Units.HeatRate HeatRate;
  Units.SteamRate SteamRate;
equation
  totalworkExtracted=turbineEX1_ph.w;
  totalworkRequired=pump_ph_fw.w+pump_ph_cd.w;
  netpoweroutput = totalworkExtracted -totalworkRequired;
  totalheatAdded=boiler_ph.q;
  efficiency = (netpoweroutput / totalheatAdded)*100;
  HeatRate = 3600.0 /(efficiency*0.01);
  SteamRate = HeatRate / totalheatAdded;
  connect(boiler_ph.outlet, turbineEX1_ph.inlet) annotation (Line(
      points={{-71.6,37.2},{-72,37.2},{-72,77.4},{-17.4,77.4}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(boiler_ph.inlet, pump_ph_fw.outlet) annotation (Line(
      points={{-72,19},{-72,-34},{-57,-34}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(pump_ph_fw.inlet, openedheaterDw0_ph.outletFW) annotation (Line(
      points={{-38.6,-33.8},{-24,-33.8},{-24,-34.18},{-23.66,-34.18}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(turbineEX1_ph.exlet, openedheaterDw0_ph.inletSM) annotation (Line(
      points={{-7.6,46.4},{-8,46.4},{-8,-19.96}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(turbineEX1_ph.outlet, condenser_ph.inlet) annotation (Line(
      points={{6.6,44.6},{80,44.6},{80,15.3},{81.1,15.3}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(openedheaterDw0_ph.inletFW, pump_ph_cd.outlet) annotation (Line(
      points={{8.02,-33.82},{20,-33.82},{20,-34},{35,-34}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(pump_ph_cd.inlet, condenser_ph.outlet) annotation (Line(
      points={{53.4,-33.8},{81.9,-33.8},{81.9,-1.1}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(extent={{-92,62},{94,-64}}, lineColor={28,108,200}), Text(
          extent={{-38,-16},{36,8}},
          lineColor={28,108,200},
          textString="Rankine85")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RankineCycle85;
