within RankineCycle.Components;
model Condenser_ph
  import Modelica.Media.Water.IF97_Utilities.hl_p;
  parameter Units.Pressure p_out;
  parameter Units.Dryness x_out;
  Units.HeatUnitMass q;
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(extent={{-14,68},
            {6,88}}),            iconTransformation(extent={{-8,74},{6,88}})));
  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(
          extent={{-12,-74},{8,-54}}),  iconTransformation(extent={{-6,-68},{8,
            -54}})));

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
          origin={-8.11541,30.1369},
          lineColor={0,131,169},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-71.8846,49.8631},{88.1154,-90.1369}}),
        Line(
          origin={-34.382,0.7006},
          points={{128.382,57.2994},{-36,58},{36.382,5.2994},{-33.618,-42.7006},
              {124.382,-42.7006}},
          color={0,140,72}),
        Rectangle(
          visible=false,
          origin={2,24},
          lineColor={0,131,169},
          fillColor={0,131,169},
          fillPattern=FillPattern.Solid,
          extent={{-100,-80},{38,-96}})}));
end Condenser_ph;
