with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Bounded;
with Ada.Text_IO;           use Ada.Text_IO;

package Syntax is

   package B_Str is new
     Ada.Strings.Bounded.Generic_Bounded_Length (Max=>30);
   use B_Str;

   -- STACK STUFF --
   The_Stack: array(0..30) of Bounded_String;
   The_Stack_Top:Integer;
   Operator_Overhead:Bounded_String;
   procedure Read_Into_Stack;
   procedure Reset_Stack;
   Compare_Overhead:Integer;
   next_state:Integer;
   finished:boolean;
   procedure Push (Token: in Bounded_String);
   function Pop return Bounded_String;
   procedure Push_And_Reset_Overhead (Token: in Bounded_String);
   -- STACK STUFF --

   -- FILE STUFF --
   F:File_Type;
   -- FILE STUFF --

   --OPERATOR TABLE--
   type operator is (';','=','+','-','(',')','*','/',F1,TH3N,ODD,RELOP,'{','}',CALL,L,READ,WRITE);
   package operatorIO is new Ada.Text_IO.Enumeration_IO(operator);  use operatorIO;
   type relation is ('<','>','=');
   Operator_Table: array(operator,operator) of relation;
   procedure Instantiate_Operator_Table;
   Relation_Holder:relation;
   --OPERATOR TABLE--

   --READ TOKEN--
   procedure Read_Token;
   Buffer:Character;
   Actual:Character;
   Ident_Char:Character;
   Token_Buffer:Bounded_String;
   Check_AlphaNum:Boolean;
   Check_Special:Boolean;
   Operator_Holder:operator;
   Operator_Prev:operator;
   Token_Holder:operator;
   procedure Clean_and_Read;
   --READ TOKEN--

   --QUADS--
   type Quad_type is (Op,Left_Operand,Right_Operand,Temp);
   Quad_Array: array(0..30,Quad_type) of Bounded_String;
   Row_Overhead:Integer;
   Temp_Counter:integer;
   Temp_Version:Bounded_String;
   Pop_Value:Bounded_String;
   --QUADS--
   whatever:character;
   --ABBREVIATED METHODS--
   procedure assign_operator;
   procedure Push_Or_Pop;
   procedure Determine_Token_holder;
   procedure Temp_Version_Changer;
   procedure Quad_Check;
   --ABBREVIATED METHODS--

   --IF THEN METHODS--
   procedure IF_push_method;
   procedure THEN_push_method;
   procedure IF_THEN_popped_method;
   procedure Go_Back_and_Check;
   procedure Terminator_Encounter;
   procedure Label_Generator;
   Label_Counter:Integer;
   Label_Version:Bounded_String;
   Check_RELOP_Operator:Bounded_String;
   procedure Generate_IFTHEN_Quad;
   --IF THEN METHODS--

   --QUAD TO ASSEMBLY STUFF--
   procedure get_Quad;
   True_Operator:operator;
   procedure bString_to_operator;
   bstring_operator:Bounded_String;
   procedure Create_Add_String;
   procedure Create_Sub_String;
   procedure Create_Mul_String;
   procedure Create_Div_String;
   procedure Create_Assign_string;
   procedure Create_IF_String;
   procedure Change_OP_TEMP_Quad;
   procedure Create_Relation_String;
   procedure Create_Then_String;
   current_quad_array_overhead:integer;
   procedure Create_Label_string;
   --QUAD TO ASSEMBLY STUFF--

   --ASM FILE STUFF--
   A,Temp_file:File_Type;
   procedure Write_the_Whole_Thing_Function;
   procedure Write_the_first_part;
   procedure Write_the_second_part;
   procedure Write_IO_Routines;
   procedure Read_From_Temp_File;
   data_string:Bounded_String;
   asm_data_table:array(0..50) of Bounded_String;
   asm_data_table_overhead:integer;
   procedure Print_CONST;
   Print_DATA_overhead:integer;
   procedure Print_VAR;
   procedure Write_parts_of_main;
   procedure Create_READ_Quad;
   procedure Look_For_next;
   READ_value:Bounded_String;
   procedure Create_Read_String;
   procedure Create_WRITE_Quad;
   procedure Create_Write_string;
   procedure Look_For_next_write;
   Write_value:Bounded_String;
   procedure Check_Quads_for_num;
   --ASM FILE STUFF--


end Syntax;
