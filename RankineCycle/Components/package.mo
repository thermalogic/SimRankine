within RankineCycle;
package Components "boiler,tubine,etc"
extends Modelica.Icons.Package;

annotation (Icon(graphics={
    Polygon(
      origin={4,34},
      lineColor = {0,0,127},
      fillColor = {0,0,127},
      fillPattern = FillPattern.Solid,
      points = {{-16,10},{4,10},{-6,-10},{-16,10}}),
    Line(
      origin={4,34},
      points = {{-6,-10},{-6,-40},{-6,-38}},
      color = {0,0,127}),
    Polygon(
      origin={4,32},
      lineColor = {0,0,255},
      fillColor = {0,128,255},
      fillPattern = FillPattern.Solid,
      points = {{-56,10},{-56,-90},{-6,-40},{44,10},{44,-90},{-56,10}})}));
end Components;
