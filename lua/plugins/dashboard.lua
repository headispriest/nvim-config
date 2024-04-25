return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
        
     ...     ...                                                    .                        
  .=*8888n.."%888:                                                 @88>                      
 X    ?8888f '8888                     u.        ...     ..        %8P      ..    .     :    
 88x. '8888X  8888>       .u     ...ue888b    :~""888h.:^"888:      .     .888: x888  x888.  
'8888k 8888X  '"*8h.   ud8888.   888R Y888r  8X   `8888X  8888>   .@88u  ~`8888~'888X`?888f` 
 "8888 X888X .xH8    :888'8888.  888R I888> X888n. 8888X  ?888>  ''888E`   X888  888X '888>  
   `8" X888!:888X    d888 '88%"  888R I888> '88888 8888X   ?**h.   888E    X888  888X '888>  
  =~`  X888 X888X    8888.+"     888R I888>   `*88 8888~ x88x.     888E    X888  888X '888>  
   :h. X8*` !888X    8888L      u8888cJ888   ..<"  88*`  88888X    888E    X888  888X '888>  
  X888xX"   '8888..: '8888c. .+  "*888*P"       ..XC.    `*8888k   888&   "*88%""*88" '888!` 
:~`888f     '*888*"   "88888%      'Y"        :888888H.    `%88>   R888"    `~    "    `"`   
    ""        `"`       "YP'                 <  `"888888:    X"     ""                       
                                                   %888888x.-`                               
                                                     ""**""                                  
                                                                                             

      ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = LazyVim.telescope("files"),                                    desc = " Find File",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
            { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
