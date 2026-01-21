# AGENTS.md - Development Guide for Agentic Coding Agents

This repository contains a modular Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). As an AI agent, follow these guidelines to ensure consistency and maintainability.

## 1. Build, Lint, and Test Commands

### Build
This is a Lua-based Neovim configuration; there is no compilation or build step. Configuration changes take effect upon restarting Neovim or sourcing the modified files.

### Linting
Linting is managed via `nvim-lint` (`lua/kickstart/plugins/lint.lua`).
- **Markdown/Text/RST:** Uses `vale`.
- **Python:** Uses `ruff` (and sometimes uses `mypy` when enabled).
- **Manual Command:**
  - `vale path/to/file.md`
  - `ruff check path/to/file.py`

### Formatting
Formatting is managed via `conform.nvim` (`lua/kickstart/plugins/conform.lua`).
- **Lua:** Uses `stylua`.
- **Python:** Uses `ruff` (fix, format, and organize imports).
- **Manual Command:**
  - `stylua path/to/file.lua`
  - `ruff format path/to/file.py`
  - `ruff check --fix path/to/file.py`

### Testing
There are no automated unit tests currently configured for this repository. 
- **Verification:** Launch Neovim (`nvim`) and check for errors or verify the feature manually.
- **Checkhealth:** Use `:checkhealth` within Neovim to diagnose environment issues.

---

## 2. Code Style Guidelines

### General Lua Conventions
- **Indentation:** Use 2 spaces. Do NOT use tabs.
- **Line Length:** Aim for 100 characters where possible (configured via `vim.opt.textwidth = 100`).
- **Modelines:** Include a modeline at the end of every Lua file: `-- vim: ts=2 sts=2 sw=2 et`.

### Naming Conventions
- **Variables/Functions:** Use `snake_case`.
- **Tables/Modules:** Use `snake_case`.
- **Booleans:** Prefix with `is_`, `has_`, or `have_` (e.g., `have_nerd_font`).

### Imports
- Prefer `require 'module'` (without parentheses) for top-level requires, but `require('module')` is also acceptable.
- Ensure modules are placed under the `lua/` directory.
- Follow the modular structure:
  - `lua/kickstart/plugins/`: Standard plugins and their configuration.
  - `lua/custom/plugins/`: User-specific plugin additions.
  - `lua/options.lua`, `lua/keymaps.lua`: Core Neovim settings.

### Neovim API Usage
- Use `vim.keymap.set()` instead of `vim.api.nvim_set_keymap()`.
- Use `vim.api.nvim_create_autocmd()` and `vim.api.nvim_create_augroup()` for autocommands.
- Prefer `vim.opt` for setting options (table-like access) over `vim.o` where appropriate.

### Error Handling
- Use `pcall(require, 'module')` when loading optional plugins to prevent configuration crashes if a plugin is missing.
- Provide descriptive error messages if a critical component fails to load.

### Commenting
- Use `[[ Title ]]` style headers for major sections in files.
- Use `---` for doc comments if applicable.
- Add "Added by [Name]" comments for significant personal customizations (e.g., `-- Added by Jack`).

---

## 3. Project Structure

- `init.lua`: The entry point.
- `lua/options.lua`: Global Neovim options.
- `lua/keymaps.lua`: Global keybindings.
- `lua/lazy-bootstrap.lua`: Installs the `lazy.nvim` plugin manager.
- `lua/lazy-plugins.lua`: Coordinates plugin loading from `kickstart/plugins` and `custom/plugins`.
- `lua/kickstart/plugins/*.lua`: Modular plugin definitions (e.g., `telescope.lua`, `lspconfig.lua`).
- `lua/custom/plugins/*.lua`: Custom plugin overrides or additions.

---

## 4. AI Rules and Instructions

### Cursor/Copilot Rules
- No specific `.cursorrules` or `.github/copilot-instructions.md` files are present.
- Follow the patterns established in `lua/kickstart/` for consistency with the upstream project while respecting the modular overrides in `lua/custom/`.

### Guidelines for AI Agents
- **Modularity First:** When adding a new plugin, create a new file in `lua/custom/plugins/` instead of modifying `init.lua` or `lua/lazy-plugins.lua` directly if possible.
- **Respect Lazy.nvim:** Always return a table for plugin definitions that is compatible with `lazy.nvim` syntax.
- **Non-Interactive Verification:** Since you cannot interact with a TUI, focus on static analysis and ensuring Lua syntax is correct.

---

## 5. Typical Workflow for Changes

1.  **Modify:** Edit the relevant file in `lua/` or its subdirectories.
2.  **Lint/Format:** Run `stylua` or `ruff` on the modified files.
3.  **Verify:** Check for syntax errors. If possible, use `nvim --headless -c "qa"` to check for startup errors (though this may not catch all plugin-load issues).
4.  **Commit:** Create a clear, concise commit message describing the change.

---

*This file is intended for use by LLM-based coding assistants. Last updated: 2026-01-21.*
