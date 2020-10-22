within RankineCycle;
model FluidPort "FluidPort"

  connector FluidPortInPH
    Units.Pressure p "Potential/effort variable";
    Units.SpecificEnthalpy h "Specific enthalpy";
    Units.MassFraction x_flow "Flow variable";
    annotation (Icon(graphics={Ellipse(
            extent={{-98,96},{102,-104}},
            fillColor={0,131,169},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.Solid,
            lineColor={0,131,169},
            lineThickness=0.5)}));
  end FluidPortInPH;

  connector FluidPortOutPH
    Units.Pressure p "Potential/effort variable";
    Units.SpecificEnthalpy h "Specific enthalpy";
    Units.MassFraction x_flow "Flow variable";
    annotation (Icon(graphics={Ellipse(
            extent={{-98,98},{98,-100}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.Solid,
            lineColor={0,131,169},
            lineThickness=0.5)}));
  end FluidPortOutPH;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor=DynamicSelect({0,131,169}, if Delta_p <= 0 then {0,131,169}
               else {234,171,0}),
          fillColor={255,255,255},
          fillPattern=DynamicSelect(FillPattern.Solid, if Delta_p <= 0 then
              FillPattern.Solid else FillPattern.Backward))}), Diagram(
        coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics));
end FluidPort;
