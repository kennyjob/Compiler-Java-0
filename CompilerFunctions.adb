with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Bounded;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with ada.characters.Latin_1; use ada.characters.Latin_1;


package body CompilerFunctions is

   procedure Transition_Table_Initialization is

   begin

      -- ALPHA COLUMN --
      Transition_Table(0,'A'):=1;
      Transition_Table(1,'A'):=1;
      Transition_Table(2,'A'):=2;
      Transition_Table(3,'A'):=4;
      Transition_Table(4,'A'):=4;
      Transition_Table(5,'A'):=6;
      Transition_Table(6,'A'):=6;
      Transition_Table(7,'A'):=7;
      Transition_Table(8,'A'):=8;
      Transition_Table(9,'A'):=9;
      Transition_Table(10,'A'):=10;
      Transition_Table(11,'A'):=11;
      Transition_Table(12,'A'):=12;
      Transition_Table(13,'A'):=14;
      Transition_Table(14,'A'):=14;
      Transition_Table(15,'A'):=15;
      Transition_Table(16,'A'):=15;
      Transition_Table(17,'A'):=17;
      Transition_Table(18,'A'):=18;
      Transition_Table(19,'A'):=20;
      Transition_Table(20,'A'):=20;
      Transition_Table(21,'A'):=21;
      Transition_Table(22,'A'):=23;
      Transition_Table(23,'A'):=23;
      Transition_Table(24,'A'):=24;
      Transition_Table(25,'A'):=25;
      Transition_Table(26,'A'):=26;
      Transition_Table(28,'A'):=28;
      -- ALPHA COLUMN --

      -- SPACE COLUMN --
      Transition_Table(0,' '):=0;
      Transition_Table(1,' '):=2;
      Transition_Table(3,' '):=4;
      Transition_Table(5,' '):=6;
      Transition_Table(13,' '):=14;
      Transition_Table(15,' '):=15;
      Transition_Table(16,' '):=15;
      Transition_Table(19,' '):=20;
      Transition_Table(22,' '):=23;

      -- SPACE COLUMN --

      -- DIGIT COLUMN --
      Transition_Table(0,'D'):=3;
      Transition_Table(1,'D'):=1;
      Transition_Table(3,'D'):=3;
      Transition_Table(5,'D'):=6;
      Transition_Table(13,'D'):=14;
      Transition_Table(15,'D'):=15;
      Transition_Table(16,'D'):=15;
      Transition_Table(19,'D'):=20;
      Transition_Table(22,'D'):=23;
      -- DIGIT COLUMN --

      -- (=) [EQUAL] --
      Transition_Table(0,'='):=5;
      Transition_Table(1,'='):=2;
      Transition_Table(3,'='):=4;
      Transition_Table(5,'='):=7;
      Transition_Table(13,'='):=14;
      Transition_Table(15,'='):=15;
      Transition_Table(16,'='):=15;
      Transition_Table(19,'='):=21;
      Transition_Table(22,'='):=24;
      Transition_Table(27,'='):=28;
      -- (=) [EQUAL] --

      -- (,) [COMMA] --
      Transition_Table(0,','):=8;
      Transition_Table(1,','):=2;
      Transition_Table(3,','):=4;
      Transition_Table(5,','):=6;
      Transition_Table(13,','):=14;
      Transition_Table(15,','):=15;
      Transition_Table(16,','):=15;
      Transition_Table(19,','):=20;
      Transition_Table(22,','):=23;
      -- (,) [COMMA] --

      -- (;) [SEMI] --
      Transition_Table(0,';'):=9;
      Transition_Table(1,';'):=2;
      Transition_Table(3,';'):=4;
      Transition_Table(5,';'):=6;
      Transition_Table(13,';'):=14;
      Transition_Table(15,';'):=15;
      Transition_Table(16,';'):=15;
      Transition_Table(19,';'):=20;
      Transition_Table(22,';'):=23;
      -- (;) [SEMI] --

      -- (+) [ADD] --
      Transition_Table(0,'+'):=10;
      Transition_Table(1,'+'):=2;
      Transition_Table(3,'+'):=4;
      Transition_Table(5,'+'):=6;
      Transition_Table(13,'+'):=14;
      Transition_Table(15,'+'):=15;
      Transition_Table(16,'+'):=15;
      Transition_Table(19,'+'):=20;
      Transition_Table(22,'+'):=23;
      -- (+) [ADD] --

      -- (-) [SUB] --
      Transition_Table(0,'-'):=11;
      Transition_Table(1,'-'):=2;
      Transition_Table(3,'-'):=4;
      Transition_Table(5,'-'):=6;
      Transition_Table(13,'-'):=14;
      Transition_Table(15,'-'):=15;
      Transition_Table(16,'-'):=15;
      Transition_Table(19,'-'):=20;
      Transition_Table(22,'-'):=23;
      -- (-) [SUB] --

      -- (*) [MOP] --
      Transition_Table(0,'*'):=12;
      Transition_Table(1,'*'):=2;
      Transition_Table(3,'*'):=4;
      Transition_Table(5,'*'):=6;
      Transition_Table(13,'*'):=15;
      Transition_Table(15,'*'):=16;
      Transition_Table(16,'*'):=15;
      Transition_Table(19,'*'):=20;
      Transition_Table(22,'*'):=23;
      -- (*) [MOP] --

      -- (/) [DOP] --
      Transition_Table(0,'/'):=13;
      Transition_Table(1,'/'):=2;
      Transition_Table(3,'/'):=4;
      Transition_Table(5,'/'):=6;
      Transition_Table(13,'/'):=14;
      Transition_Table(15,'/'):=15;
      Transition_Table(16,'/'):=0;
      Transition_Table(19,'/'):=20;
      Transition_Table(22,'/'):=23;
      -- (/) [DOP] --

      -- {(} [LP] --
      Transition_Table(0,'('):=17;
      Transition_Table(1,'('):=2;
      Transition_Table(3,'('):=4;
      Transition_Table(5,'('):=6;
      Transition_Table(13,'('):=14;
      Transition_Table(15,'('):=15;
      Transition_Table(16,'('):=15;
      Transition_Table(19,'('):=20;
      Transition_Table(22,'('):=23;
      -- {(} [LP] --

      -- {)} [RP] --
      Transition_Table(0,')'):=18;
      Transition_Table(1,')'):=2;
      Transition_Table(3,')'):=4;
      Transition_Table(5,')'):=6;
      Transition_Table(13,')'):=14;
      Transition_Table(15,')'):=15;
      Transition_Table(16,')'):=15;
      Transition_Table(19,')'):=20;
      Transition_Table(22,')'):=23;
      -- {)} [RP] --

      -- {<} [ROP] --
      Transition_Table(0,'<'):=19;
      Transition_Table(1,'<'):=2;
      Transition_Table(3,'<'):=4;
      Transition_Table(5,'<'):=6;
      Transition_Table(13,'<'):=14;
      Transition_Table(15,'<'):=15;
      Transition_Table(16,'<'):=15;
      Transition_Table(19,'<'):=20;
      Transition_Table(22,'<'):=23;
      -- {<} [ROP] --

      -- {>} [ROP] --
      Transition_Table(0,'>'):=22;
      Transition_Table(1,'>'):=2;
      Transition_Table(3,'>'):=4;
      Transition_Table(5,'>'):=6;
      Transition_Table(13,'>'):=14;
      Transition_Table(15,'>'):=15;
      Transition_Table(16,'>'):=15;
      Transition_Table(19,'>'):=20;
      Transition_Table(22,'>'):=23;
      -- {>} [ROP] --

      -- ({) [LB] --
      Transition_Table(0,'{'):=25;
      Transition_Table(1,'{'):=2;
      Transition_Table(3,'{'):=4;
      Transition_Table(5,'{'):=6;
      Transition_Table(13,'{'):=14;
      Transition_Table(15,'{'):=15;
      Transition_Table(16,'{'):=15;
      Transition_Table(19,'{'):=20;
      Transition_Table(22,'{'):=23;
      -- ({) [LB] --

      -- (}) [RB] --
      Transition_Table(0,'}'):=26;
      Transition_Table(1,'}'):=2;
      Transition_Table(3,'}'):=4;
      Transition_Table(5,'}'):=6;
      Transition_Table(13,'}'):=14;
      Transition_Table(15,'}'):=15;
      Transition_Table(16,'}'):=15;
      Transition_Table(19,'}'):=20;
      Transition_Table(22,'}'):=23;
      -- (}) [RB] --

      -- (!) [RB] --
      Transition_Table(0,'!'):=27;
      Transition_Table(1,'!'):=2;
      Transition_Table(3,'!'):=4;
      Transition_Table(5,'!'):=6;
      Transition_Table(13,'!'):=14;
      Transition_Table(15,'!'):=15;
      Transition_Table(16,'!'):=15;
      Transition_Table(19,'!'):=20;
      Transition_Table(22,'!'):=23;
      -- (!) [RB] --

   end;


   --STOP HERE!!!!--
   -- PROCESS CODE FUNCTION --

   -- DEQUEUE FUNCTION --

   procedure Print_to_file is
      t,s:Token_Range;
   begin
      Create(H,Out_File,"Token_Table_Q1.txt");

         for t in 0..Table_Overhead loop
            put(H,To_String(token_array(t,0)));put(H,"  ");
            put_line(H,To_String(token_array(t,1)));

         end loop;

      Close(H);
      Create(G,Out_File,"Symbol_Table_Q1.txt");

         for s in 0..Real_Overhead loop
            put(G,To_String(Real_Symbol_Array(s,Symbol)));put(G,"  ");
            put(G,To_String(Real_Symbol_Array(s,Classification)));put(G,"  ");
            put(G,To_String(Real_Symbol_Array(s,Value)));put(G,"  ");
            put(G,To_String(Real_Symbol_Array(s,Address)));put(G,"  ");
            put_line(G,To_String(Real_Symbol_Array(s,Segment)));
         end loop;

      Close(G);


   end;

   procedure Add_To_Symbol_Table is
      t,s,i,Table_Size:token_range;
      lit:Bounded_String;
   begin
      --Table_Size:=Table_Overhead;

      --Table_Overhead:=0;
      Real_Overhead:=0;
      Real_Address_Counter:=0;
      lit:=to_bounded_string("lit");
      for t in 0..Table_Overhead loop
         Variable_Counter:=0;
         if Token_Array(t,1)="$program name" then
            Real_Symbol_Array(Real_Overhead,Symbol):=Token_Array(t,0);
            Real_Symbol_Array(Real_Overhead,Classification):=To_Bounded_String("$program name");
            Real_Symbol_Array(Real_Overhead,Address):=To_Bounded_String("0");
            Real_Symbol_Array(Real_Overhead,Segment):=To_Bounded_String("CS");
            Real_Overhead:=Real_Overhead+1;
         elsif Token_Array(t,1)="Const_var" then

            Identifier_Array(Identifier_Overhead):=Token_Array(t,0);
            Identifier_Overhead:=Identifier_Overhead+1;

            for i in 0..Identifier_Overhead loop
               if Identifier_Array(i)=Token_array(t,0) then
                  Variable_Counter:=Variable_Counter+1;
               end if;
            end loop;

            if Variable_Counter<2 then
               Real_Symbol_Array(Real_Overhead,Symbol):=Token_Array(t,0);
               Real_Symbol_Array(Real_Overhead,Classification):=To_Bounded_String("Const_Var");
               Real_Symbol_Array(Real_Overhead,Value):=Token_Array(t+2,0);
               Real_Symbol_Array(Real_Overhead,Address):=To_Bounded_String(integer'image(Real_Address_Counter));
               Real_Symbol_Array(Real_Overhead,Segment):=To_Bounded_String("DS");
               Real_Address_Counter:=Real_Address_Counter+2;
               Real_Overhead:=Real_Overhead+1;
            end if;

         elsif Token_Array(t,1)="Var" then

            Identifier_Array(Identifier_Overhead):=Token_Array(t,0);
            Identifier_Overhead:=Identifier_Overhead+1;
            for i in 0..Identifier_Overhead loop
               if Identifier_Array(i)=Token_array(t,0) then
                  Variable_Counter:=Variable_Counter+1;
               end if;
            end loop;
            if Variable_Counter<2 then

               Real_Symbol_Array(Real_Overhead,Symbol):=Token_Array(t,0);
               Real_Symbol_Array(Real_Overhead,Classification):=To_Bounded_String("Var");
               Real_Symbol_Array(Real_Overhead,Value):=To_Bounded_String("?");
               Real_Symbol_Array(Real_Overhead,Address):=To_Bounded_String(integer'image(Real_Address_Counter));
               Real_Symbol_Array(Real_Overhead,Segment):=To_Bounded_String("DS");
               Real_Address_Counter:=Real_Address_Counter+2;
               Real_Overhead:=Real_Overhead+1;

            end if;



         elsif Token_Array(t,1)="Numeric_Literal" then
            Real_Symbol_Array(Real_Overhead,Symbol):=lit&Token_Array(t,0);
            Real_Symbol_Array(Real_Overhead,Classification):=To_Bounded_String("Numeric Literal");
            Real_Symbol_Array(Real_Overhead,Value):=Token_Array(t,0);
            Real_Symbol_Array(Real_Overhead,Address):=To_Bounded_String(integer'image(Real_Address_Counter));
            Real_Symbol_Array(Real_Overhead,Segment):=To_Bounded_String("DS");
            Real_Address_Counter:=Real_Address_Counter+2;
            Real_Overhead:=Real_Overhead+1;
         else
            null;
         end if;
      end loop;
   end;




   procedure Add_Token is
      whatever:character;
      Check_num:boolean;
      lit:Bounded_String;
   begin
      if Token_Buffer=("") then
         null;
      else

         if token_buffer="CLASS" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$class");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$class");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;



            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


            Symbol_Overhead:=Symbol_Overhead+1;







         elsif token_buffer="IF" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$if");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$if");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;


            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));



            Symbol_Overhead:=Symbol_Overhead+1;






         elsif token_buffer="VAR" then
            Check_Const:=False;
            Check_Var:=True;
            Token_Array(Table_Overhead,1):=To_Bounded_String("$VARDeclaration");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$VARDeclaration");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;



            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));

            Symbol_Overhead:=Symbol_Overhead+1;

         elsif token_buffer="THEN" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$then");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$then");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;

            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));



            Symbol_Overhead:=Symbol_Overhead+1;


         elsif token_buffer="PROCEDURE" then
            Check_Procedure:=True;
            Token_Array(Table_Overhead,1):=To_Bounded_String("$procedure");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$procedure");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;


            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


            Symbol_Overhead:=Symbol_Overhead+1;


         elsif token_buffer="WHILE" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$while");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$while");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;


            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


            Symbol_Overhead:=Symbol_Overhead+1;

         elsif token_buffer="READ" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$read");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$read");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;


            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


            Symbol_Overhead:=Symbol_Overhead+1;


         elsif token_buffer="WRITE" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$write");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$write");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;


            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


            Symbol_Overhead:=Symbol_Overhead+1;


         elsif token_buffer="CALL" then
            Check_Procedure:=True;
            Token_Array(Table_Overhead,1):=To_Bounded_String("$call");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$call");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;


            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));



            Symbol_Overhead:=Symbol_Overhead+1;


         elsif token_buffer="DO" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$do");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$do");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;

            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));




            Symbol_Overhead:=Symbol_Overhead+1;



         elsif token_buffer="ODD" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$odd");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$odd");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;


            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


            Symbol_Overhead:=Symbol_Overhead+1;



         elsif token_buffer="CONST" then
            Check_Var:=False;
            Check_Const:=True;
            Token_Array(Table_Overhead,1):=To_Bounded_String("$const");
            Token_Array(Table_Overhead,0):=Token_Buffer;

            Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
            Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$const");
            Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

            Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
            Address_Counter:=Address_Counter+2;

            put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
            put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

            put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
            put_line(To_String(Symbol_Array(Symbol_Overhead,4)));



            Symbol_Overhead:=Symbol_Overhead+1;



         elsif token_buffer="=" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$=");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="," then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$comma");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer=";" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$semi");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="+" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$addop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="-" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$addop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="*" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$mop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="/" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$mop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="(" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$LP");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer=")" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$RP");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="<" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$relop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer=">" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$relop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="{" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$LB");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="}" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$RB");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="==" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$relop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer=">=" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$relop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="<=" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$relop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer="!=" then
            Token_Array(Table_Overhead,1):=To_Bounded_String("$relop");
            Token_Array(Table_Overhead,0):=Token_Buffer;
         elsif token_buffer=" " then
            null;
         else
            whatever:=Element(Token_Buffer,1);
            Check_num:=is_digit(whatever);
            if check_num = true then
               lit:=To_Bounded_String("lit");
               Token_Array(Table_Overhead,1):=To_Bounded_String("Numeric_Literal");
               Token_Array(Table_Overhead,0):=Token_Buffer;

               Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
               Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$Numeric_Literal");

               Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

               Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));


               Address_Counter:=Address_Counter+2;

               if Check_Const=true then
                  Symbol_Overhead:=Symbol_Overhead-1;
                  Symbol_Array(Symbol_Overhead,2):=Token_Buffer;
                  Symbol_Overhead:=Symbol_Overhead+1;
               end if;

               put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
               put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

               put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
               put_line(To_String(Symbol_Array(Symbol_Overhead,4)));



               Symbol_Overhead:=Symbol_Overhead+1;

            elsif Check_program_name=True then
               Token_Array(Table_Overhead,1):=To_Bounded_String("$program name");
               Token_Array(Table_Overhead,0):=Token_Buffer;

               Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
               Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$program name");
               Symbol_Array(Symbol_Overhead,4):=To_Bounded_String("0");
               Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("CS");

               put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
               put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

               put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
               put_line(To_String(Symbol_Array(Symbol_Overhead,4)));



               Symbol_Overhead:=Symbol_Overhead+1;

               Check_program_name:=False;
            else
               if Check_Var=True  then
                  if Check_Procedure=True then
                     Token_Array(Table_Overhead,1):=To_Bounded_String("Function_Name");
                     Token_Array(Table_Overhead,0):=Token_Buffer;

                     Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
                     Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("$Function_Name");

                     Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

                     Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
                     Address_Counter:=Address_Counter+2;

                     put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
                     put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

                     put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
                     put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


                     Symbol_Overhead:=Symbol_Overhead+1;

                     Check_Procedure:=False;
                  else

                     Token_Array(Table_Overhead,1):=To_Bounded_String("Var");
                     Token_Array(Table_Overhead,0):=Token_Buffer;

                     Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
                     Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("Var");
                     Symbol_Array(Symbol_Overhead,2):=To_Bounded_String("?");
                     Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

                     Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
                     Address_Counter:=Address_Counter+2;

                     put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
                     put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

                     put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
                     put(To_String(Symbol_Array(Symbol_Overhead,2)));put("  ");
                     put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


                     Symbol_Overhead:=Symbol_Overhead+1;


                  end if;



               elsif Check_Const=True then

                  Token_Array(Table_Overhead,1):=To_Bounded_String("Const_var");
                  Token_Array(Table_Overhead,0):=Token_Buffer;

                  Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
                  Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("const_var");

                  Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

                  Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));
                  Address_Counter:=Address_Counter+2;

                  put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
                  put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");
                  put(To_String(Symbol_Array(Symbol_Overhead,2)));put("  ");
                  put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
                  put_line(To_String(Symbol_Array(Symbol_Overhead,4)));


                  Symbol_Overhead:=Symbol_Overhead+1;



               elsif Check_Procedure=True then

                  Token_Array(Table_Overhead,1):=To_Bounded_String("Function_Name");
                  Token_Array(Table_Overhead,0):=Token_Buffer;

                  Symbol_Array(Symbol_Overhead,0):=Token_Buffer;
                  Symbol_Array(Symbol_Overhead,1):=To_Bounded_String("Function_name");

                  Symbol_Array(Symbol_Overhead,3):=To_Bounded_String("DS");

                  Symbol_Array(Symbol_Overhead,4):=To_Bounded_String(integer'image(Address_Counter));



                  Address_Counter:=Address_Counter+2;
                  put(To_String(Symbol_Array(Symbol_Overhead,0)));put("  ");
                  put(To_String(Symbol_Array(Symbol_Overhead,1)));put("  ");

                  put(To_String(Symbol_Array(Symbol_Overhead,3)));put("  ");
                  put_line(To_String(Symbol_Array(Symbol_Overhead,4)));



                  Symbol_Overhead:=Symbol_Overhead+1;

                  Check_Procedure:=False;
               end if;

            end if;
         end if;

         put(To_String(token_array(table_overhead,0)));put("  ");
         put_line(To_String(token_array(table_overhead,1)));



         Table_Overhead:=Table_Overhead+1;
         Token_buffer:=To_Bounded_String("");




      end if;



   end;



   -- STATE MACHINE --
   procedure STATE_MACHINE is
      finished:boolean;
      F:File_Type;
      Buffer:Character;
      --Result_Alpha:Boolean;
      --Result_Digit:Boolean;
      Actual:Character;
      Symbol:Character;
      Check_program_name:boolean;
   begin
      Transition_Table_Initialization;
      Symbol_Overhead:=0;
      Address_Counter:=0;
      Check_program_name:=True;
      Open (F, In_File, "C_option_1.txt");
      while not End_Of_File(F) loop
         next_state:=0;
         finished:=false;
         while not finished loop
            case next_state is
            when 0=>
               put_line("state 0");
               Get_Immediate(F,Buffer);
               put(buffer);
               if buffer/= ' ' then
                  Actual:=Buffer;
               end if;
               Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
               Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
               case Result_Alpha is
               when True=>Buffer:='A';
               when others=>null;
               end case;
               case Result_Digit is
               when True=>Buffer:='D';
               when others=>null;
               end case;
               next_state:=Transition_Table(0,buffer);
               if next_state=0 then
                  Get_Immediate(F,buffer);
                  if buffer/= ' ' then
                     Actual:=Buffer;
                  end if;
                  Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
                  Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
                  case Result_Alpha is
                  when True=>Buffer:='A';
                  when others=>null;
                  end case;
                  case Result_Digit is
                  when True=>Buffer:='D';
                  when others=>null;
                  end case;
                  next_state:=transition_Table(0,buffer);
               end if;
            when 1=>
               put_line("state 1");
               Append(Token_buffer,Actual);

               Get_Immediate(F,Buffer);
               if buffer/= ' ' then
                  Actual:=Buffer;
               end if;
               Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
               Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
               case Result_Alpha is
               when True=>Buffer:='A';
               when others=>null;
               end case;
               case Result_Digit is
               when True=>Buffer:='D';
               when others=>null;
               end case;
               next_state:=Transition_Table(1,buffer);
               if next_state=1 then
                  Append(Token_buffer,Actual);
                  Get_Immediate(F,buffer);
                  if buffer/= ' ' then
                     Actual:=Buffer;
                  end if;
                  Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
                  Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
                  case Result_Alpha is
                  when True=>Buffer:='A';
                  when others=>null;
                  end case;
                  case Result_Digit is
                  when True=>Buffer:='D';
                  when others=>null;
                  end case;
                  next_state:=transition_Table(1,buffer);
               end if;
            when 2=>
               put_line("state 2");
               put(buffer);
               Add_Token;
               if buffer/= ' ' then
                  symbol:=buffer;
                  Append(Token_buffer,symbol);
                  Add_Token;
               end if;
               finished:=true;

            when 3=>
               put_line("state 3");
               Append(Token_buffer,Actual);

               Get_Immediate(F,Buffer);
               if buffer/= ' ' then
                  Actual:=Buffer;
               end if;
               Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
               Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
               case Result_Alpha is
               when True=>Buffer:='A';
               when others=>null;
               end case;
               case Result_Digit is
               when True=>Buffer:='D';
               when others=>null;
               end case;
               next_state:=Transition_Table(3,buffer);
               if next_state=3 then
                  Append(Token_buffer,Actual);
                  Get_Immediate(F,buffer);
                  if buffer/= ' ' then
                     Actual:=Buffer;
                  end if;
                  Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
                  Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
                  case Result_Alpha is
                  when True=>Buffer:='A';
                  when others=>null;
                  end case;
                  case Result_Digit is
                  when True=>Buffer:='D';
                  when others=>null;
                  end case;
                  next_state:=transition_Table(3,buffer);
               end if;

            when 4=>
               put_line("state 4");
               Add_Token;
               if buffer/= ' ' then
                  symbol:=buffer;
                  Append(Token_buffer,symbol);
                  Add_Token;
               end if;
               finished:=true;

            when 5=>
               put_line("state 5");
               Append(Token_buffer,Actual);

               Get_Immediate(F,Buffer);
               if buffer/= ' ' then
                  Actual:=Buffer;
               end if;
               Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
               Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
               case Result_Alpha is
               when True=>Buffer:='A';
               when others=>null;
               end case;
               case Result_Digit is
               when True=>Buffer:='D';
               when others=>null;
               end case;
               next_state:=Transition_Table(5,buffer);

            when 6=>
               put_line("state 6");

               Add_Token;
               finished:=true;

            when 7=>
               put_line("state 7");
               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 8=>
               put_line("state 8");
               Add_Token;
               finished:=true;

            when 9=>
               put_line("state 9");
               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 10=>
               put_line("state 10");
               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 11=>
               put_line("state 11");

               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 12=>
               put_line("state 12");
               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 13=>

               put_line("state 13");
               Get_Immediate(F,Buffer);
               if buffer/= ' ' then
                  Actual:=Buffer;
               end if;
               Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
               Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
               case Result_Alpha is
               when True=>Buffer:='A';
               when others=>null;
               end case;
               case Result_Digit is
               when True=>Buffer:='D';
               when others=>null;
               end case;
               next_state:=Transition_Table(13,buffer);
               put(buffer);
            when 14=>

               put_line("state 14");

               Append(Token_buffer,Actual);
               put_line(to_string(token_buffer));
               Add_Token;
               finished:=true;

            when 15=>
               put_line("state 15");
               next_state:=Transition_Table(15,buffer);
               if next_state=15 then
                  Get_Immediate(F,Buffer);
                  if buffer/= ' ' then
                     Actual:=Buffer;
                  end if;
                  Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
                  Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
                  case Result_Alpha is
                  when True=>Buffer:='A';
                  when others=>null;
                  end case;
                  case Result_Digit is
                  when True=>Buffer:='D';
                  when others=>null;
                  end case;

                  if buffer= '.' then
                     next_state:=Transition_Table(15,'*');
                  else
                     next_state:=Transition_Table(15,buffer);
                  end if;
               end if;

            when 16=>
               put_line("state 16");
               Get_Immediate(F,Buffer);
               next_state:=Transition_Table(16,buffer);

            when 17=>
               put_line("state 17");

               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 18=>

               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 19=>

               Append(Token_buffer,Actual);
               Get_Immediate(F,Buffer);
               if buffer/= ' ' then
                  Actual:=Buffer;
               end if;
               Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
               Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
               case Result_Alpha is
               when True=>Buffer:='A';
               when others=>null;
               end case;
               case Result_Digit is
               when True=>Buffer:='D';
               when others=>null;
               end case;
               next_state:=Transition_Table(19,buffer);


            when 20=>

               Add_Token;
               finished:=true;

            when 21=>


               put(symbol);
               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 22=>

               Append(Token_buffer,Actual);
               Get_Immediate(F,Buffer);
               if buffer/= ' ' then
                  Actual:=Buffer;
               end if;
               Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
               Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
               case Result_Alpha is
               when True=>Buffer:='A';
               when others=>null;
               end case;
               case Result_Digit is
               when True=>Buffer:='D';
               when others=>null;
               end case;
               next_state:=Transition_Table(22,buffer);


            when 23=>


               Add_Token;
               finished:=true;

            when 24=>

               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 25=>

               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when 26=>

               Add_Token;
               if buffer/= ' ' then
                  symbol:=buffer;
                  Append(Token_buffer,symbol);
                  Add_Token;
               end if;
               finished:=true;

            when 27=>

               Append(Token_buffer,Actual);
               Get_Immediate(F,Buffer);
               if buffer/= ' ' then
                  Actual:=Buffer;
               end if;
               Result_Alpha:=Ada.Characters.Handling.Is_Basic(Buffer);
               Result_Digit:=Ada.Characters.Handling.Is_Digit(Buffer);
               case Result_Alpha is
               when True=>Buffer:='A';
               when others=>null;
               end case;
               case Result_Digit is
               when True=>Buffer:='D';
               when others=>null;
               end case;
               next_state:=Transition_Table(22,buffer);

            when 28=>

               Append(Token_buffer,Actual);
               Add_Token;
               finished:=true;

            when others=>null;
            end case;
         end loop;
      end loop;
      Close(F);
   end;
   -- STATE MACHINE --

   procedure Scan_For_Const is -- this should create a const and var section for the .asm file.
   begin
      current_table_overhead:=Real_Overhead;
      Compiler_Temp_Counter:=1;
      Initialized_Data_Overhead:=0;
      Uninitialized_Data_Overhead:=0;
      Symbol_table_Overhead:=1;
      while Symbol_table_Overhead<current_table_overhead loop
         B_String_to_Class;
         case class_state is
         when Const_Var=>Save_Into_Const_Table;
         when Numeric_Literal=>Save_Into_Const_Table;
         when Var=>Save_Into_Var_Table;
         when others=>null;
         end case;
         Symbol_table_Overhead:=Symbol_table_Overhead+1;
      end loop;
      Add_Temps_To_Var_Table;
   end;

   procedure B_String_to_Class is
   begin
      if Real_Symbol_Array(Symbol_table_Overhead,classification)=To_Bounded_String("Const_Var") then
         class_state:=Const_Var;
      elsif Real_Symbol_Array(Symbol_table_Overhead,classification)=To_Bounded_String("Numeric Literal") then
         class_state:=Numeric_Literal;
      elsif Real_Symbol_Array(Symbol_table_Overhead,classification)=To_Bounded_String("Var") then
         class_state:=Var;
      end if;
   end;

   procedure Save_Into_Const_Table is
   begin
      Initialized_Data_Table(Initialized_Data_Overhead,0):=Real_Symbol_Array(Symbol_table_Overhead,symbol);
      Initialized_Data_Table(Initialized_Data_Overhead,1):=To_Bounded_String("DW");
      Initialized_Data_Table(Initialized_Data_Overhead,2):=Real_Symbol_Array(Symbol_table_Overhead,Value);
      Initialized_Data_Overhead:=Initialized_Data_Overhead+1;
   end;

   procedure Save_Into_Const_Table_Numerical is

   begin

      Initialized_Data_Table(Initialized_Data_Overhead,0):=Real_Symbol_Array(Symbol_table_Overhead,symbol);
      Initialized_Data_Table(Initialized_Data_Overhead,1):=To_Bounded_String("DW");
      Initialized_Data_Table(Initialized_Data_Overhead,2):=Real_Symbol_Array(Symbol_table_Overhead,Value);
      Initialized_Data_Overhead:=Initialized_Data_Overhead+1;
   end;

   procedure Save_Into_Var_Table is
   begin
      UnInitialized_Data_Table(Uninitialized_Data_Overhead,0):=Real_Symbol_Array(Symbol_table_Overhead,symbol);
      UnInitialized_Data_Table(UnInitialized_Data_Overhead,1):=To_Bounded_String("RESW");
      UnInitialized_Data_Table(UnInitialized_Data_Overhead,2):=To_Bounded_String("1");
      UnInitialized_Data_Overhead:=UnInitialized_Data_Overhead+1;
   end;

   procedure Add_Temps_To_Var_Table is
   begin
      for i in 1..11 loop
         Temp_Variable_Changer_Compiler;
         UnInitialized_Data_Table(Uninitialized_Data_Overhead,0):=Temp_Version;
         UnInitialized_Data_Table(UnInitialized_Data_Overhead,1):=To_Bounded_String("RESW");
         UnInitialized_Data_Table(UnInitialized_Data_Overhead,2):=To_Bounded_String("1");
         UnInitialized_Data_Overhead:=UnInitialized_Data_Overhead+1;
         Compiler_Temp_Counter:=Compiler_Temp_Counter+1;
      end loop;
   end;

   procedure Temp_Variable_Changer_Compiler is
   begin
      case Compiler_Temp_Counter is
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

   procedure Read_And_Write_both_Tables is
   begin
      Create(temp,Out_File,"Temp.txt");
      for s in 0..initialIzed_Data_Overhead-1 loop
            put(temp,To_String(Initialized_Data_Table(s,0)));put(temp,"  ");
            put(temp,To_String(Initialized_Data_Table(s,1)));put(temp,"  ");
            put_line(temp,To_String(Initialized_Data_Table(s,2)));
      end loop;

      for s in 0..UninitialIzed_Data_Overhead-1 loop
            put(temp,To_String(UnInitialized_Data_Table(s,0)));put(temp,"  ");
            put(temp,To_String(UnInitialized_Data_Table(s,1)));put(temp,"  ");
            put_line(temp,To_String(UnInitialized_Data_Table(s,2)));
      end loop;

      close(temp);
   end;





end CompilerFunctions;
