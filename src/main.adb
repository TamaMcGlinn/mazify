with Ada.Text_IO; use Ada.Text_IO;

with mazify.Example;

procedure Main is
begin
   Put_Line ("Hello" & mazify.Example.Calculate (12)'Image);
end Main;
