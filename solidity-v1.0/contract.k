
requires "solidity-syntax.k"
requires "configuration.k"

module CONTRACT

imports SOLIDITY-SYNTAX
imports CONFIGURATION

rule [ContractDefinitions]:
     C:ContractDefinition Cs:ContractDefinitions => C ~> Cs

rule [ContractExecute]:
     Cs:ContractDefinitions E:Exec  => Cs ~> E

rule .ContractDefinitions ~> E:Exec => E

rule [ContractDefinition]:
     <k> contract C:Id { Cs:ContractParts } => #pcsContractParts(C,Cs) ...  </k>
     (.Bag =>
       <Contract>
	  <cname> C </cname>
	  <cfunctions> .Map </cfunctions>
	  <cdata> .Map </cdata>
       </Contract>
     )

syntax SolidityItem
       ::= #pcsContractParts(Id, ContractParts)
         | #pcsContractPart(Id, ContractPart)

rule #pcsContractParts(_:Id, .ContractParts) => .
rule #pcsContractParts(Ct:Id, C:ContractPart Cs:ContractParts) =>
     	   #pcsContractPart(Ct, C) ~> #pcsContractParts(Ct,Cs)
     	

rule <k> new C:Id ( Vs:Values ) => #cinstance(N) ... </k>
     <cntInstances> N:Int => N +Int 1 </cntInstances>
     (.Bag =>
       <contractInstance>
	  <ctId> #cii(N,C) </ctId>
	  <memory> .Map </memory>
	  <balance> 0 </balance>
	  <event> .Map </event>
	  <storage> .Map </storage>
       </contractInstance>
     )


endmodule

