within RankineCycle.Components;
model BoilerReheat_ph "Boiler and Reheat of Rankine Cycle"
  import Modelica.Media.Water.IF97_Utilities.hv_p;
  import Modelica.Media.Water.IF97_Utilities.h_pT;
  parameter Units.Dryness x_out;
  parameter Units.Temperature_DegC t_out;
  parameter Units.Pressure p_out;
  parameter Units.MassFraction x_flow_out;
  parameter Units.Temperature_DegC t_ouletRH;
  parameter Units.Pressure p_ouletRH;
  Units.HeatUnitMass sq,rq,q;

  FluidPort.FluidPortOutPH outlet annotation (Placement(transformation(
          extent={{-48,78},{-32,94}}),iconTransformation(extent={{-48,78},{-32,
            94}})));
  FluidPort.FluidPortInPH inlet annotation (Placement(transformation(
          extent={{-48,-76},{-38,-66}}), iconTransformation(extent={{-48,-76},{
            -38,-66}})));
  FluidPort.FluidPortOutPH outletRH annotation (Placement(transformation(extent={{34,50},
            {48,64}}),         iconTransformation(extent={{34,50},{48,64}})));
  FluidPort.FluidPortInPH inletRH annotation (Placement(transformation(extent={{38,-76},
            {48,-66}}),         iconTransformation(extent={{38,-76},{48,-66}})));
equation
  outlet.p=p_out;
  outletRH.p=p_ouletRH;
  // mass
  outlet.x_flow=x_flow_out;
  outletRH.x_flow=inletRH.x_flow;
  // heat
  if x_out==1 then
    outlet.h = hv_p(outlet.p*1.0e6)*1.0e-3;
  else
    outlet.h = h_pT(outlet.p*1.0e6,t_out+273.15)*1.0e-3;
  end if;
  sq= outlet.x_flow*(outlet.h - inlet.h);

  outletRH.h = h_pT(outletRH.p*1.0e6,t_ouletRH+273.15)*1.0e-3;
  rq=outletRH.x_flow*(outletRH.h - inletRH.h);
  q=sq+rq;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(initialScale=0.1),
        graphics={
        Rectangle(
          origin={-9.79599,28.7742},
          lineColor={0,131,169},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-86.204,23.2258},{89.796,-96.7742}}),
        Ellipse(
          origin={-38,20},
          lineColor={0,131,169},
          extent={{-40,10},{40,-70}},
          endAngle=360),
        Line(
          origin={-37.5669,15.8472},
          points={{-28,-2},{21.5669,-51.8472}},
          color={0,131,169}),
        Line(
          origin={-34,20.7389},
          points={{-28,-58},{26,-6.7389}},
          color={0,131,169}),
        Line(
          origin={-39.5541,-8},
          points={{-0.4459,60},{-12.4459,74},{11.5541,74},{0,88}},
          color={238,46,47},
          arrow={Arrow.None,Arrow.Filled}),
        Polygon(points={{-64,-78},{-64,-78},{-64,-78},{-64,-78}}),
        Line(points={{40,52},{40,-68}}, color={238,46,47},
          arrow={Arrow.Filled,Arrow.None})}));
end BoilerReheat_ph;
