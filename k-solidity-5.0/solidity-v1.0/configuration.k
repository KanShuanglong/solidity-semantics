

module CONFIGURATION

syntax Int
       ::= "#undef_Int"

configuration
  <k> $PGM:SourceUnit </k>
  <callStack> .List </callStack>

  /*
     The configuration for storing contract definitions
     (1) the cell cfunctions stores the map from function names
     	 to the functions defined in the cell functions
  */

  <contracts>
    <cntContracts> 0:Int </cntContracts>
    <contract multiplicity="*">
	<cname> .K </cname>
	<cfunctions> .Map </cfunctions>
	<ccontext> .Map </ccontext>
    </contract>

    /*
    Modifiers
    */

    <modifier multiplicity="*">
	<mname> .K <mname>
     	<mparameters> .K </mparameters>
     	<condition> .K </condition>
    </modifier>

  /*
    The functions defined in contracts
   */
    <functions>
        <cntFunction> 0:Int </cntFunction>
	<function multiplicity="*">
           <fId> #undef_Int </fId>
	   <inputParameters> .K </inputParameters>
	   <outputParameters> .K </outputParameters>
	   <FunQuantifiers> .K </FunQuantifiers>
	   <body> .K </body>
	</function>
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
     <cntContracts> 0:Int </cntContracts>
     <contractInstance multiplicity="*">     		   
         <ctId> #undef_Int  </ctId>
	 <localMem> .Map </localMem>
	 <balance> #undef_Int </balance>
	 <event> .Map <event>
	 <storage> .Map </storage>
     </contractInstance>
  </contractInstances>


endmodule