within RankineCycle.Components;
model Condenser_ph
  import Modelica.Media.Water.IF97_Utilities.hl_p;
  parameter Units.Pressure p_out;
  parameter Units.Dry x_out;
  Units.HeatUnitMass q;
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(extent=
           {{-42,80},{-22,100}}),iconTransformation(extent={{-36,86},{-22,100}})));
  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(
          extent={{-34,-84},{-14,-64}}),iconTransformation(extent={{-28,-78},{-14,
            -64}})));

equation
  outlet.x_flow =inlet.x_flow;
  outlet.p=p_out;
  if x_out==0 then
      outlet.h = hl_p(outlet.p*1.0e6)*1.0e-3;
  else
     outlet.h =-1000;
  end if;
  q=outlet.x_flow*(inlet.h-outlet.h);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(initialScale=
            0.1), graphics={
        Rectangle(
          origin={-36,32.8492},
          lineColor={0,131,169},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-62,49.1508},{76,-88.8492}}),
        Line(
          origin={-50.382,18.7006},
          points={{100,58},{-36,58},{38,-2},{-30,-62},{100,-62}},
          color={0,131,169}),
        Rectangle(
          visible=false,
          origin={2,24},
          lineColor={0,131,169},
          fillColor={0,131,169},
          fillPattern=FillPattern.Solid,
          extent={{-100,-80},{38,-96}}),
        Line(points={{-28,86},{-28,82},{-28,84}}, color={28,108,200}),
        Line(points={{-20,-56},{-20,-64}}, color={28,108,200})}));
end Condenser_ph;
