--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        swapfile = false, -- sets vim.opt.swapfile
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,

        -- MNL custom section - START --

        -- Switch between header/soucre
        ["<leader>bo"] = {":ClangdSwitchSourceHeader<cr>", desc = "Switch to header/source"},

        -- Toggle buffer explorer from Neotree
        ["<leader>be"] = {":Neotree toggle buffers focus<cr>", desc = "Toggle Buffers Explorer Focus"},

        -- Toggle git explorer from Neotree
        ["<leader>ge"] = {":Neotree toggle git_status focus<cr>", desc = "Toggle Git Explorer Focus"},

        -- Resize split equally
        ["<leader>u="] = {":wincmd =<cr>", desc = "Resize split equally"},

        -- Open telescope for symbol in file
        ["<leader>fs"] = {":Telescope lsp_document_symbols<cr>", desc = "Find symbols in file"},

        -- Open telescope for symbol in workspace
        ["<leader>fS"] = {":Telescope lsp_workspace_symbols<cr>", desc = "Find symbols in workspace"},

        -- Replace hexadecimal with decimal (and vice-versa)
        -- Not really successfull implementation, keep only for remainder
        -- ["<Leader>r"] = { desc = "Replace" },
        -- ["<leader>rhd"] = {"viw:s/\\%V0x[[:xdigit:]]\\+/\\=str2nr(submatch(0), 16)<cr>", desc = "Replace hex with decimal"},
        -- ["<leader>rdh"] = {"viw:s/\\%V[[:digit:]]\\+/\\=printf(\"0x%x\", submatch(0))<cr>", desc = "Replace decimal with hex"},
        -- ["<leader>x"] = {"viw:s/\\(0x\\)\\?[[:digit:]]\\+/\\=submatch(0) =~ \"0x\" ? str2nr(submatch(0), 16) : printf(\"0x%x\", submatch(0))<cr>", desc = "Switch between hex/decimal"}

        -- Replace hexadecimal with decimal (and vice-versa)
        -- Successfull one: isolate expression on new line, substitute and return to initial position
        ["<leader>x"] = {"lbi<cr> <Esc>:s/\\(0x\\)\\?[[:xdigit:]]\\+/\\=submatch(0) =~ \"0x\" ? str2nr(submatch(0), 16) : printf(\"0x%x\", submatch(0))<cr>0dwi<BS><Esc>l", desc = "Switch between hex/decimal"},

        -- Move line up/down
        ["<A-k>"] = {":m .-2<cr>==", desc = "Move line up"},
        ["<A-j>"] = {":m .+1<cr>==", desc = "Move line down"},

        -- MNL custom section - END --
      },
      t = {
      },
      v = {
        -- MNL custom section - START --
        ["<leader>-"] = {"y:g/<C-r>0/d<cr>", desc = "Delete line with selected pattern"},
        -- MNL custom section - END --
      },
    },
  },
}
