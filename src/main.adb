with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;

with Mazify.Maze;

procedure Main is
begin
   if Ada.Command_Line.Argument_Count < 1 then
      Put_Line ("mazify needs a file passed on the command line to operate on");
   else
      declare
         M : Mazify.Maze.Map := Mazify.Maze.Read (Ada.Command_Line.Argument (1));
      begin
         M.Mazify;
         M.Print;
      end;
   end if;
end Main;
