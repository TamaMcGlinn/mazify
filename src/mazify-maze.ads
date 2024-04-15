with Ada.Containers.Indefinite_Vectors;

package mazify.Maze is

   package String_Vectors is new Ada.Containers.Indefinite_Vectors (Index_Type => Natural, Element_Type => String);

   type Map is new String_Vectors.Vector with null record;

   function Read (File_Name : String) return Map;

   type Pos is record
      X,Y : Natural;
   end record;

   function "+" (P, Q : Pos) return Pos;

   type Pos_Array is array (1 .. 4) of Pos;

   type Neighbours is record
      Count : Natural;
      Elements : Pos_Array;
   end record;

   procedure Add_Pos (N : in out Neighbours; P : Pos) with Pre => N.Count < 4;

   function Get_Unvisited_Neighbours (M : Map; P : Pos) return Neighbours;

   function Choose_Random (N : Neighbours) return Pos with Pre => N.Count > 0;

   function Find_First_Position (M : Map) return Pos;

   function Char_At (M : Map; P : Pos) return Character;

   procedure Set_Char (M : in out Map; P : Pos; C : Character);

   procedure Mazify (M : in out Map);

   procedure Print (M : Map);

end mazify.Maze;
