return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>t",
      function()
        local path = vim.api.nvim_buf_get_name(0)
        local is_open
        if path:find("neo-tree", 0, true) then
          is_open = true
        else
          is_open = false
        end
        require('neo-tree.command').execute({
          action = "focus",
          source = "filesystem",
          position = "left",
          toggle = is_open,
        })
      end)
  end,
}
