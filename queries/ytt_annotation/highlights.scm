; The Annotation Name (e.g. library/module)
(annotation_name) @attribute

; Identifiers
(identifier) @variable
; Arguments & Parameters
(argument_pair
  name: (identifier) @variable.parameter)
(annotation
  (argument_pair
    name: (identifier) @property))

; Function Calls
(function_call
  function: (identifier) @function.call)

; Function Definitions (Lambda)
(lambda
  "lambda" @keyword.function)
(parameter_list
  (identifier) @variable.parameter)

; Dictionary Keys
(pair
  key: (identifier) @property)

; Control Flow Keywords
[
  "if"
  "else" 
] @keyword.conditional

(return_statement "return" @keyword.return)

; Operators
[
  "and" "or" "not" "in"
] @keyword.operator

[
  "+" "-" "*" "/" "%"
  "<" "<=" ">" ">=" "==" "!="
  "="
] @operator

; Literals
(boolean) @boolean
(none) @constant.builtin
(integer) @number
(float) @number
(string) @string

; Punctuation
[
  "(" ")"
  "[" "]"
  "{" "}"
] @punctuation.bracket

[
  ","
  ":"
] @punctuation.delimiter

; Comments
(comment) @comment
