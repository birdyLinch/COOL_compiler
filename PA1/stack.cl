
(*
 *  This file shows how to implement a Stack data type for Stacks of Stringegers.
 *  It makes use of INHERITANCE and DYNAMIC DISPATCH.
 *
 *  The Stack class has 4 operations defined on Stack objects. If 'l' is
 *  a Stack, then the methods dispatched on 'l' have the following effects:
 *
 *    isNil() : Bool		Returns true if 'l' is empty, false otherwise.
 *    head()  : String		Returns the Stringeger at the head of 'l'.
 *				If 'l' is empty, execution aborts.
 *    tail()  : Stack		Returns the remainder of the 'l',
 *				i.e. without the first element.
 *    cons(i : String) : Stack	Return a new Stack containing i as the
 *				first element, followed by the
 *				elements in 'l'.
 *
 *  There are 2 kinds of Stacks, the empty Stack and a non-empty
 *  Stack. We can think of the non-empty Stack as a specialization of
 *  the empty Stack.
 *  The class Stack defines the operations on empty Stack. The class
 *  Cons inherits from Stack and redefines things to handle non-empty
 *  Stacks.
 *)


class Stack inherits IO {
   -- Define operations on empty Stacks.
   lenth : Int <- 0;

   isNil() : Bool { true };

   element()  : String { { abort(); " ";} };

   tail()  : Stack { { abort(); self; } };

   cons(i : String) : Stack {
      (new Cons).init(i, self)
   };

   get_len() : Int { lenth };

};


class Cons inherits Stack {

   element : String;	-- The element in this Stack cell

   tail : Stack;	-- The rest of the Stack

   isNil() : Bool { false };

   element()  : String { element };

   tail()  : Stack { tail };

   init(i : String, rest : Stack) : Stack {
      {
  
	 element <- i;
	 tail <- rest;
	 lenth <- rest.get_len()+1;
	 self;
      }
   };

};

class StackCommand {

	temp_char1 : String;
	temp_char2 : String;
	temp_int1 : Int;
	temp_int2 : Int;

	push( s : Stack , char : String) : Stack{
		s.cons(char)
	};

	pop( s : Stack ) : Stack{
		s.tail()
	};	

	swap(s : Stack) : Stack{
		{
		temp_char1 <- s.element();
		s <- pop(s);
		temp_char2 <- s.element();
		s <- pop(s);
		s <- push(s,temp_char1);
		s <- push(s,temp_char2);
		s;
		}
	};


	add(s : Stack) : Stack{
		{
		temp_int1 <- (new A2I).a2i(s.element());
		s <- pop(s);
		temp_int2 <- (new A2I).a2i(s.element());
		s <- pop(s);
		temp_char1 <- (new A2I).i2a(temp_int1+temp_int2);
		s <- push(s,temp_char1);
		s;
		}
	};

	evaluate(s : Stack) : Stack{
		if s.get_len() = 0 then s else 
		if s.element() = "+" then {
			s <- pop(s);
			s <- add(s);
			s;
		}else
			if s.element() = "s" then{
				s <- pop(s);
				s <- swap(s);
				s;
			} else s

			fi
		fi
		fi
	};

};

class Main inherits IO{

	x : String;
	s : Stack <- new Stack;
	node : Stack;

	print_stack(s : Stack) : Object{
		{
		node <- s;		
		while not (node.get_len() = 0) loop{
		out_string(node.element());
		out_string("\n");
		node <- node.tail();
		}pool;
		}
	};
 
	main(): Object{
		{		
		out_string(">");
		x <- in_string();
		while not (x ="x") loop{
			if x = "e" then s <- (new StackCommand).evaluate(s) else 
			if x = "d" then print_stack(s) 
			else s <- s.cons(x)
			fi fi;	
			out_string(">");
			x <- in_string();
		}pool;	
		}
	};
};