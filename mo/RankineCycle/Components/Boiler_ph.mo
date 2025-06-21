within RankineCycle.Components;
model Boiler_ph "Boiler of Rankine Cycle"
  import Modelica.Media.Water.IF97_Utilities.hv_p;
  import Modelica.Media.Water.IF97_Utilities.h_pT;
  parameter Units.Dryness x_out;
  parameter Units.Temperature_DegC t_out;
  parameter Units.Pressure p_out;
  parameter Units.MassFraction x_flow_out;

  Units.HeatUnitMass q;
  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(
          extent={{-10,82},{10,102}}),iconTransformation(extent={{-10,82},{10,
            102}})));
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(
          extent={{-8,-82},{12,-62}}),   iconTransformation(extent={{-8,-82},{
            12,-62}})));
equation
  outlet.p=p_out;
  // mass
  outlet.x_flow=x_flow_out;
  // heat
  if x_out==1 then
    outlet.h = hv_p(outlet.p*1.0e6)*1.0e-3;
  else
    outlet.h = h_pT(outlet.p*1.0e6,t_out+273.15)*1.0e-3;
  end if;
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
          points={{-0.44586,54},{-20,70},{20,70},{-0.44586,86}},
          color={238,46,47},
          arrow={Arrow.None,Arrow.Filled}),
        Polygon(points={{-64,-78},{-64,-78},{-64,-78},{-64,-78}})}));
end Boiler_ph;
