# Neovim Configuration (Kickstart Modular)

This directory contains a Neovim configuration based on [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim), which is a multi-file fork of the popular `kickstart.nvim`. It provides a small, fast, and documented starting point for Neovim.

## Project Structure

The configuration is split into modular Lua files for better maintainability.

*   **`init.lua`**: The entry point. It sets the leader key, loads options and keymaps, bootstraps the `lazy.nvim` plugin manager, and loads the plugin specifications.
*   **`lua/`**: Contains all the Lua code.
    *   **`options.lua`**: Sets Neovim options (line numbers, mouse support, etc.).
    *   **`keymaps.lua`**: Defines basic keymappings.
    *   **`lazy-bootstrap.lua`**: Logic to install `lazy.nvim` if it's missing.
    *   **`lazy-plugins.lua`**: Main plugin specification file. It imports modules from `kickstart/plugins` and `custom/plugins`.
    *   **`kickstart/plugins/`**: Contains configurations for the core plugins provided by Kickstart (e.g., Telescope, LSPConfig, Treesitter, Blink-CMP).
    *   **`custom/plugins/`**: The dedicated location for your personal plugin configurations. Files here are automatically imported by `lazy.nvim`.

## Key Features & Plugins

*   **Plugin Manager**: `lazy.nvim`
*   **LSP**: Native Neovim LSP with `nvim-lspconfig`.
*   **Completion**: `blink.cmp` (configured with `minuet-ai.nvim` for AI completion).
*   **Fuzzy Finder**: `telescope.nvim`.
*   **Highlighting**: `nvim-treesitter`.
*   **AI Completion**: `minuet-ai.nvim` (manually invoked via `<C-g>`).

## Usage

### Prerequisites

Ensure the following tools are installed on your system:
*   **Neovim** (0.9+)
*   **Git**
*   **Make**, **GCC** (for compiling Telescope native extensions and Treesitter parsers)
*   **Ripgrep** (`rg`) (required by Telescope)
*   **Fd** (`fd`) (optional, used by Telescope)
*   **Nerd Font** (optional, for icons)

### Installation

Clone the repository to your Neovim configuration directory:

```bash
# Linux / MacOS
git clone <repo-url> ~/.config/nvim
```

### Running

Simply start Neovim:

```bash
nvim
```

`lazy.nvim` will automatically bootstrap itself and install all defined plugins on the first run. Use `:Lazy` to check plugin status.

## Development Conventions

*   **Modular Config**: Do not add everything to `init.lua`.
    *   **Core Changes**: Edit files in `lua/kickstart/`.
    *   **Personal Plugins**: Add new files to `lua/custom/plugins/`. Each file should return a Lua table (plugin specification).
*   **Style**: The project follows standard Lua formatting. A `.stylua.toml` file is present for `stylua` configuration.
*   **Minuet Integration**: The AI completion is set up in `lua/custom/plugins/minuet.lua` and integrated into `blink.cmp` in `lua/kickstart/plugins/blink-cmp.lua`. It uses a manual trigger (`<C-g>`) to avoid conflicts with standard completion.
