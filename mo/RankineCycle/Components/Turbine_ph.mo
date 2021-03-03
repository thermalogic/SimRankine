within RankineCycle.Components;
model Turbine_ph "Turbine"
  import Modelica.Media.Water.IF97_Utilities.h_ps;
  import Modelica.Media.Water.IF97_Utilities.s_ph;
  parameter Units.Pressure p_out;
  parameter Units.Efficiency ef;
  Units.SpecificEntropy inlet_s;
  Units.WorkUnitMass w "worker";
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(extent={{-78,
            80},{-58,100}}), iconTransformation(extent={{-66,58},{-52,72}})));
  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(extent={{-52,
            -76},{-32,-56}}), iconTransformation(extent={{54,-70},{68,-56}})));
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
  connect(inlet, inlet) annotation (Line(
      points={{-68,90},{-64,90},{-64,90},{-68,90}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(outlet, outlet) annotation (Line(
      points={{-42,-66},{-44,-66},{-44,-66},{-42,-66}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(extent={{-80,-100},{80,100}})),
    Icon(coordinateSystem(extent={{-80,-100},{80,100}}), graphics={
        Polygon(
          origin={2,8},
          lineColor={0,131,169},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          points={{-62,52},{58,72},{58,-68},{-62,-48},{-62,52}})}),
    __OpenModelica_commandLineOptions="");
end Turbine_ph;
