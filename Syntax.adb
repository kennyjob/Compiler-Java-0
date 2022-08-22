with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Bounded;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with ada.characters.Latin_1; use ada.characters.Latin_1;

package body Syntax is


   procedure Read_Into_Stack is


   begin
      Instantiate_Operator_Table;
      next_state:=0;
      Row_Overhead:=0;
      finished:=false;
      Check_AlphaNum:=false;
      Check_Special:=false;
      Push_And_Reset_Overhead(To_Bounded_String(";"));
      Open (F, In_File, "Token_Table_Q1.txt");
      while not End_Of_File(F) loop
         --put("EOF loop check");
         while not finished loop
            --put("case loop check");
            case next_state is
            when 0=>

               Get_Immediate(F,Buffer);

               if buffer='{' then
                  next_state:=1;
                  Skip_Line(f);                   --This if block moves past class whatever to find
                  --"{", then transitions to state 1 and starts new line
                  --to find tokens
               elsif buffer=' ' then
                  Skip_Line(f);
               else
                  next_state:=0;
                  Skip_Line(f);
               end if;
            when 1=>
               Read_Token;
               --put(to_string(Token_Buffer));
               --put(buffer);
               --buffer=space,tokenbuffer=token
               Skip_Line(f); -- head to next line for the next token
               --BEFORE READING NEXT TOKEN THIS BLOCK checks for priority tokens
               if Token_Buffer="PROCEDURE" then
                  Token_Buffer:=To_Bounded_String("");
                  next_state:=2;
                  Buffer:=('_');
               end if; --since procedure token encountered, state changed to 2 in order to
               --process incoming equations and make quads until delimiter encountered.
               Buffer:=('_');
               Token_Buffer:=To_Bounded_String("");
            when 2=>
               Get_Immediate(F,Buffer);
               if buffer='{' then
                  next_state:=3;
                  Skip_Line(f);                   --This if block moves past function name
                  --whatever to find
                  --"{", then transitions to state 3 and starts new line
                  --to find tokens
               elsif buffer=' ' then
                  Skip_Line(f);
               else
                  next_state:=2;
                  Skip_Line(f);
               end if;
            when 3=>

               Clean_and_Read;
               Skip_Line(f);
               Temp_Counter:=1;
               Label_Counter:=1;
               if token_buffer="READ" then
                  Create_READ_Quad;

               elsif Token_Buffer="VAR" then
                  while Token_Buffer /=";" loop
                     Read_Token;
                     Buffer:=('_');
                     Skip_Line(f);
                     --put("ignore var loop check");
                  end loop;
               elsif Token_Buffer="IF" then

                  while Token_Buffer/=";" loop

                     Temp_Version_Changer;

                     Ident_Char:=Element(Token_Buffer,1);
                     Check_AlphaNum:=Is_Alphanumeric(Ident_Char);
                     Check_Special:=Is_Special(Ident_Char);
                     if Check_AlphaNum=True then              --this whole while loop
                        if Token_Buffer="IF" then

                           IF_push_method;
                        elsif   Token_Buffer="THEN" then

                           THEN_push_method;
                        else
                           Push(Token_Buffer);
                           Clean_and_Read;
                           Skip_Line(f);
                           Check_AlphaNum:=false;
                        end if;
                     elsif Check_Special=True then
                        if Token_Buffer="<" or
                          Token_Buffer=">" or
                          Token_Buffer=">=" or
                          Token_Buffer="<=" or
                          Token_Buffer="==" or
                          Token_Buffer="!=" then
                           Assign_operator;
                           Relation_Holder:=Operator_Table(Operator_Holder,RELOP);
                           --does table lookup using operator overhead and tokenbuffer
                           --returns relation value

                        else

                           Determine_Token_Holder;

                           Assign_operator; -- converts operator overhead(string) into relation type



                           put(operator'image(Operator_Holder));
                           put(operator'image(token_holder));
                           Relation_Holder:=Operator_Table(Operator_Holder,Token_Holder);
                           --does table lookup using operator overhead and tokenbuffer
                           --returns relation value

                        end if;

                        Push_Or_Pop;
                     end if;
                  end loop;

                  Terminator_Encounter;

                  Temp_Counter:=1; -- reset temp counter
                  Reset_Stack;
                  Push_And_Reset_Overhead(To_Bounded_String(";"));
                  next_state:=4;
               else
                  --DONT TOUCH HERE--
                  while Token_Buffer/="}" loop
                     --put_line("start expression");
                     --put_line(to_string(token_buffer));
                     Temp_Version_Changer;

                     Ident_Char:=Element(Token_Buffer,1);
                     Check_AlphaNum:=Is_Alphanumeric(Ident_Char);
                     Check_Special:=Is_Special(Ident_Char);
                     if Check_AlphaNum=True then              --this whole while loop
                        --evaluates expressions
                        Push(Token_Buffer);
                        Clean_and_Read;                          --this one makes arithmetic pda
                        Skip_Line(f);
                        Check_AlphaNum:=false;
                     elsif Check_Special=True then
                        if Token_Buffer="<" or
                          Token_Buffer=">" or
                          Token_Buffer=">=" or
                          Token_Buffer="<=" or
                          Token_Buffer="==" or
                          Token_Buffer="!=" then
                           Assign_operator;
                           Relation_Holder:=Operator_Table(Operator_Holder,RELOP);
                           --does table lookup using operator overhead and tokenbuffer
                           --returns relation value

                        else

                           Determine_Token_Holder;

                           Assign_operator;


                           put(operator'image(Operator_Holder));
                           put(operator'image(token_holder));
                           Relation_Holder:=Operator_Table(Operator_Holder,Token_Holder);
                           --does table lookup using operator overhead and tokenbuffer
                           --returns relation value

                        end if;

                        Push_Or_Pop;
                        Check_Special:=false;
                     end if;
                     If Token_Buffer="WRITE" then
                        Create_WRITE_Quad;
                     end if;

                  end loop;
                  --DONT TOUCH HERE--
                  Temp_Counter:=1; -- reset temp counter
                  Reset_Stack;
                  Push_And_Reset_Overhead(To_Bounded_String(";"));
                  next_state:=2;

               end if;

               when 4=>
                  Clean_and_Read;
                  Skip_Line(f);
                  If Token_Buffer="WRITE" then

                     Create_WRITE_Quad;
                     Generate_IFTHEN_Quad;
                  end if;
                  while Token_Buffer/="}" loop

                     Temp_Version_Changer;

                     Ident_Char:=Element(Token_Buffer,1);
                     Check_AlphaNum:=Is_Alphanumeric(Ident_Char);
                     Check_Special:=Is_Special(Ident_Char);
                     if Check_AlphaNum=True then              --this whole while loop
                        if Token_Buffer="IF" then

                           IF_push_method;
                        elsif   Token_Buffer="THEN" then

                           THEN_push_method;
                        else
                           Push(Token_Buffer);                   --this one makes if_then pda
                           Clean_and_Read;
                           Skip_Line(f);
                           Check_AlphaNum:=false;
                        end if;
                     elsif Check_Special=True then
                        if Token_Buffer="<" or
                          Token_Buffer=">" or
                          Token_Buffer=">=" or
                          Token_Buffer="<=" or
                          Token_Buffer="==" or
                          Token_Buffer="!=" then
                           Assign_operator;
                           Relation_Holder:=Operator_Table(Operator_Holder,RELOP);
                           --does table lookup using operator overhead and tokenbuffer
                           --returns relation value

                        else

                           Determine_Token_Holder;

                           Assign_operator; -- converts operator overhead(string) into relation type



                           put(operator'image(Operator_Holder));
                           put(operator'image(token_holder));
                           Relation_Holder:=Operator_Table(Operator_Holder,Token_Holder);
                           --does table lookup using operator overhead and tokenbuffer
                           --returns relation value

                        end if;

                        Push_Or_Pop;
                     end if;

                     If Token_Buffer="WRITE" then
                        Create_WRITE_Quad;
                     end if;

                  end loop;
                  Generate_IFTHEN_Quad;


                  if Token_Buffer="}" then
                     finished:=true;
                  end if;
               when others=>null;
            end case;

         end loop;
         finished:=true;
         get(f,whatever);
      end loop;
      close(F);
   end;

   procedure Read_Token is
   begin
      while buffer /= ' ' loop             --while loop gets character,appends if not space,
         --when space in buffer, exits and new_lines
         Get_Immediate(F,Buffer);
         if buffer/= ' ' then
            Actual:=Buffer;
            Append(Token_Buffer,Actual);-- append character to actual until space
         end if;
      end loop;
   end;


   procedure Clean_and_Read is
   begin
      Buffer:=('_');
      Token_Buffer:=To_Bounded_String("");
      Read_Token;
   end;



   procedure Reset_Stack is

   begin
      The_Stack_Top:=0;
   end;

   procedure Push (Token: in Bounded_String) is
   begin
      The_Stack_Top:=The_Stack_Top+1;
      The_Stack(The_Stack_Top):=Token;

   end;

   procedure Push_And_Reset_Overhead (Token: in Bounded_String) is
   begin
      The_Stack_Top:=The_Stack_Top+1;
      The_Stack(The_Stack_Top):=Token;
      Operator_Overhead:=Token;
   end;

   function Pop return Bounded_String is
   begin

      Pop_Value:=The_Stack(The_Stack_Top);
      The_Stack_Top:=The_Stack_Top-1;
      return Pop_Value;

   end;

   procedure Assign_operator is
   begin

      if Operator_Overhead="=" then
         operator_holder:='=';
      elsif Operator_Overhead="+" then
         operator_holder:='+';
      elsif Operator_Overhead="-" then
         operator_holder:='-';
      elsif Operator_Overhead="(" then
         operator_holder:='(';
      elsif Operator_Overhead=")" then --assigns correct token to token holder.
         operator_holder:=')';       --'value(to_string(token_buffer) does not work for some reason.
      elsif Operator_Overhead="*" then
         operator_holder:='*';
      elsif Operator_Overhead="/" then
         operator_holder:='/';
      elsif Operator_Overhead=";" then
         operator_holder:=';';
      elsif Operator_Overhead="IF" then
         operator_holder:=F1;
      elsif Operator_Overhead="THEN" then
         operator_holder:=TH3N;
      elsif Operator_Overhead="<" then
         operator_holder:=RELOP;
      elsif Operator_Overhead=">" then
         operator_holder:=RELOP;
      elsif Operator_Overhead=">=" then
         operator_holder:=RELOP;
      elsif Operator_Overhead="<=" then
         operator_holder:=RELOP;
      elsif Operator_Overhead="==" then
         operator_holder:=RELOP;
      elsif Operator_Overhead="!=" then
         operator_holder:=RELOP;

      end if;
   end;

   procedure Push_Or_Pop is
   begin
      if Relation_Holder = '<' or Relation_Holder = '=' then
         Push_And_Reset_Overhead(Token_Buffer);
         --pushes value, resets operator overhead
         put(To_String(token_buffer)); put_line("was pushed");
         Clean_and_Read;
         Skip_Line(f);

      elsif Relation_Holder = '>' then
         --do the pop
         put_line("pops");
         Quad_Array(Row_Overhead,Right_Operand):=Pop;
         Quad_Array(Row_Overhead,Op):=Pop;
         Quad_Array(Row_Overhead,Left_Operand):=Pop;
         Quad_Array(Row_Overhead,Temp):=Temp_Version;

         Change_OP_TEMP_Quad;

         Row_Overhead:=Row_Overhead+1;
         Operator_Overhead:=The_Stack(The_Stack_Top);
         push(Temp_Version);
         Temp_Counter:=Temp_Counter+1;

         --checks quads
         put_line("quad check");
         put(to_string(Quad_Array(Row_Overhead-1,Right_Operand)));
         put(to_string(Quad_Array(Row_Overhead-1,op)));
         put(to_string(Quad_Array(Row_Overhead-1,left_Operand)));
         put_line(to_string(Quad_Array(Row_Overhead-1,temp)));
         put_line("quad check");
      end if;
   end;

   procedure Determine_Token_Holder is
   begin
      if Token_Buffer="=" then
         Token_Holder:='=';
      elsif Token_Buffer="+" then
         Token_Holder:='+';
      elsif Token_Buffer="-" then
         Token_Holder:='-';
      elsif Token_Buffer="(" then
         Token_Holder:='(';
      elsif Token_Buffer=")" then --assigns correct token to token holder.
         Token_Holder:=')';       --'value(to_string(token_buffer) does not work for some reason.
      elsif Token_Buffer="*" then
         Token_Holder:='*';
      elsif Token_Buffer="/" then
         Token_Holder:='/';
      elsif Token_Buffer=";" then
         Token_Holder:=';';
      end if;

   end;

   procedure Temp_Version_Changer is
   begin
      case Temp_Counter is
         when 1=>Temp_Version:=To_Bounded_String("T1");
         when 2=>Temp_Version:=To_Bounded_String("T2"); --version changer
         when 3=>Temp_Version:=To_Bounded_String("T3");
         when 4=>Temp_Version:=To_Bounded_String("T4");
         when 5=>Temp_Version:=To_Bounded_String("T5");
         when 6=>Temp_Version:=To_Bounded_String("T6");
         when 7=>Temp_Version:=To_Bounded_String("T7");
         when 8=>Temp_Version:=To_Bounded_String("T8");
         when 9=>Temp_Version:=To_Bounded_String("T9");
         when 10=>Temp_Version:=To_Bounded_String("T10");
         when 11=>Temp_Version:=To_Bounded_String("T11");
         when others=>null;
      end case;

   end;

   procedure IF_push_method is
   begin
      Push_And_Reset_Overhead(Token_Buffer);
      put(To_String(token_buffer)); put_line("was pushed");
      Quad_Array(Row_Overhead,Op):=Token_Buffer;
      Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("?");
      Quad_Array(Row_Overhead,Left_Operand):=To_Bounded_String("?");
      Quad_Array(Row_Overhead,Temp):=To_Bounded_String("?");
      Row_Overhead:=Row_Overhead+1;
      Quad_Check;
      Clean_and_Read;
      Skip_Line(f);
   end;

   procedure THEN_push_method is
   begin
      Assign_operator;
      Relation_Holder:=Operator_Table(Operator_Holder,TH3N);
      if Relation_Holder = '<' or Relation_Holder = '=' then
         Push_And_Reset_Overhead(Token_Buffer);
         Label_Generator;
         Go_Back_and_Check;
         Quad_Array(Row_Overhead,Op):=to_Bounded_String("THEN");
         Quad_Array(Row_Overhead,Left_Operand):=Label_Version;
         Quad_Array(Row_Overhead,temp):=to_bounded_string("?");
         put(To_String(token_buffer)); put_line("was pushed");
         Row_Overhead:=Row_Overhead+1;
         Quad_Check;
         Clean_and_Read;
         Skip_Line(f);
         Label_Counter:=Label_Counter+1;
      elsif Relation_Holder = '>' then
         --do the pop
         put_line("pops");
         Quad_Array(Row_Overhead,Right_Operand):=Pop;
         Quad_Array(Row_Overhead,Op):=Pop;
         Quad_Array(Row_Overhead,Left_Operand):=Pop;
         Quad_Array(Row_Overhead,Temp):=To_Bounded_String("?");
         Row_Overhead:=Row_Overhead+1;
         Operator_Overhead:=The_Stack(The_Stack_Top);

         --checks quads
         put_line("quad check");
         put(to_string(Quad_Array(Row_Overhead-1,Right_Operand)));
         put(to_string(Quad_Array(Row_Overhead-1,op)));
         put(to_string(Quad_Array(Row_Overhead-1,left_Operand)));
         put_line(to_string(Quad_Array(Row_Overhead-1,temp)));
         put_line("quad check");
      end if;
   end;

   procedure IF_THEN_popped_method is
   begin
      null;
   end;

   procedure Label_Generator is
   begin
      case Label_Counter is
         when 1=>Label_Version:=To_Bounded_String("L1");
         when 2=>Label_Version:=To_Bounded_String("L2"); --version changer
         when others=>null;
      end case;
   end;

   procedure Go_Back_and_Check is
   begin
      Check_RELOP_Operator:=Quad_Array(Row_Overhead-1,op);
      if Check_RELOP_Operator=">" then
         Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("L");
      elsif Check_RELOP_Operator="<" then
         Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("G");
      elsif Check_RELOP_Operator="<=" then
         Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("GE");
      elsif Check_RELOP_Operator=">=" then
         Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("LE");
      end if;

   end;


   procedure Quad_Check is
   begin
      --checks quads
      put_line("quad check");
      put(to_string(Quad_Array(Row_Overhead-1,Right_Operand)));
      put(to_string(Quad_Array(Row_Overhead-1,op)));
      put(to_string(Quad_Array(Row_Overhead-1,left_Operand)));
      put_line(to_string(Quad_Array(Row_Overhead-1,temp)));
      put_line("quad check");
   end;

   procedure Terminator_Encounter is
   begin
      if Token_Buffer=";" then
         Assign_operator;
         Relation_Holder:=Operator_Table(Operator_Holder,';');
         Push_Or_Pop;
      end if;
   end;

   procedure Generate_IFTHEN_Quad is
   begin
      Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("?");
      Quad_Array(Row_Overhead,Op):=To_Bounded_String("L");
      Quad_Array(Row_Overhead,Left_Operand):=Label_Version;
      Quad_Array(Row_Overhead,Temp):=To_Bounded_String("?");
      Row_Overhead:=Row_Overhead+1;
      Quad_Check;
   end;

   procedure get_Quad is
   begin
      current_quad_array_overhead:=Row_Overhead;
      Row_Overhead:=0;
      while Row_Overhead<current_quad_array_overhead loop
         bString_to_operator;
         case True_Operator is
         when '+' =>Create_Add_String;
         when '*' =>Create_Mul_String;
         when '/' =>Create_Div_String;
         when '-' =>Create_Sub_String;
         when ')' =>Create_Assign_string;
         when F1 =>Create_IF_String;
         when TH3N =>Create_Then_String;
         when RELOP =>Create_Relation_String;
         when '=' =>Create_Assign_string;
         when L=>Create_Label_string;
         when READ=>Create_Read_String;
         when WRITE=>Create_Write_String;
         when others=>null;
         end case;
         Row_Overhead:=Row_Overhead+1;
      end loop;
   end;

   procedure bString_to_operator is
   begin
      bstring_operator:=Quad_Array(Row_Overhead,op);

      if bstring_operator="+" then
         True_Operator:='+';
      elsif bstring_operator="=" then
         True_Operator:='=';
      elsif bstring_operator="-" then
         True_Operator:='-';
      elsif bstring_operator="*" then
         True_Operator:='*';
      elsif bstring_operator="/" then
         True_Operator:='/';
      elsif bstring_operator="(" then
         True_Operator:='(';
      elsif bstring_operator=")" then
         True_Operator:=')';
      elsif bstring_operator="IF" then
         True_Operator:=F1;
      elsif bstring_operator="THEN" then
         True_Operator:=TH3N;
      elsif bstring_operator="<" then
         True_Operator:=RELOP;
      elsif bstring_operator=">" then
         True_Operator:=RELOP;
      elsif bstring_operator="<=" then
         True_Operator:=RELOP;
      elsif bstring_operator=">=" then
         True_Operator:=RELOP;
      elsif bstring_operator="L" then
         True_Operator:=L;
      elsif bstring_operator="READ" then
         True_Operator:=READ;
      elsif bstring_operator="WRITE" then
         True_Operator:=WRITE;
      end if;


   end;

   procedure Create_Add_String is
   begin
      put(A,HT &"mov ax, [");
      put(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
      put_line(A,"]");
      put(A,HT &"add ax, [");
      put(A,to_String(Quad_Array(Row_Overhead,right_Operand)));
      put_line(A,"]");
      put(A,HT &"mov [");
      put(A,to_String(Quad_Array(Row_Overhead,temp)));
      put_line(A,"], ax");
   end;

   procedure Create_Sub_String is
   begin
      put(A,HT &"mov ax, [");
      put(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
      put_line(A,"]");
      put(A,HT &"sub ax, [");
      put(A,to_String(Quad_Array(Row_Overhead,right_Operand)));
      put_line(A,"]");
      put(A,HT &"mov [");
      put(A,to_String(Quad_Array(Row_Overhead,temp)));
      put_line(A,"], ax");
   end;
   procedure Create_Mul_String is
   begin
      put(A,HT &"mov ax, [");
      put(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
      put_line(A,"]");
      put(A,HT &"mul word [");
      put(A,to_String(Quad_Array(Row_Overhead,right_Operand)));
      put_line(A,"]");
      put(A,HT &"mov [");
      put(A,to_String(Quad_Array(Row_Overhead,temp)));
      put_line(A,"], ax");
   end;
   procedure Create_Div_String is
   begin
      put_line(A,HT &"mov dx, 0");
      put(A,HT &"mov ax, [");
      put(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
      put_line(A,"]");
      put(A,HT &"mov bx, [");
      put(A,to_String(Quad_Array(Row_Overhead,right_Operand)));
      put_line(A,"]");
      put_line(A,HT &"div bx");
      put(A,HT &"mov [");
      put(A,to_String(Quad_Array(Row_Overhead,temp)));
      put_line(A,"], ax");
   end;

   procedure Create_Assign_string is
   begin
      if Quad_Array(row_overhead,Left_Operand)="(" then

         put(A,HT &"mov ax, [");
         put(A,to_String(Quad_Array(Row_Overhead,right_Operand)));
         put_line(A,"]");
         put(A,HT &"mov [");
         put(A,to_String(Quad_Array(Row_Overhead,temp)));
         put_line(A,"], ax");
      else
         put(A,HT &"mov ax, [");
         put(A,to_String(Quad_Array(Row_Overhead,right_Operand)));
         put_line(A,"]");
         put(A,HT &"mov [");
         put(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
         put_line(A,"], ax");
      end if;
      end;
      procedure Create_IF_String is
      begin
         put(A,HT &"mov ax, [");
         put(A,to_String(Quad_Array(Row_Overhead+1,left_Operand)));
         put_line(A,"]");
      end;
      procedure Create_Relation_String is
      begin
         put(A,HT &"cmp ax, [");
         put(A,to_String(Quad_Array(Row_Overhead,right_Operand)));
         put_line(A,"]");
      end;

      procedure Create_Then_String is
      begin
         if to_String(Quad_Array(Row_Overhead-1,op))=">" then
            put(A,HT &"JLE ");
            Put_Line(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
         elsif to_String(Quad_Array(Row_Overhead-1,op))="<" then
            put(A,HT &"JGE ");
            Put_Line(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
         elsif to_String(Quad_Array(Row_Overhead-1,op))=">=" then
            put(A,HT &"JLE ");
            Put_Line(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
         elsif to_String(Quad_Array(Row_Overhead-1,op))="<=" then
            put(A,HT &"JGE ");
            Put_Line(A,to_String(Quad_Array(Row_Overhead,Left_Operand)));
         end if;
      end;

      procedure Change_OP_TEMP_Quad is
      begin
         if Quad_Array(Row_Overhead,op)="T5" then
            Quad_Array(Row_Overhead,op):=To_Bounded_String(")");
            Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("T5");
         elsif Quad_Array(Row_Overhead,op)="T8" then
            Quad_Array(Row_Overhead,op):=To_Bounded_String(")");
            Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("T8");
         elsif Quad_Array(Row_Overhead,op)="T2" then
            Quad_Array(Row_Overhead,op):=To_Bounded_String(")");
            Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("T2");
         end if;
      end;
      procedure Create_Label_string is
      begin
         put(A, to_String(Quad_Array(Row_Overhead,Left_Operand)));
         Put_Line(A,HT&": NOP");
      end;

      procedure Write_the_Whole_Thing_Function is
      begin
         Create(A,Out_File,"assemblyCompiler.txt");
         Write_the_first_part;
         Print_CONST;
         Write_the_second_part;
         Print_VAR;
         Write_parts_of_main;
         Write_IO_Routines;
         close(A);
      end;
      procedure Write_the_first_part is
      begin
         put_line(A,"sys_exit" & HT &"equ 1");
         put_line(A,"sys_read" & HT &"equ 3");
         put_line(A,"sys_write" & HT &"equ 4");
         put_line(A,"stdin" & HT &"equ 0");
         put_line(A,"stdout" & HT &"equ 1");
         put_line(A,"stderr" & HT &"equ 3");
         put_line(A,"section .data" & HT);
         put_line(A,HT &"userMsg db 'Enter an integer(less than 32,765): '");
         put_line(A,HT &"lenUserMsg equ $-userMsg");
         put_line(A,HT &"displayMsg db 'You entered: '");
         put_line(A,HT &"lenDisplayMsg equ $-displayMsg");
         put_line(A,HT &"newline db 0xA");
         put_line(A,HT &"Ten        DW  10  ");
         put_line(A,HT &"Result          db 'Ans = '");
         put_line(A,HT &"ResultValue db 'aaaaa'");
         put_line(A,HT &"db 0xA");
         put_line(A,HT &"ResultEnd equ $-Result   ");
         put_line(A,HT &"num times 6 db 'ABCDEF' ");
         put_line(A,	HT &"numEnd" & HT &"equ $-num");
      end;

      procedure Write_the_second_part is
      begin
         put_line(A,"section" & HT &".bss");
         put_line(A,HT &"TempChar RESB 1");
         put_line(A,HT &"testchar RESB 1");
         put_line(A,HT &"ReadInt RESW 1");
         put_line(A,HT &"tempint RESW 1");
         put_line(A,HT &"negflag RESB 1");
      end;

      procedure Write_IO_Routines is
      begin
         put_line(A,"PrintString:");
         put_line(A,HT &"push ax");
         put_line(A,HT &"push dx");
         put_line(A,HT &"mov eax, 4");
         put_line(A,HT &"mov ebx, 1");
         put_line(A,HT &"mov ecx, userMsg");
         put_line(A,HT &"mov edx, lenUserMsg");
         put_line(A,HT &"int 80h");
         put_line(A,HT &"pop     dx");
         put_line(A,HT &"pop     ax");
         put_line(A,HT &"ret");

         put_line(A,"GetAnInteger:");
         put_line(A,HT &"mov eax,3");
         put_line(A,HT &"mov ebx,2");
         put_line(A,HT &"mov ecx, num");
         put_line(A,HT &"mov edx,6");
         put_line(A,HT &"int 0x80");
         put_line(A,HT &"mov edx,eax ");
         put_line(A,HT &"mov eax, 4");
         put_line(A,HT &"mov ebx, 1");
         put_line(A,HT &"mov ecx, num");
         put_line(A,HT &"int 80h");

         put_line(A,"ConvertStringToInteger:");
         put_line(A,HT &"mov ax,0");
         put_line(A,HT &"mov [ReadInt],ax ");
         put_line(A,HT &"mov ecx,num");
         put_line(A,HT &"mov bx,0");
         put_line(A,HT &"mov bl, byte [ecx] ");

         Put_Line(A,"Next:" & HT &"sub bl,'0'");
         Put_Line(A,HT &"mov ax,[ReadInt]");
         Put_Line(A,HT &"mov dx,10");
         Put_Line(A,HT &"mul dx");
         Put_Line(A,HT &"add ax,bx");
         Put_Line(A,HT &"mov [ReadInt], ax");
         Put_Line(A,HT &"mov bx,0");
         Put_Line(A,HT &"add ecx,1");
         Put_Line(A,HT &"mov bl, byte[ecx]");
         Put_Line(A,HT &"cmp bl,0xA");
         Put_Line(A,HT &"jne Next");
         Put_Line(A,HT &"ret");

         Put_Line(A,"ConvertIntegerToString:");
         Put_Line(A,HT &"mov ebx, ResultValue + 4");
         Put_Line(A,"ConvertLoop:");
         Put_Line(A,HT &"sub dx,dx");
         Put_Line(A,HT &"mov cx,10  ");
         Put_Line(A,HT &"div cx");
         Put_Line(A,HT &"add dl,'0' ");
         Put_Line(A,HT &"mov [ebx], dl");
         Put_Line(A,HT &"dec ebx");
         Put_Line(A,HT &"cmp ebx,ResultValue");
         Put_Line(A,HT &"jge ConvertLoop");
         Put_Line(A,HT &"ret");
      end;


      procedure Read_From_Temp_File is
      begin
         asm_data_table_overhead:=0;
         Print_DATA_overhead:=0;
         open(Temp_file,in_file,"Temp.txt");
         while not End_Of_File(Temp_file) loop
            data_string:=to_bounded_string(get_line(Temp_file));
            asm_data_table(asm_data_table_overhead):=data_string;
            asm_data_table_overhead:=asm_data_table_overhead+1;
         end loop;
         close(Temp_file);
      end;

      procedure Print_CONST is
      begin
         for i in 0..4 loop
            put_line(A,HT & to_string(asm_data_table(Print_DATA_overhead)));
            Print_DATA_overhead:=Print_DATA_overhead+1;
         end loop;
      end;

      procedure Print_VAR is
      begin
         for i in 0..20 loop
            put_line(A,HT & to_string(asm_data_table(Print_DATA_overhead)));
            Print_DATA_overhead:=Print_DATA_overhead+1;
         end loop;
      end;

      procedure Write_parts_of_main is
      begin
         Put_Line(A,"section .text");
         Put_Line(A,HT &"global main");
         Put_Line(A,"main:"&HT&"nop");
         Put_Line(A,"Again:");

         Check_Quads_for_num;
         get_Quad;

         Put_Line(A,"fini:");
         Put_Line(A,HT &"mov eax,sys_exit");
         Put_Line(A,HT &"xor ebx,ebx");
         Put_Line(A,HT &"int 80h");
      end;

      procedure Create_READ_Quad is
      begin
         Look_For_Next;
         Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("?");
         Quad_Array(Row_Overhead,Op):=To_Bounded_String("READ");
         Quad_Array(Row_Overhead,Left_Operand):=READ_Value;
         Quad_Array(Row_Overhead,Temp):=To_Bounded_String("?");
         Row_Overhead:=Row_Overhead+1;
         Quad_Check;
      end;

      procedure Look_For_Next is
      begin
         Clean_and_Read;
         Skip_Line(f);
         READ_value:=Token_Buffer;
         Skip_line(f);
      end;

      procedure Create_Read_string is
      begin
         put_line(A,HT &"call PrintString");
         put_line(A,HT &"call GetAnInteger");
         put_line(A,HT &"mov ax, [ReadInt]");
         put_line(A,HT &"mov ["& to_String(Quad_Array(Row_Overhead,Left_Operand))&"],ax");
      end;

      procedure Create_WRITE_Quad is
      begin
         Look_For_Next_write;
         Quad_Array(Row_Overhead,Right_Operand):=To_Bounded_String("?");
         Quad_Array(Row_Overhead,Op):=To_Bounded_String("WRITE");
         Quad_Array(Row_Overhead,Left_Operand):=WRITE_Value;
         Quad_Array(Row_Overhead,Temp):=To_Bounded_String("?");
         Row_Overhead:=Row_Overhead+1;
         Quad_Check;
      end;

      procedure Create_Write_String is
      begin
         put_line(A,HT &"call ConvertIntegerToString");
         put_line(A,HT &"mov eax, 4");
         put_line(A,HT &"mov ebx, 1");
         put_line(A,HT &"mov ecx, Result");
         put_line(A,HT &"mov edx, ResultEnd");
         put_line(A,HT &"int 80h");
      end;

      procedure Look_For_Next_Write is
      begin
         Clean_and_Read;
         Skip_Line(f);
         WRITE_value:=Token_Buffer;
         Skip_line(f);
      end;


   procedure Check_Quads_for_num is
      right_op:Bounded_String;
      left_op:Bounded_String;
      right_c:character;
      left_c:character;
      lit:bounded_string;
      right_bool:boolean;
      left_bool:boolean;
   begin
      lit:=to_bounded_string("lit");
      for s in 0..Row_Overhead-1 loop
         right_bool:=false;
         left_bool:=false;
         right_op:=quad_array(s,Right_Operand);
         left_op:=Quad_Array(s,left_operand);
         right_c:=element(right_op,1);
         left_c:=element(left_op,1);
         right_bool:=is_digit(right_c);
         left_bool:=is_digit(left_c);
         if right_bool=true then

            quad_array(s,right_operand):=lit&right_op;

         end if;
         if left_bool=true then

            quad_array(s,left_operand):=lit&left_op;

         end if;

      end loop;

   end;


      procedure Instantiate_Operator_Table is
      begin
         -- ";" --
         Operator_Table('=',';'):='>';
         Operator_Table('+',';'):='>';
         Operator_Table('-',';'):='>';
         Operator_Table(')',';'):='>';
         Operator_Table('*',';'):='>';
         Operator_Table('/',';'):='>';
         -- ";" --

         -- "=" --
         Operator_Table(';','='):='<';
         Operator_Table(TH3N,'='):='<';
         -- "=" --

         -- "+" --
         Operator_Table('=','+'):='<';
         Operator_Table('+','+'):='>';
         Operator_Table('-','+'):='>';
         Operator_Table('(','+'):='<';
         Operator_Table(')','+'):='>';
         Operator_Table('*','+'):='>';
         Operator_Table('/','+'):='>';
         Operator_Table(F1,'+'):='<';
         Operator_Table(ODD,'+'):='<';
         Operator_Table(RELOP,'+'):='<';
         -- "+" --

         -- "-" --
         Operator_Table('=','-'):='<';
         Operator_Table('+','-'):='>';
         Operator_Table('-','-'):='>';
         Operator_Table('(','-'):='<';
         Operator_Table(')','-'):='>';
         Operator_Table('*','-'):='>';
         Operator_Table('/','-'):='>';
         Operator_Table(F1,'-'):='<';
         Operator_Table(ODD,'-'):='<';
         Operator_Table(RELOP,'-'):='<';
         -- "-" --

         -- "(" --
         Operator_Table('=','('):='<';
         Operator_Table('+','('):='<';
         Operator_Table('-','('):='<';
         Operator_Table('(','('):='<';
         Operator_Table('*','('):='<';
         Operator_Table('/','('):='<';
         Operator_Table(F1,'('):='<';
         Operator_Table(ODD,'('):='<';
         Operator_Table(RELOP,'('):='<';
         -- "(" --

         -- ")" --
         Operator_Table('+',')'):='>';
         Operator_Table('-',')'):='>';
         Operator_Table('(',')'):='=';
         Operator_Table(')',')'):='>';
         Operator_Table('*',')'):='>';
         Operator_Table('/',')'):='>';
         -- ")" --

         --"*"--
         Operator_Table('=','*'):='<';
         Operator_Table('+','*'):='<';
         Operator_Table('-','*'):='<';
         Operator_Table('(','*'):='<';
         Operator_Table(')','*'):='>';
         Operator_Table('*','*'):='>';
         Operator_Table('/','*'):='>';
         Operator_Table(F1,'*'):='<';
         Operator_Table(ODD,'*'):='<';
         Operator_Table(RELOP,'*'):='<';
         --"*"--

         --"/"--
         Operator_Table('=','/'):='<';
         Operator_Table('+','/'):='<';
         Operator_Table('-','/'):='<';
         Operator_Table('(','/'):='<';
         Operator_Table(')','/'):='>';
         Operator_Table('*','/'):='>';
         Operator_Table('/','/'):='>';
         Operator_Table(F1,'/'):='<';
         Operator_Table(ODD,'/'):='<';
         Operator_Table(RELOP,'/'):='<';
         --"/"--

         --"IF"--
         Operator_Table(TH3N,F1):='<';
         --"IF"

         --"THEN"--
         Operator_Table('+',TH3N):='>';
         Operator_Table('-',TH3N):='>';
         Operator_Table('*',TH3N):='>';
         Operator_Table('/',TH3N):='>';
         Operator_Table(F1,TH3N):='=';
         Operator_Table(ODD,TH3N):='>';
         Operator_Table(RELOP,TH3N):='>';
         --"THEN"--

         --"ODD"--
         Operator_Table(F1,ODD):='<';
         --"ODD"--

         --"RELOP"--
         Operator_Table('+',RELOP):='>';
         Operator_Table('-',RELOP):='>';
         Operator_Table('*',RELOP):='>';
         Operator_Table('/',RELOP):='>';
         Operator_Table(F1,RELOP):='<';
         --"RELOP"--

         --"{"--
         Operator_Table(TH3N,'{'):='<';
         --"{"--

         --"CALL"--
         Operator_Table(TH3N,CALL):='<';
         --"CALL"--
      end;



   end Syntax;
