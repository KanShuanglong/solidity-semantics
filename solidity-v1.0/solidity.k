
requires "solidity-syntax.k"
requires "configuration.k"
requires "function.k"
requires "contract.k"
requires "expression.k"
requires "statement.k"

module SOLIDITY

imports SOLIDITY-SYNTAX
imports CONFIGURATION
imports FUNCTION
imports CONTRACT
imports EXPRESSION
imports STATEMENT

rule #execute(E:Expression) => E

endmodule