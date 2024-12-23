function my_paste(reg)
      return function(lines)

          --[ 返回 “” 寄存器的内容，用来作为 p 操作符的粘贴物 ]
          local content = vim.fn.getreg('"')
          return vim.split(content, '\n')

      end
  end

  local opt = vim.opt
  if (os.getenv('SSH_TTY') == nil)
  then
      --[ 当前环境为本地环境，也包括 wsl ]
      opt.clipboard:append("unnamedplus")
  else
      opt.clipboard:append("unnamedplus")
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
          ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
          --[ 小括号里面的内容可能是毫无意义的，但是保持原样可能看起来更好一点 ]
          ["+"] = my_paste("+"),
          ["*"] = my_paste("*"),


      },
  }
end
require("plugins.plugins-setup")

require("core.options")
require("core.keymaps")

-- 插件
require("plugins/nvim-tree")
require("plugins/lsp")
require("plugins/cmp")
require("plugins/autopairs")
require("plugins/bufferline")
