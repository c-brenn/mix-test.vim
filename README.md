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

* RunCurrentTestFile()
  * Runs all of the tests in the current file.
* RunLastTest()
  * Re-runs the last test.
* RunAllTests()
  * Runs all of the tests in the project -
  Vim's working directory must be the root of the project

Run your tests quickly by mapping these commands.

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
