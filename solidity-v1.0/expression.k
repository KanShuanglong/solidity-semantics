

requires "solidity-syntax.k"
requires "configuration.k"


module EXPRESSION

imports SOLIDITY-SYNTAX
imports CONFIGURATION


rule <k> #createVar(X:Id, T:TypeName, V:Value, #mem) => . ... </k>
     <env> ENV:Map => ENV[X <- #memInfo(!N,T)] </env>
     <currentInstance> #cii(C:Int,NAME:Id) </currentInstance>
     <ctId> #cii(C,NAME) </ctId>
     <memory> MEM:Map => MEM[!N <- V] </memory>

rule I1:Int + I2:Int => I1 +Int I2
rule I1:Int - I2:Int => I1 -Int I2
rule I1:Int < I2:Int => I1 <Int I2
rule I1:Int <= I2:Int => I1 <=Int I2

rule <k> X:Id => V ... </k>
     <env> ... X |-> #memInfo(N:Int,_:TypeName) ... </env>
     <currentInstance> #cii(C:Int, NAME:Id) </currentInstance>
     <ctId> #cii(C,NAME) </ctId>
     <memory> ... N |-> V:Value ...  </memory>

rule .ExpressionList => .Values

endmodule


