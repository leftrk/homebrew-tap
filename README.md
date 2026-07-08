# homebrew-tap

Homebrew tap for [leftrk](https://github.com/leftrk)'s tools.

## Install

```bash
brew install leftrk/tap/openclaude
brew install leftrk/tap/rmsafe
brew install --cask leftrk/tap/typeback
brew install --cask leftrk/tap/wordroot
```

## Tools

| Name | Type | Description |
|------|------|-------------|
| `openclaude` | Formula | OpenClaude — Claude Code with any LLM (OpenAI, Gemini, DeepSeek, Ollama, 200+ models) |
| `rmsafe` | Formula | Modern rm replacement with trash, undo, and Btrfs support |
| `typeback` | Cask | macOS 输入法自动回切工具 |
| `wordroot` | Cask | English-Chinese dictionary with root/etyma analysis |

## Moved

`tmux-smart-name` is no longer distributed via this tap. Install it as a TPM
plugin instead:

```tmux
set -g @plugin 'leftrk/tmux-smart-name'
```

If you previously installed the formula, uninstall it first:
`brew uninstall leftrk/tap/tmux-smart-name`.