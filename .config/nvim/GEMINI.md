# Neovim Configuration Workspace

## Directory Overview
This directory (`~/.config/nvim`) contains a comprehensive Neovim configuration setup. It is written in Lua and uses `lazy.nvim` as the plugin manager. The configuration is modularized, separating core editor options, keybindings, plugin specifications, and utility functions into distinct files within the `lua/` directory.

## Architecture & Structure
The entry point is `init.lua`, which requires various core modules and the plugin manager setup.

### Key Directories and Files:
*   **`init.lua`**: The main configuration file. It initializes the environment and loads modules from the `lua/` directory.
*   **`lua/lazyPalli.lua`**: Bootstraps and configures the `lazy.nvim` plugin manager. It sets up the UI and disabled default plugins for better performance.
*   **`lua/core/`**: Contains the foundational Neovim settings.
    *   `opt.lua`: Defines standard Neovim options (UI, behavior, editing settings like tabstop, numbers, spellcheck, etc.).
    *   `keys.lua`: Sets up global keymaps, including window management, buffer navigation, and integration with plugins like Telescope, FzfLua, Gitsigns, and DAP.
    *   `func.lua` & `vide.lua`: Additional core scripts and Neovide-specific settings.
*   **`lua/plug/`**: Holds configurations for individual plugins managed by `lazy.nvim`. Each file typically returns a Lazy plugin spec.
    *   *Examples:* `lsp.lua` (Mason, LSP config, completion capabilities), `telescope.lua`, `treesitter.lua`, `theme.lua`, etc.
*   **`lua/util/`**: Utility scripts used across the configuration (e.g., `static.lua`, `git.lua`, `lsp.lua`).
*   **`.stylua.toml`**: Configuration for `StyLua`, enforcing Lua code formatting conventions across the project (160 column width, 2 spaces indent, single quotes).

## Usage & Development Conventions
*   **Plugin Management:** Plugins are added and configured within the `lua/plug/` directory. `lazy.nvim` automatically loads them based on their specifications.
*   **Formatting:** Lua files should be formatted using `stylua`, adhering to the rules in `.stylua.toml`.
*   **Keymaps:** Most keymaps are centralized in `lua/core/keys.lua`. The `<Space>` key is used as the `<Leader>` and `<LocalLeader>` key.
*   **LSP Setup:** Language Server Protocol (LSP) configuration is handled in `lua/plug/lsp.lua` using `mason.nvim` for installation and `nvim-lspconfig` for setup. It includes predefined settings for servers like `gopls`, `hls`, `clangd`, `pylsp`, and `lua_ls`.
