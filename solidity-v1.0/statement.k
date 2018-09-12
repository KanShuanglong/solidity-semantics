

requires "solidity-syntax.k"
requires "configuration.k"

module STATEMENT

imports SOLIDITY-SYNTAX
imports CONFIGURATION

rule S:Statement Ss:Statements => S ~> Ss


rule T:TypeName X:Id ; => #createVar(X,T,#Undef_Value, #mem)

rule S:SimpleExpression3 ; => S

rule <k> X:Id = V:Value => . ... </k>
     <env> ... X |-> #memInfo(N:Int,_) ... </env>
     <currentInstance> #cii(C:Int, Name:Id) </currentInstance>
     <ctId> #cii(C,Name) </ctId>
     <memory> ... N |-> (_ => V:Value) ...  </memory>

rule if (true) S:Statement => S
rule if (false) _:Statement => .
rule if (true) S:Statement else S1:Statement => S
rule if (false) S:Statement else S1:Statement => S1

rule .Statements => .

syntax KItem
       ::= "#pushEnv"
         | "#popEnv"

rule { Ss:Statements } => #pushEnv ~> Ss ~> #popEnv

rule <k> #pushEnv => . ...  </k>
     <env> ENV:Map </env>
     <callStack> .List => ListItem(ENV) ...  </callStack>

rule <k> #popEnv => . ...  </k>
     <env> _ => ENV </env>
     <callStack> ListItem(ENV:Map) => .List ...  </callStack>


endmodule