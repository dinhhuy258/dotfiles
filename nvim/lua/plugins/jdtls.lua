local M = {}

M.setup = function()
  local home = os.getenv "HOME"
  local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
  -- File types that signify a Java project's root directory. This will be
  -- used by eclipse to determine what constitutes a workspace
  local root_markers = { ".gradlew", ".git", "mvnw", "pom.xml", "build.gradle" }
  local root_dir = require("jdtls.setup").find_root(root_markers)

  -- eclipse.jdt.ls stores project specific data within a folder. If you are working
  -- with multiple different projects, each project must use a dedicated data directory.
  -- This variable is used to configure eclipse to use the directory name of the
  -- current project found using the root_marker as the folder for project specific data.
  local workspace_dir = home .. "/.cache/jdtls/workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local lombok_path = jdtls_path .. "/lombok.jar"
  local path_to_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  -- The configuration for jdtls. This will need to be updated depending on your environment
  local path_to_config = jdtls_path .. "/config_mac_arm"

  local config = {
    root_dir = root_dir,
  }

  config.cmd = {
    "java", -- or '/path/to/java17_or_newer/bin/java'
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. lombok_path,
    "-jar",
    path_to_jar,
    "-configuration",
    path_to_config,
    "-data",
    workspace_dir,
  }

  config.settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      -- If you are developing in projects with different Java versions, you need
      -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- And search for `interface RuntimeOption`
      -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
      -- configuration = {
      --   runtimes = {
      --     {
      --       name = "JavaSE-17",
      --       path = home .. "/.asdf/installs/java/corretto-17.0.10.7.1",
      --     },
      --   },
      -- },
    },
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      require("jdtls").start_or_attach(config)
    end,
  })
end

return M
