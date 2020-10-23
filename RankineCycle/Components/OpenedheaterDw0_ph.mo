within RankineCycle.Components;
model OpenedheaterDw0_ph
  import Modelica.Media.Water.IF97_Utilities.hl_p;
  parameter Units.Dry x_out;
  parameter Units.Pressure p_out;
  Units.HeatUnitMass heatAdded,heatExtracted;
  Units.SpecificEnthalpy qes1,qfw1;
  FluidPort.FluidPortInPH inletFW annotation (Placement(transformation(extent={{76,-12},
            {96,8}}),            iconTransformation(extent={{82,-6},{96,8}})));
  FluidPort.FluidPortOutPH outletFW annotation (Placement(transformation(
          extent={{-100,-14},{-80,6}}), iconTransformation(extent={{-94,-8},{
            -80,6}})));

  FluidPort.FluidPortInPH inletSM annotation (Placement(transformation(
          extent={{-10,68},{10,88}}), iconTransformation(extent={{-10,68},{10,
            88}})));
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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(initialScale=
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
        Line(points={{58,0},{80,0}}, color={0,140,72}),
        Line(points={{0,68},{0,54}}, color={238,46,47})}));
end OpenedheaterDw0_ph;