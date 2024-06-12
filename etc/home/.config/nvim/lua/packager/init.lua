-- Bootstrap lazy.nvim
-- Need to set path when package loaded.
-- Technically
-- can load packages after requiring the module.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function setup()
    local opts = {
        defaults = {
            lazy = false,
        },
        -- lockfile = vim.fn.stdpath("config") .. "/lazy/Lockfile.json",
        dev = {
            path = "~/src",
        }
    }

    require("lazy").setup("packager.plugins", opts)

end


return {
  setup = setup,
}
