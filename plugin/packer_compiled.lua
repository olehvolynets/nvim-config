-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/Oleh_Volynets/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/Oleh_Volynets/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/Oleh_Volynets/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/Oleh_Volynets/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/Oleh_Volynets/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "git@github.com:numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "git@github.com:antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "git@github.com:L3MON4D3/LuaSnip"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "git@github.com:jiangmiao/auto-pairs"
  },
  ["clangd_extensions.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/clangd_extensions.nvim",
    url = "git@github.com:p00f/clangd_extensions.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "git@github.com:hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "git@github.com:hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "git@github.com:hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "git@github.com:hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "git@github.com:hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "git@github.com:saadparwaiz1/cmp_luasnip"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim",
    url = "git@github.com:tjdevries/colorbuddy.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "git@github.com:sindrets/diffview.nvim"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "git@github.com:j-hui/fidget.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "git@github.com:rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "git@github.com:lewis6991/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/glow.nvim",
    url = "git@github.com:ellisonleao/glow.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "git@github.com:lukas-reineke/indent-blankline.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "git@github.com:onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "git@github.com:hoob3rt/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "git@github.com:williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "git@github.com:williamboman/mason.nvim"
  },
  neotest = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/neotest",
    url = "git@github.com:nvim-neotest/neotest"
  },
  ["neotest-go"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/neotest-go",
    url = "/Users/Oleh_Volynets/dev/neotest-go"
  },
  ["neotest-rspec"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/neotest-rspec",
    url = "git@github.com:olimorris/neotest-rspec"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "git@github.com:jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "git@github.com:hrsh7th/nvim-cmp"
  },
  ["nvim-coverage"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rcoverage\frequire\0" },
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-coverage",
    url = "git@github.com:andythigpen/nvim-coverage"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "git@github.com:mfussenegger/nvim-dap"
  },
  ["nvim-dap-ruby"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-dap-ruby",
    url = "/Users/Oleh_Volynets/dev/nvim-dap-ruby"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "git@github.com:rcarriga/nvim-dap-ui"
  },
  ["nvim-highlight-colors"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-highlight-colors",
    url = "git@github.com:brenoprata10/nvim-highlight-colors"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "git@github.com:neovim/nvim-lspconfig"
  },
  ["nvim-navic"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "git@github.com:SmiteshP/nvim-navic"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "git@github.com:rcarriga/nvim-notify"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "git@github.com:kylechui/nvim-surround"
  },
  ["nvim-transparent"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "git@github.com:xiyaowong/nvim-transparent"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "git@github.com:kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "git@github.com:nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-treesitter-endwise",
    url = "git@github.com:RRethy/nvim-treesitter-endwise"
  },
  ["nvim-ufo"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-ufo",
    url = "git@github.com:kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "git@github.com:kyazdani42/nvim-web-devicons"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/one-small-step-for-vimkind",
    url = "git@github.com:jbyuki/one-small-step-for-vimkind"
  },
  ["oxocarbon-lua.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/oxocarbon-lua.nvim",
    url = "git@github.com:B4mbus/oxocarbon-lua.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "git@github.com:wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/playground",
    url = "git@github.com:nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "git@github.com:nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "git@github.com:nvim-lua/popup.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "git@github.com:kevinhwang91/promise-async"
  },
  sigma = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/sigma",
    url = "/Users/Oleh_Volynets/dev/cs/sigma"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/splitjoin.vim",
    url = "git@github.com:andrewradev/splitjoin.vim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim",
    url = "git@github.com:nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "git@github.com:nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim",
    url = "git@github.com:nvim-telescope/telescope-fzf-writer.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "git@github.com:nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "git@github.com:nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "git@github.com:nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "git@github.com:folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "git@github.com:folke/trouble.nvim"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/vim-dadbod",
    url = "git@github.com:tpope/vim-dadbod"
  },
  ["vim-dadbod-ui"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/vim-dadbod-ui",
    url = "git@github.com:kristijanhusak/vim-dadbod-ui"
  },
  ["vim-log-highlighting"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/vim-log-highlighting",
    url = "git@github.com:MTDL9/vim-log-highlighting"
  },
  ["vim-maximizer"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/vim-maximizer",
    url = "git@github.com:szw/vim-maximizer"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "git@github.com:folke/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rzen-mode\frequire\0" },
    loaded = true,
    path = "/Users/Oleh_Volynets/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "git@github.com:folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-coverage
time([[Config for nvim-coverage]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rcoverage\frequire\0", "config", "nvim-coverage")
time([[Config for nvim-coverage]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rzen-mode\frequire\0", "config", "zen-mode.nvim")
time([[Config for zen-mode.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
