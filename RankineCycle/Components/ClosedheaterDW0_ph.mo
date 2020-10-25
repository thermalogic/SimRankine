within RankineCycle.Components;
model ClosedheaterDw0_ph
  FluidPort.FluidPortOutPH outletFW annotation (Placement(transformation(extent=
           {{-92,-10},{-72,10}}), iconTransformation(extent={{-92,-10},{-72,10}})));
  FluidPort.FluidPortInPH inletFW annotation (Placement(transformation(extent={
            {72,-10},{92,10}}), iconTransformation(extent={{72,-10},{92,10}})));
  FluidPort.FluidPortInPH inletSM annotation (Placement(transformation(extent={
            {-10,58},{10,78}}), iconTransformation(extent={{-10,58},{10,78}})));
  FluidPort.FluidPortOutPH outletDW annotation (Placement(transformation(extent=
           {{-10,-78},{10,-58}}), iconTransformation(extent={{-10,-78},{10,-58}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-60,40},{60,-40}}, lineColor={28,108,200}),
        Line(points={{-72,0},{-40,0},{0,-20},{0,26},{40,0},{72,0}}, color={28,
              108,200}),
        Line(points={{0,60},{0,40}}, color={28,108,200}),
        Line(points={{0,-40},{0,-58}}, color={28,108,200})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ClosedheaterDw0_ph;
