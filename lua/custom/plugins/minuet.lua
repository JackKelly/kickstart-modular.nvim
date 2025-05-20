return {
  { -- AI powered auto-completion.
    'milanglacier/minuet-ai.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      require('minuet').setup {
        provider = 'gemini',
      }
    end,
  },
}
