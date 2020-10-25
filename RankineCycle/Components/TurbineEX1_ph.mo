within RankineCycle.Components;
model TurbineEx1_ph "Turbine"
  import Modelica.Media.Water.IF97_Utilities.h_ps;
  import Modelica.Media.Water.IF97_Utilities.s_ph;
  parameter Units.Pressure p_out,p_ex;
  parameter Units.Efficiency ef;
  Units.SpecificEntropy inlet_s;
  Units.WorkUnitMass ienergy,oenergy, w "worker";
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(extent={{-78,
            80},{-58,100}}), iconTransformation(extent={{-70,58},{-56,72}})));
  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(extent={{-52,
            -76},{-32,-56}}), iconTransformation(extent={{54,-72},{68,-58}})));
  FluidPort.FluidPortOutPH exlet annotation (Placement(transformation(
          extent={{-26,-54},{-16,-44}}),iconTransformation(extent={{-26,-54},{
            -16,-44}})));
equation
  outlet.p=p_out;
  exlet.p=p_ex;
  inlet_s=s_ph(inlet.p*1.0e6, inlet.h*1.0e3)*1.0e-3;
  if ef == 100.0 then
     exlet.h=h_ps(exlet.p*1.0e6, inlet_s*1.0e3)*1.0e-3;
     outlet.h=h_ps(exlet.p*1.0e6, inlet_s*1.0e3)*1.0e-3;
  else
     exlet.h = inlet.h - 0.01*ef * (inlet.h -1.0e-3*h_ps(exlet.p*1.0e6, inlet_s*1.0e3));
     outlet.h = exlet.h -0.01*ef * (exlet.h -1.0e-3*h_ps(outlet.p*1.0e6,s_ph(exlet.p*1.0e6, exlet.h*1.0e3)));
  end if;

  outlet.x_flow =inlet.x_flow  - exlet.x_flow;

  ienergy=inlet.x_flow * inlet.h;
  oenergy= exlet.x_flow* exlet.h+ outlet.x_flow* outlet.h;
  w = ienergy - oenergy;
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
end TurbineEx1_ph;
