with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

package body mazify.Maze is
   function Read (File_Name : String) return Map is
      File : Ada.Text_IO.File_Type;
   begin
      Ada.Text_IO.Open (File, Ada.Text_IO.In_File, File_Name);
      declare
         M : Map;
      begin
         loop
            exit when Ada.Text_IO.End_of_File (File);
            M.Append (Ada.Text_IO.Get_Line (File));
         end loop;
         return M;
      end;
   end Read;

   package R is new Ada.Numerics.Discrete_Random (Natural);

   function Choose_Random (N : Neighbours) return Pos is
      G : R.Generator;
   begin
      R.Reset (G);
      return N.Elements ((R.Random (G) mod N.Count) + 1);
   end Choose_Random;

   function Find_First_Position (M : Map) return Pos is
      First_Line : constant String := M (1);
      Hash_Found : Boolean := False;
      Start_Position_Not_Found : exception;
   begin
      for X_Pos in First_Line'First..First_Line'Last loop
         if First_Line (X_Pos) = '#' then
            if Hash_Found then
               return (X => X_Pos, Y => 1);
            end if;
            Hash_Found := True;
         end if;
      end loop;
      raise Start_Position_Not_Found;
   end Find_First_Position;

   function Char_At (M : Map; P : Pos) return Character is (M (P.Y)(P.X));

   function Average (P,Q : Pos) return Pos is (X => (P.X + Q.X)/2, Y => (P.Y + Q.Y)/2);

   procedure Set_Char (M : in out Map; P : Pos; C : Character) is
   begin
      M (P.Y)(P.X) := C;
   end Set_Char;

   procedure Set_Clear (M : in out Map; P : Pos) is
   begin
      Set_Char (M, P, ' ');
   end Set_Clear;

   function "+" (P, Q : Pos) return Pos is (X => P.X + Q.X, Y => P.Y + Q.Y);
   function "-" (P, Q : Pos) return Pos is (X => P.X - Q.X, Y => P.Y - Q.Y);

   procedure Add_Pos (N : in out Neighbours; P : Pos) is
   begin
      N.Count := N.Count + 1;
      N.Elements (N.Count) := P;
   end;

   function Get_Unvisited_Neighbours (M : Map; P : Pos) return Neighbours is
      N : Neighbours := (Count => 0, others => <>);
      use type Ada.Containers.Count_Type;
      procedure Try_Add (New_P : Pos) is
      begin
         if Char_At (M, New_P) = '#' then
            Add_Pos (N, New_P);
         end if;
      end Try_Add;
   begin
      -- left
      if P.X >= 3 then
         Try_Add (P - (2, 0));
      end if;
      -- right
      if P.X <= String'(M (P.Y))'Length - 2 then
         Try_Add (P + (2, 0));
      end if;
      -- up
      if P.Y >= 3 then
         Try_Add (P - (0, 2));
      end if;
      -- down
      if Ada.Containers.Count_Type (P.Y) + 2 < M.Length then
         Try_Add (P + (0, 2));
      end if;
      return N;
   end Get_Unvisited_Neighbours;

   procedure Visit (M : in out Map; P : Pos) is
      -- get list of unvisited neighbours
      N : Neighbours := Get_Unvisited_Neighbours (M, P);
   begin
      -- mark cell visited
      Set_Clear (M, P);
      loop
         if N.Count = 0 then
            return;
         end if;
         declare
            -- choose random unvisited neighbour
            New_P : constant Pos := Choose_Random (N);
            Between : constant Pos := Average (P, New_P);
         begin
            -- set passage between the two
            Set_Clear (M, Between);
            Visit (M, New_P);
            N := Get_Unvisited_Neighbours (M, P);
         end;
      end loop;
   end Visit;

   procedure Mazify (M : in out Map) is
      P : constant Pos := Find_First_Position (M);
   begin
      Visit (M, P);
   end Mazify;

   procedure Print (M : Map) is
   begin
      for Line of M loop
         Ada.Text_IO.Put_Line (Line);
      end loop;
   end Print;
end mazify.Maze;
