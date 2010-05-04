module ParseTree

import Message;

 /*
  * The universal parse tree format. Parse functions always return values of type Tree.
  */
 
data ParseTree = 
     parsetree(Tree top, int amb_cnt);

data Tree =
     appl(Production prod, list[Tree] args) |
	 cycle(Symbol symbol, int cycleLength) |
	 amb(set[Tree] alternatives) | 
	 char(int character);

data Production =
     prod(list[Symbol] lhs, Symbol rhs, Attributes attributes) | 
     regular(Symbol rhs, Attributes attributes);

@deprecated{replaced by regular}
data Production = \list(Symbol rhs);

data Attributes = 
     \no-attrs() | \attrs(list[Attr] attrs);

data Attr =
     assoc(Associativity assoc) | term(value term) |
     id(str moduleName) | bracket() | reject() | prefer() | avoid();

data Associativity =
     \left() | \right() | \assoc() | \non-assoc();

@deprecated{use range(start,start) instead}
data CharRange = single(int start); 

data CharRange = range(int start, int end);

data Constructor = cons(str name);

alias CharClass = list[CharRange];

data Symbol =
     \start() |
     \start(Symbol symbol) |
     \label(str name, Symbol symbol) |
     \lit(str string) |
     \cilit(str string) | 
     \cf(Symbol symbol)  |
     \lex(Symbol symbol)  |
     \empty()  |
     \opt(Symbol symbol)  |
     \sort (str string)  | 
     \iter(Symbol symbol)  | 
     \iter-star(Symbol symbol)  | 
     \iter-sep(Symbol symbol, list[Symbol] separators)  | 
     \iter-star-sep(Symbol symbol, list[Symbol] separators) |
     \layout()  | 
     \char-class(list[CharRange] ranges);
     
@deprecated{Used in SDF2, but not used in Rascal anymore}
data Symbol =
     \iter-sep(Symbol symbol, Symbol separator) |
     \iter-star-sep(Symbol symbol, Symbol separator)  | 
     \alt(Symbol lhs, Symbol rhs)  |
     \tuple(Symbol head, list[Symbol] rest)  |
     \seq(list[Symbol] symbols)  |
     \func(list[Symbol] symbols, Symbol symbol)  | 
     \parameterized-sort(str sort, list[Symbol] parameters)  | 
     \strategy(Symbol lhs, Symbol rhs)  |
     \var-sym(Symbol symbol) | 
     \iter-n(Symbol symbol, int number)  | 
     \iter-sep-n(Symbol symbol, Symbol separator, int number)  ; 
     
@doc{provides access to the source location of a parse tree node}
anno loc Tree@\loc;

@doc{Parse the contents of a resource pointed to by the input parameter and return a parse tree.}
@javaClass{org.rascalmpl.library.ParseTree}
@reflect{uses information about imported SDF modules at call site}
public &T<:Tree java parse(type[&T<:Tree] start, loc input);

@doc{Parse a string and return a parse tree.}
@javaClass{org.rascalmpl.library.ParseTree}
@reflect{uses information about imported SDF modules at call site}
public &T<:Tree java parse(type[&T<:Tree] start, str input);

@doc{Parse the contents of a resource pointed to by the input parameter and return a parse tree.}
@javaClass{org.rascalmpl.library.ParseTree}
@reflect{uses information about imported SDF modules at call site}
public &T<:Tree java parseExperimental(type[&T<:Tree] start, loc input);

@doc{Parse a string and return a parse tree.}
@javaClass{org.rascalmpl.library.ParseTree}
@reflect{uses information about imported SDF modules at call site}
public &T<:Tree java parseExperimental(type[&T<:Tree] start, str input);

@doc{Yields the string of characters that form the leafs of the given parse tree.}
@javaClass{org.rascalmpl.library.ParseTree}
public str java unparse(Tree tree);

@doc{introduces a (error) message related to a certain sub-tree}
public anno Message Tree@message;

@doc{lists all (error) messages relevant for a certain sub-tree}
public anno set[Message] Tree@messages;

@doc{provides a documentation string for this parse tree node}
anno str Tree@doc;

@doc{provides the target of a link}
anno loc Tree@link;
