<div align="center">
    <h1>Mi zsh config</h1>
</div>

This is my Shell configuration. I use `Zsh` because it belongs to POSIX and is highly customizable.

## Zsh plugins

I use `zinit` to manage plugins in my Zsh configuration, significantly enhancing productivity and the command-line experience. Below are the plugins I use and their functionalities:

- **zsh-autosuggestions**: This plugin suggests commands in real-time based on command history, making it quicker to write and execute repetitive commands.
- **zsh-syntax-highlighting**: Highlights the syntax of commands as they are typed, allowing for the identification and correction of errors before execution.
- **zsh-completions**: Adds a wide range of completions for various tools and commands, improving Zsh's autocompletion capabilities.
- **fzf-tab**: Enhances the autocompletion functionality using `fzf`, providing an interactive and efficient search to complete commands and paths.

These plugins are loaded via `zinit` in my `.zshrc` file, ensuring a robust and customizable shell setup.


## Install 

Dependencies: `git`


For installing, just run this command and it will be ready for use:

```
curl https://raw.githubusercontent.com/CLozano03/dotfiles/main/.config/zsh/install.sh | sh && clear && source ~/.zshrc
```

After instalation, you may close terminal window and reopen it. Zsh plugins will automatically install.

## Keybindings

These are the keybindings which I use in my `$SHELL`. Feel free to modify them:

|          Key            | Action                                       |
| ----------------------- | -------------------------------------------- |
| **ctrl + k**            | history search backward                      |
| **ctrl + j**            | history search backward                      |
| **ctrl + backspace**    | remove previous word                         |
| **ctrl + p**            | accept suggestion                            |
| **ctrl + m**            | execute command                              |
| **ctrl + w**            | kill line                                    |
| **ctrl + e**            | edit command line                            |
| **ctrl + a**            | move to next word                            |
| **ctrl + s**            | move to previous word                        |
| **esc + esc**           | add sudo prefix                              |