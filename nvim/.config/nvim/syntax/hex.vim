" Vim syntax file
" Language: Hexdump
" Maintainer: Jonas Toth
" Latest Revision: 12. June 2026

if exists("b:current_syntax")
  finish
endif


syn match hexGap1 '  '
syn match hexZero           '00'
syn match hexAsciiWhite     '0[789aAbBcCdD]'
syn match hexLows01         '0[1-6]'
syn match hexLows02         '0[eEfF]'
syn match hexLows03         '1[0-9a-fA-F]'
syn match hexAsciiSpecial01 '2[0-9a-fA-F]'
syn match hexAsciiNumbers   '3[0-9]'
syn match hexAsciiSpecial02 '3[a-fA-F]'
syn match hexAsciiSpecial03 '40'
syn match hexAsciiChars01   '4[1-9a-fA-F]'
syn match hexAsciiChars02   '5[0-9aA]'
syn match hexAsciiSpecial04 '5[b-fB-F]'
syn match hexAsciiSpecial05 '60'
syn match hexAsciiChars03   '6[1-9a-fA-F]'
syn match hexAsciiChars04   '7[0-9aA]'
syn match hexAsciiSpecial06 '7[b-fB-F]'
syn match hexHighs          '[8-9a-fA-F][0-9a-fA-F]'
syn match hexAddress        '[0-9a-fA-F]\{8\}' nextgroup=hexGap1

hi def link hexAddress          Constant
hi def link hexGap1             Comment

hi def link hexZero             Comment
hi def link hexLows01           Constant
hi def link hexLows02           Constant
hi def link hexLows03           Constant
hi def link hexAsciiWhite       Identifier
hi def link hexAsciiNumbers     Number
hi def link hexAsciiSpecial01   Identifier
hi def link hexAsciiSpecial02   Function
hi def link hexAsciiSpecial03   Function
hi def link hexAsciiSpecial04   Character
hi def link hexAsciiSpecial05   Function
hi def link hexAsciiSpecial06   Character
hi def link hexAsciiChars01     Character
hi def link hexAsciiChars02     Character
hi def link hexAsciiChars03     Character
hi def link hexAsciiChars04     Character
hi def link hexHighs            Constant

syn match hexAsciiRep '|.*|$'
hi def link hexAsciiRep         Comment
