within RankineCycle;
model Boiler_ph "Boiler of Rankine Cycle"
  import Modelica.Media.Water.IF97_Utilities.hv_p;

  parameter Units.Dry x_out;
  parameter Units.Pressure p_out;
  parameter Units.Pressure x_flow_out;

  Units.HeatUnitMass q;
  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(
          extent={{-6,82},{14,102}}), iconTransformation(extent={{-6,82},{14,102}})));
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(
          extent={{-10,-100},{10,-80}}), iconTransformation(extent={{-10,-100},{
            10,-80}})));
equation
  outlet.p=p_out;
  // mass
  outlet.x_flow=x_flow_out;
  // heat
  outlet.h = hv_p(outlet.p*1.0e6)*1.0e-3;
  q= outlet.x_flow*(outlet.h - inlet.h);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(initialScale=0.1),
        graphics={
        Rectangle(
          origin={0,28},
          lineColor={0,131,169},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-96,24},{100,-100}}),
        Ellipse(
          origin={-2,24},
          lineColor={0,131,169},
          extent={{-40,10},{40,-70}},
          endAngle=360),
        Line(
          origin={-3.56688,21.8472},
          points={{-28,-2},{28,-58}},
          color={0,131,169}),
        Line(
          origin={1.31814e-06,22.7389},
          points={{-28,-58},{28,-2}},
          color={0,131,169}),
        Line(
          origin={0.44586,-2},
          points={{-0.44586,56},{-20,70},{20,70},{0,88}},
          color={0,131,169}),
        Polygon(points={{-64,-78},{-64,-78},{-64,-78},{-64,-78}}),
        Line(points={{0,-72},{0,-82}}, color={28,108,200})}));
end Boiler_ph;
