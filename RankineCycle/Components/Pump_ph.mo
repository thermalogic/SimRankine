within RankineCycle.Components;
model Pump_ph
  import Modelica.Media.Water.IF97_Utilities.h_ps;
  import Modelica.Media.Water.IF97_Utilities.s_ph;
  import Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.sl_p;
  parameter Units.Pressure p_out;
  parameter Units.Efficiency ef;
  Units.WorkUnitMass w;
  Real outlet_s,outlet_h_s;
  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(
          extent={{-86,-8},{-70,8}}),    iconTransformation(extent={{-86,-8},{
            -70,8}})));
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(
          extent={{72,-8},{88,8}}),   iconTransformation(extent={{72,-8},{88,8}})));
equation
  outlet.p=p_out;
  outlet.x_flow=inlet.x_flow;

  outlet_s =s_ph(inlet.p*1.0e6, inlet.h*1.0e3)*1.0e-3;
  outlet_h_s =h_ps(outlet.p*1.0e6, outlet_s*1.0e3)*1.0e-3;
  outlet.h = inlet.h + (outlet_h_s - inlet.h)/(ef*0.01);
  w=inlet.x_flow * ( outlet.h - inlet.h);

  annotation (Icon(coordinateSystem(initialScale=0.1), graphics={
        Ellipse(
          origin={28,-32},
          lineColor={0,131,169},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,100},{46,-40}},
          endAngle=360),
        Line(
          origin={7.3121,-0.25478},
          points={{-78,0},{82.6879,0.25478}},
          color={0,140,72},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          origin={35.2228,1.78344},
          rotation=180,
          points={{60,40},{106,2},{58,-42}},
          color={0,131,169})}), Diagram(coordinateSystem(preserveAspectRatio=
            true, extent={{-100,-100},{100,100}})));
end Pump_ph;
