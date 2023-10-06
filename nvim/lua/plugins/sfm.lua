local keymaps = require "config.keymaps"
local bdelete = require("barbar.bbye").bdelete
local event = require "sfm.event"

local M = {}

M.setup = function()
  local sfm_explorer = require("sfm").setup {
    view = {
      selection_render_method = "sign",
    },
    renderer = {
      icons = {
        selection = "*",
      },
    },
    mappings = {
      list = {
        {
          key = "<C-v>",
          action = nil,
        },
        {
          key = "<C-h>",
          action = nil,
        },
        {
          key = "V",
          action = "vsplit",
        },
        {
          key = "H",
          action = "split",
        },
      },
    },
    file_nesting = {
      enabled = true,
      expand = true,
      patterns = {
        { "*.php", { "$(capture)Interface.php" } },
        { "*.c", { "$(capture).h" } },
        { "*.cc", { "$(capture).hpp", "$(capture).h", "$(capture).hxx" } },
        { "*.cpp", { "$(capture).hpp", "$(capture).h", "$(capture).hxx" } },
        { "go.mod", { "go.sum" } },
        { "*.go", { "$(capture)_test.go" } },
        { ".env", { "*.env", ".env.*", ".envrc", "env.d.ts" } },
        { ".gitignore", { ".gitattributes", ".gitmodules", ".gitmessage", ".mailmap", ".git-blame*" } },
        { "composer.json", { ".php*.cache", "composer.lock", "phpunit.xml*", "psalm*.xml" } },
        {
          "readme*",
          {
            "authors",
            "backers*",
            "changelog*",
            "citation*",
            "code_of_conduct*",
            "codeowners",
            "contributing*",
            "contributors",
            "copying*",
            "credits",
            "governance.md",
            "history.md",
            "license*",
            "maintainers",
            "readme*",
            "security.md",
            "sponsors*",
          },
        },
        {
          "artisan",
          {
            "*.env",
            ".babelrc*",
            ".codecov",
            ".cssnanorc*",
            ".env.*",
            ".envrc",
            ".htmlnanorc*",
            ".lighthouserc.*",
            ".mocha*",
            ".postcssrc*",
            ".terserrc*",
            "api-extractor.json",
            "ava.config.*",
            "babel.config.*",
            "contentlayer.config.*",
            "cssnano.config.*",
            "cypress.*",
            "env.d.ts",
            "formkit.config.*",
            "formulate.config.*",
            "histoire.config.*",
            "htmlnanorc.*",
            "i18n.config.*",
            "jasmine.*",
            "jest.config.*",
            "jsconfig.*",
            "karma*",
            "lighthouserc.*",
            "playwright.config.*",
            "postcss.config.*",
            "puppeteer.config.*",
            "rspack.config.*",
            "server.php",
            "svgo.config.*",
            "tailwind.config.*",
            "tsconfig.*",
            "tsdoc.*",
            "uno.config.*",
            "unocss.config.*",
            "vitest.config.*",
            "vuetify.config.*",
            "webpack.config.*",
            "webpack.mix.js",
            "windi.config.*",
          },
        },
      },
    },
  }

  sfm_explorer:load_extension "sfm-bookmark"
  sfm_explorer:load_extension "sfm-filter"
  sfm_explorer:load_extension "sfm-git"
  sfm_explorer:load_extension "sfm-telescope"
  sfm_explorer:load_extension "sfm-paste"

  sfm_explorer:subscribe(event.EntryDeleted, function(payload)
    local path = payload["path"]
    local bufnr = vim.fn.bufnr(path, true)
    bdelete(false, bufnr)
  end)

  keymaps.set("n", "<F1>", "<CMD>SFMToggle<CR>", { noremap = true, silent = true })
  keymaps.set("n", "fm", "<CMD>SFMToggle<CR>", { noremap = true, silent = true })
end

return M
