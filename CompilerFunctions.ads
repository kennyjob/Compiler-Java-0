with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Bounded;
with Ada.Text_IO;           use Ada.Text_IO;

package CompilerFunctions is
   package B_Str is new
     Ada.Strings.Bounded.Generic_Bounded_Length (Max=>30);
   use B_Str;

   -- NEW STUFF --
   type ALPHABET is new Character range 'A'..'z';
   type DIGIT is new Integer range 0..9;
   type Input_Type is ('A','D',' ','=',',',
                       ';','+','-','*','/','(',
                       ')','<','>','{','}','!');

   -- NEW STUFF --

   -- INPUT TABLE --
   type Input_Row is range 0..65;
   type Input_Col is range 0..1;
   type Input_Array is array(Input_Row,Input_Col) of Bounded_String;
   Input_Table: Input_Array;
   -- INPUT TABLE --

   -- TRANSITION TABLE --
   type Transition_Row is range 0..35;
   type Transition_Col is range 0..35;
   type Transition_Array is array(0..28,Character) of Integer;
   Transition_Table:Transition_Array;
   -- TRANSITION TABLE --

   -- TOKEN TABLE --
   type Token_Range is range 0..1000;
   Token_Array: array(Token_Range,0..1) of Bounded_String;
   Table_Overhead:Token_Range;
   -- TOKEN TABLE --

   -- SYMBOL TABLE --

   Symbol_Array: array(Token_Range,0..4) of Bounded_String;
   Symbol_Overhead:Token_Range;
   Address_Counter:Integer;
   Check_program_name:boolean:=True;
   Check_Const:Boolean:=False;
   Check_Var:Boolean:=False;
   Check_Procedure:Boolean:=False;
   -- SYMBOL TABLE --

   -- QUEUE ROUTINES --
   type Queue_Range is range 0..20;
   Queue_Array:array(Queue_Range) of Character;
   Queue_Front:Queue_Range;
   Queue_Rear:Queue_Range;
   --procedure Queue(ch: in character);
   --procedure Dequeue;
   Token_Buffer:Bounded_String;
   --procedure Increase_Rear;
   -- QUEUE ROUTINES --

   procedure Transition_Table_Initialization;
   --procedure Input_Table_Initialization;
   --procedure Process_Code;

   -- STATE_MACHINE --
   procedure STATE_MACHINE;
   next_state:Integer;
   Result_Digit:Boolean;
   Result_Alpha:Boolean;
   -- STATE_MACHINE --

   -- ADD TOKEN --
   procedure Add_Token;
   -- ADD TOKEN --
   procedure Print_To_File;

   --REAL SYMBOL TABLE --
   procedure Add_To_Symbol_Table;
   type attributes is (Symbol,Classification,Value,Address,Segment);
   Real_Symbol_Array: array(Token_Range,attributes) of bounded_String;
   Real_Overhead:Token_Range;
   Real_Address_Counter:integer;
   Identifier_Array: array(Token_Range) of bounded_String;
   Identifier_Overhead:Token_Range;
   Variable_Counter:Integer;
   H,G:File_Type;
   --REAL SYMBOL TABLE --

   --CREATE CODE SECTION--
   Symbol_table_Overhead:token_range;
   procedure Scan_For_Const;
   type Class is (Const_Var,Numeric_Literal,Var);
   procedure B_String_to_Class;
   class_state:Class;
   current_table_overhead:Token_Range;
   Initialized_Data_Table:array(token_range,0..2) of bounded_string;
   Initialized_Data_Overhead:Token_Range;
   Uninitialized_Data_Table:array(token_range,0..2) of bounded_string;
   UninitialIzed_Data_Overhead:Token_Range;
   procedure Save_Into_Const_Table;
   procedure Save_Into_Var_Table;
   procedure Add_Temps_To_Var_Table;
   Compiler_Temp_Counter:Integer;
   Temp_Version:Bounded_String;
   procedure Temp_Variable_Changer_Compiler;
   procedure Read_And_Write_both_Tables;
   procedure Save_Into_Const_Table_Numerical;
   A,Temp:File_Type;

   --procedure Write_The_Main_Routine;
   --CREATE CODE SECTION--



end CompilerFunctions;
