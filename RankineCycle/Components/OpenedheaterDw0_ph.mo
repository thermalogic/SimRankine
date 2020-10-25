within RankineCycle.Components;
model OpenedheaterDw0_ph
  import Modelica.Media.Water.IF97_Utilities.hl_p;
  parameter Units.Dryness x_out;
  parameter Units.Pressure p_out;
  Units.HeatUnitMass heatAdded,heatExtracted;
  Units.SpecificEnthalpy qes1,qfw1;
  FluidPort.FluidPortInPH inletFW annotation (Placement(transformation(extent={{74,-14},
            {94,6}}),            iconTransformation(extent={{80,-8},{94,6}})));
  FluidPort.FluidPortOutPH outletFW annotation (Placement(transformation(
          extent={{-100,-14},{-80,6}}), iconTransformation(extent={{-94,-8},{
            -80,6}})));

  FluidPort.FluidPortInPH inletSM annotation (Placement(transformation(
          extent={{-8,68},{10,86}}),  iconTransformation(extent={{-8,68},{10,86}})));
equation
  outletFW.p=p_out;
  if x_out==0 then
    outletFW.h = hl_p(outletFW.p*1.0e6)*1.0e-3;
  else
    outletFW.h =-1000;
  end if;
  // energy balance equation
  qes1 = inletSM.h - outletFW.h;
  qfw1 = outletFW.h -inletFW.h;
  inletSM.x_flow = outletFW.x_flow * qfw1/(qes1 + qfw1);
  // mass balance equation
  inletFW.x_flow = outletFW.x_flow - inletSM.x_flow;

  heatAdded =inletFW.x_flow * qfw1;
  heatExtracted = inletSM.x_flow * qes1;
  connect(inletFW, inletFW) annotation (Line(
      points={{84,-4},{84,-4}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(initialScale=
            0.1), graphics={
        Rectangle(
          origin={-6.08683,20.5198},
          lineColor={0,131,169},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-53.9132,33.4802},{66.0868,-60.5198}}),
        Rectangle(
          visible=false,
          origin={2,24},
          lineColor={0,131,169},
          fillColor={0,131,169},
          fillPattern=FillPattern.Solid,
          extent={{-100,-80},{38,-96}}),
        Line(points={{0,72},{0,76},{0,86}},       color={28,108,200}),
        Line(points={{-80,0},{-58,0}}, color={0,140,72}),
        Line(points={{60,0},{80,0}}, color={0,140,72}),
        Line(points={{0,68},{0,54}}, color={238,46,47})}));
end OpenedheaterDw0_ph;
