

module SOLIDITY-SYNTAX

import DOMAINS-SYNTAX
import DOMAINS

syntax SolidityPGM
       ::= ContractDefinitions Exec
         | ContractDefinitions

syntax Exec
       ::= #execute( ExecuteContent )

syntax ExecuteContent
       ::= Expression
         | Statements

syntax ContractDefinitions
       ::= List{ContractDefinition, ""}				[klabel(#contractDefs)]

syntax ContractDefinition
       ::= "contract" Id "{" ContractParts "}"			[klabel(#contractDef)]


syntax ContractParts
       ::= List{ContractPart, ""}				[klabel(#contractParts)]

syntax ContractPart
       ::= FunctionDefinition
       

syntax FunctionDefinition
       ::= "function" Id "(" FParameters ")" FunQuanOrNone "returns" "(" FParameters ")" Block

syntax FunQuanOrNone
       ::= FunQuantifier						
         | ""								[klabel(#none)]
         

syntax FParameters
       ::= List{FParameter, ","}					[klabel(#fParameters)]

syntax FParameter
       ::= VariableDeclaration


syntax VariableDeclaration
       ::= TypeName Id							[klabel(#varDeclaration)]

syntax TypeName
       ::= "int"
         | Id


syntax Block
       ::= "{" Statements "}"						[klabel(#block)]

syntax Statements
       ::= List{Statement, ""}						[klabel(#statement)]

syntax Statement
       ::= SimpleStatement   ";"					[klabel(#simpleStmt)]
         | "return" Expression ";"					[klabel(#returnExp),strict]
	 | "if" "(" Expression ")" Statement "else" Statement		[klabel(#ifelsestmt),strict(1)]
	 | "if" "(" Expression ")" Statement 	    			[klabel(#ifstmt),strict(1)]
	 | Block

syntax SimpleStatement
       ::= "var" Id							[klabel(#simpleStmtV)]
         | VariableDeclaration
	 | SimpleExpression3

syntax FunQuantifier
       ::= "public"



syntax FunctionCall
       ::= "functionCall" "(" Id ";" ExpressionList ")"			[klabel(#funCall), strict(2)]
         | "functionCall" "(" Expression ";" Id ";" ExpressionList ")"	[klabel(#funCallContract), strict(1,3)]

syntax Value
       ::= Bool | Int | String 

syntax Values
       ::= List{Value, ","}						//[klabel(#values)]


syntax Expression
       ::= Value | Id
         | FunctionCall
	 | "new" TypeName						[klabel(#newTyInstance)]
	 | Expression "(" ExpressionList ")"				[klabel(#call),strict(2)]
	 | Expression "+" Expression					[klabel(#addexp),strict]
	 | Expression "-" Expression					[klabel(#subexp),strict]
	 | Expression "<" Expression					[klabel(#less),seqstrict]
	 | Expression "<=" Expression					[klabel(#leq),seqstrict]
	 | SimpleExpression3


syntax SimpleExpression3
       ::= Expression "=" Expression					[klabel(#assign),strict(2)]


syntax ExpressionList
       ::= List{Expression, ","}					[strict]
         | Values


/************************** Auxiliary Terms   ***************************/

syntax KItem
       ::= #createVar(Id, TypeName, Value, Id)  //here the last id can only be "#mem" or #storage# to indicates the location of the var
         | "#unit"

syntax Id
       ::= "#mem"
         | "#storage"

syntax Value
       ::= "#Undef_Value"


/*
 #memInfo: the value of the  variable is stored in memory
 #storageInfo: the value of the variable is stored in storage
*/

syntax VarInfo
       ::= #memInfo(Int,TypeName)
         | #storageInfo(Int,TypeName)


/************************** Memory Operation ****************************/


endmodule