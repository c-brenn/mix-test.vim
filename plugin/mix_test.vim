let s:plugin_path = expand("<sfile>:p:h:h")
let s:default_command = "mix test {test}"
let s:force_gui = 0

if !exists("g:mix_test_runner")
  let g:mix_test_runner = "os_x_terminal"
endif

function! RunAllTests()
  let s:last_test = "test"
  call s:RunTests(s:last_test)
endfunction

function! RunCurrentTestFile()
  if s:InTestFile()
    let s:last_test_file = s:CurrentFilePath()
    let s:last_test = s:last_test_file
    call s:RunTests(s:last_test_file)
  elseif exists("s:last_test_file")
    call s:RunTests(s:last_test_file)
  endif
endfunction

function! RunLastTest()
  if exists("s:last_test")
    call s:RunTests(s:last_test)
  endif
endfunction

function! RunCurrentTest()
  if s:InTestFile()
    let s:last_test_file = s:CurrentFilePath()
    let s:last_test_file_with_line = s:last_test_file . " --only line:" . line(".")
    let s:last_test = s:last_test_file_with_line
    call s:RunTests(s:last_test_file_with_line)
  elseif exists("s:last_test_file_with_line")
    call s:RunTests(s:last_test_file_with_line)
  endif
endfunction

" === local functions ===

function! s:RunTests(test_location)
  let s:mix_test_command = substitute(s:MixTestCommand(), "{test}", a:test_location, "g")

  execute s:mix_test_command
endfunction

function! s:InTestFile()
  return match(expand("%"), "_test.exs$") != -1
endfunction

function! s:MixTestCommand()
  if s:MixTestCommandProvided() && s:IsMacGui()
    let l:command = s:GuiCommand(g:mix_test_command)
  elseif s:MixTestCommandProvided()
    let l:command = g:mix_test_command
  elseif s:IsMacGui()
    let l:command = s:GuiCommand(s:default_command)
  else
    let l:command = s:DefaultTerminalCommand()
  endif

  return l:command
endfunction

function! s:MixTestCommandProvided()
  return exists("g:mix_test_command")
endfunction

function! s:DefaultTerminalCommand()
  return "!" . s:ClearCommand() . " && echo " . s:default_command . " && " . s:default_command
endfunction

function! s:CurrentFilePath()
  return @%
endfunction

function! s:GuiCommand(command)
  return "silent ! '" . s:plugin_path . "/bin/" . g:mix_test_runner . "' '" . a:command . "'"
endfunction

function! s:ClearCommand()
  if s:IsWindows()
    return "cls"
  else
    return "clear"
  endif
endfunction

function! s:IsMacGui()
  return s:force_gui || (has("gui_running") && has("gui_macvim"))
endfunction

function! s:IsWindows()
  return has("win32") && fnamemodify(&shell, ':t') ==? "cmd.exe"
endfunction
