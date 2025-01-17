require("config.lsp.signs")
require("config.lsp.keybinds")
require("config.lsp.service")
require("config.lsp.handlers").setup()

local config = require("config.lsp.config")

local function setup_servers()
    require("lspinstall").setup()
    local servers = require("lspinstall").installed_servers()
    for _, server in pairs(servers) do
        if server == "lua" then
            require("lspconfig")[server].setup(config.lua)
        else
            require("lspconfig")[server].setup({})
        end
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
