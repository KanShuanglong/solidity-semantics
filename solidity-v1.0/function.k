
requires "solidity-syntax.k"
requires "configuration.k"
requires "contract.k"

module FUNCTION

imports SOLIDITY-SYNTAX
imports CONFIGURATION
imports CONTRACT

syntax State
       ::= #state(ContractInstanceSig,Map,K)
         | #state(Map,K)


rule [function-definition]:
     <k> #pcsContractPart(Ct:Id, function F:Id (Ps:FParameters) FQ:FunQuanOrNone returns (Rs:FParameters) B:Block)
            => . ... </k>
     <cname> Ct </cname>
     <cfunctions> .Map => F |-> N ... </cfunctions>
     <cntFunction> N:Int => N +Int 1 </cntFunction>
     (.Bag =>
       <Function>
	   <fId> N  </fId>
	   <inputParameters> Ps </inputParameters>
	   <outputParameters> Rs </outputParameters>
	   <FunQuantifiers> FQ </FunQuantifiers>
	   <body> B </body>
       </Function>
     )

syntax FunAuxItem
       ::= #Call(Id,Values)
         | #InitParams(FParameters, Values)
         | "#return"



rule [ContractFunction-Call]:
     <k> (functionCall(#cinstance(C:Int); F:Id; Vs:Values)
                    => #Call(F,Vs)) ~> RestPGM:K  </k>
     <currentInstance> #cii(C1,N1) => #cii(C,N) </currentInstance>
     <env> Rho:Map => CRho </env>
     <ctId> #cii(C,N:Id) </ctId>
     <callStack> .List => ListItem(#state(#cii(C1,N1), Rho, RestPGM)) ListItem(#unit) ... </callStack>
     <cname> N </cname>
     <cdata> CRho:Map </cdata>


rule [Function-Call]:
     <k> (functionCall(F:Id; Vs:Values) => #Call(F,Vs) ) ~> RestPGM:K  </k>
     <env> ENV:Map  </env>
     <callStack> .List => ListItem(#state(ENV,RestPGM)) ListItem(#unit) ... </callStack> 
     

rule <k> #Call(F:Id, Vs:Values) => #InitParams(Ps, Vs) ~> Ss ~> #return  ...  </k>
     <currentInstance> #cii(C:Int,N:Id) </currentInstance>
     <cname> N:Id </cname>
     <cfunctions> ... F |-> FId:Int ... </cfunctions>
     <fId> FId </fId>
     <inputParameters> Ps:FParameters </inputParameters>
     <body> { Ss:Statements } </body>

     
rule #InitParams(#fParameters(T:TypeName X:Id, Ps:FParameters), V:Value,Vs:Values)
     	    => #createVar(X,T,V,#mem) ~> #InitParams(Ps, Vs)

rule #InitParams(.FParameters, .Values) => .

rule <k> #return  => #returnVal(RV,RestPGM)  </k>
     <callStack> (ListItem(#state(Rho:Map,RestPGM:K)) ListItem(RV)) => .List  ... </callStack>
     <env> _ => Rho </env>

rule <k> #return => #returnVal(RV,RestPGM)  </k>
     <callStack> (ListItem(#state(C:ContractInstanceSig,Rho:Map,RestPGM:K)) ListItem(RV)) => .List ... </callStack>
     <env> _ => Rho </env>
     <currentInstance> _ => C  </currentInstance>

rule <k> return V:Value ; ~> _:K => #return </k>
     <callStack> ListItem(_:State) ListItem(#unit => V) ... </callStack>

rule <k> return V:Value ; => return V ; ...  </k>
     <callStack> ListItem(Rho:Map) => .List ...  </callStack>

syntax FunItem
       ::= #returnVal(K,K)	[function]


rule #returnVal(#unit, P:K) => P
rule #returnVal(V:Value, P:K) => V ~> P

endmodule



