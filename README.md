# mix-test.vim

This is a Elixir (mix) test runner for Vim and MacVim.

## Install

I recommend using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'c-brenn/mix-test.vim'
```

## Configuration

### Mappings

There are three functions available for use:

* MixRunCurrentTestFile()
  * Runs all of the tests in the current file.
* MixRunLastTest()
  * Re-runs the last test.
* MixRunAllTests()
  * Runs all of the tests in the project -
  Vim's working directory must be the root of the project
* MixRunCurrentTest()
  * Runs the test under the cursor

Run your tests quickly by mapping these commands.

### Usage with other testing plugins

This plugin was inspired by rspec.vim and I wanted the two to play nicely with other testing plugins.
To that end I added two functions that determine whether you are in a Mix project
or not so you can have one mapping for running your test/specs.

For example, you can run your Mix tests or Rspec specs depending on the working directory
or the current file like so:

```vim
map <Leader>t :call TestCurrentFile()<CR>
map <Leader>a :call TestAll()<CR>


function! TestCurrentFile()
  if InMixTestFile()
    call MixRunCurrentTestFile() " Test runner from this plugin
  else
    call RunCurrentSpecFile() " Test runner from rspec.vim
  endif
endfunction

function! TestAll()
  if InMixProject()
    call MixRunAllTests() " Test runner from this plugin
  else
    call RunAllSpecs() " Test runner from rspec.vim
  endif
endfunction
```

You should use InMixTestFile() before running all the tests in the current file or for
running the test under the cursor and use InMixProject() before running all the test in
a project or re-running the last test (as it can be rerun from anywhere).

### Custom Command

I recommend using [dispatch](https://github.com/tpope/vim-dispatch) as the test runner.
You can use any command you like by altering `mix_test_command`.

```vim
let g:mix_test_command = "Dispatch mix test {test}"
```

You can also change the default runner to any custom launch script.
There are three provided: one for OSX's terminal and two for iTerm. These can be found in the bin directory.
Alter `mix_test_runnner` to change the default runner.

```vim
let g:mix_test_runner = "os_x_iterm2"
```

These runners are really only needed for MacVim running in a GUI.

## License

This is free software, see the LICENSE file.
