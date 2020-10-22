within RankineCycle;
model Turbine_ph "Turbine"
  import Modelica.Media.Water.IF97_Utilities.h_ps;
  import Modelica.Media.Water.IF97_Utilities.s_ph;
  parameter Units.Pressure p_out;
  parameter Units.Efficiency ef;
  Units.SpecificEntropy inlet_s;
  Units.WorkUnitMass w "worker";
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(extent={{-78,
            80},{-58,100}}), iconTransformation(extent={{-74,80},{-60,94}})));
  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(extent={{-52,
            -76},{-32,-56}}), iconTransformation(extent={{46,-84},{60,-70}})));
equation
  outlet.x_flow=inlet.x_flow;
  inlet_s=s_ph(inlet.p*1.0e6,inlet.h*1.0e3)*1.0e-3;
  outlet.p=p_out;
  if ef==100 then
    outlet.h= h_ps(outlet.p*1.0e6,inlet_s*1.0e3)*1.0e-3;
  else
    outlet.h = inlet.h - 0.01*ef * (inlet.h-h_ps(outlet.p*1.0e6,inlet_s*1.0e3)*1.0e-3);
  end if;
  w = outlet.x_flow*(inlet.h - outlet.h);
  annotation (
    Diagram(coordinateSystem(extent={{-80,-100},{80,100}})),
    Icon(coordinateSystem(extent={{-80,-100},{80,100}}), graphics={
        Polygon(
          origin={2,8},
          lineColor={0,131,169},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          points={{-70,52},{48,72},{50,-68},{-70,-38},{-70,52}}),
        Line(points={{-68,80},{-68,60}}, color={28,108,200}),
        Line(points={{52,-60},{52,-70}}, color={28,108,200})}),
    __OpenModelica_commandLineOptions="");
end Turbine_ph;
