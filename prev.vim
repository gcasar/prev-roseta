syn keyword conditionalKeywords else if then end
syn keyword repeatKeywords for while
syn keyword declarationKeywords var fun typ sizeof
syn keyword operatorKeywords @ ^
syn keyword scopeKeywords where

hi def link conditionalKeywords Conditional
hi def link repeatKeywords Repeat
hi def link declarationKeywords Keyword
hi def link operatorKeywords Error
hi def link scopeKeywords Keyword

syn keyword basicTypes boolean integer char string void
syn keyword builtinTypes arr ptr

hi def link basicTypes Type
hi def link builtinTypes Type

syn keyword booleanConstant true false
syn keyword genericConstants null none
syn match numberConstant /\d\+/
syn match numberConstant /[-+]\d\+/
syn region stringConstant start=/"/ skip=/\\"/ end=/"/ oneline
syn match charConstant /\'.\'/

hi def link booleanConstant Boolean
hi def link genericConstants Constant
hi def link numberConstant Number
hi def link stringConstant String
hi def link charConstant Character

syn keyword todoComment contained TODO FIXME XXX NOTE
syn match lineComment /#.*$/ contains=todoComment oneline

hi def link todoComment Todo
hi def link lineComment Comment

syn match genericIdentifier /[a-zA-Z_][0-9a-zA-Z_]*/

hi def link genericIdentifier Identifier
