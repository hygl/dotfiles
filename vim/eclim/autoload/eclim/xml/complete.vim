" Author:  Eric Van Dewoestine
" Version: $Revision: 1447 $
"
" Description: {{{
"   see http://eclim.sourceforge.net/vim/xml/complete.html
"
" License:
"
" Copyright (c) 2005 - 2006
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"      http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
"
" }}}

" Script Varables {{{
  let s:delim = ',,'
  let s:complete_command =
    \ '-command xml_complete -p "<project>" -f "<file>" -o <offset> -d "' .
    \ s:delim . '"'
" }}}

" CodeComplete(findstart, base) {{{
" Handles xml code completion.
function! eclim#xml#complete#CodeComplete (findstart, base)
  if a:findstart
    update

    " locate the start of the word
    let line = getline('.')

    let start = col('.') - 1

    while start > 0 && line[start - 1] =~ '[[:alnum:]_-]'
      let start -= 1
    endwhile

    return start
  else
    if !eclim#project#util#IsCurrentFileInProject()
      return []
    endif

    let offset = eclim#util#GetCharacterOffset() + len(a:base)
    let project = eclim#project#util#GetCurrentProjectName()
    let filename = eclim#project#util#GetProjectRelativeFilePath(expand("%:p"))

    let command = s:complete_command
    let command = substitute(command, '<project>', project, '')
    let command = substitute(command, '<file>', filename, '')
    let command = substitute(command, '<offset>', offset, '')

    let completions = []
    let results = split(eclim#ExecuteEclim(command), '\n')
    if len(results) == 1 && results[0] == '0'
      return
    endif

    for result in results
      let word = substitute(result, '\(.\{-}\)' . s:delim . '.*', '\1', '')
      if getline('.') =~ '\w:\w*\%' . col('.') . 'c'
        let word = substitute(word, '^\w\+:', '', '')
      endif

      let menu = substitute(
        \ result, '.\{-}' . s:delim . '\(.*\)' . s:delim . '.*', '\1', '')
      let menu = eclim#html#util#HtmlToText(menu)

      let info = substitute(result, '.*' . s:delim . '\(.*\)', '\1', '')
      let info = eclim#html#util#HtmlToText(info)

      let dict = {'word': word, 'menu': menu, 'info': info}

      call add(completions, dict)
    endfor

    return completions
  endif
endfunction " }}}

" vim:ft=vim:fdm=marker
