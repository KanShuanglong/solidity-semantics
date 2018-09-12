

module CONFIGURATION

imports SOLIDITY-SYNTAX

syntax Int
       ::= "#undef_Int"

syntax Id
       ::= "#undef_Id"

syntax ContractInstanceSig
       ::= #cii(Int,Id)

syntax Value
       ::= #cinstance(Int)


syntax KResult
       ::= Value | Values

configuration
  <execution>
    <k> $PGM:SolidityPGM </k>
    <env> .Map </env>
    <callStack> .List </callStack>
    <currentInstance> #cii(#undef_Int,#undef_Id) </currentInstance>
  </execution>

  /*
     The configuration for storing contract definitions
     (1) the cell cfunctions stores the map from function names
     	 to the functions defined in the cell functions
  */

  <contracts>
    <cntContracts> 0:Int </cntContracts>
    <Contract multiplicity="*">
	<cname> .K </cname>
	<cfunctions> .Map </cfunctions>
	<cdata> .Map </cdata>
    </Contract>

    /*
    Modifiers
    */

    <modifier multiplicity="*">
	<mname> .K </mname>
     	<mparameters> .K </mparameters>
     	<condition> .K </condition>
    </modifier>

  /*
    The functions defined in contracts
   */
    <functions>
        <cntFunction> 0:Int </cntFunction>
	<Function multiplicity="*">
           <fId> #undef_Int </fId>
	   <inputParameters> .K </inputParameters>
	   <outputParameters> .K </outputParameters>
	   <FunQuantifiers> .K </FunQuantifiers>
	   <body> .K </body>
	</Function>
    </functions>
  </contracts>

  /******************** struct ****************/
  
  <structs>
    <struct multiplicity="*">
    	 <sname> .K </sname>
	 <sfields> .Map </sfields>
    </struct>
  </structs>

  /**********************************
    Contract Instance

    (1) the cell cntContracts is for generating the address (or unique index) for each instance,
        it is also the size of the instance,
    (2) 
  ***********************************/

  <contractInstances>
     <cntInstances> 0:Int </cntInstances>
     <contractInstance multiplicity="*">     		   
         <ctId> .K  </ctId>
	 <memory> .Map </memory>
	 <balance> #undef_Int </balance>
	 <event> .Map </event>
	 <storage> .Map </storage>
     </contractInstance>
  </contractInstances>


endmodule