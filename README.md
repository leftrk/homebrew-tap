# homebrew-tap

Homebrew tap for [leftrk](https://github.com/leftrk)'s tools.

## Install

```bash
brew install leftrk/tap/openclaude
brew install --cask leftrk/tap/typeback
brew install --cask leftrk/tap/wordroot
```

## Tools

| Name | Type | Description |
|------|------|-------------|
| `openclaude` | Formula | OpenClaude — Claude Code with any LLM (OpenAI, Gemini, DeepSeek, Ollama, 200+ models) |
| `typeback` | Cask | macOS 输入法自动回切工具 |
| `wordroot` | Cask | English-Chinese dictionary with root/etyma analysis |

## Moved

`rmsafe` is no longer distributed via this tap. Install it from PyPI instead:

```bash
pipx install rmsafe
```

If you previously installed the formula, uninstall it first:
`brew uninstall leftrk/tap/rmsafe`.

`tmux-smart-name` is no longer distributed via this tap. Install it as a TPM
plugin instead:

```tmux
set -g @plugin 'leftrk/tmux-smart-name'
```

If you previously installed the formula, uninstall it first:
`brew uninstall leftrk/tap/tmux-smart-name`.