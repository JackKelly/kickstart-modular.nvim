return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'codecompanion' },
      },
    },
    opts = {
      interactions = {
        chat = {
          adapter = 'opencode',
          -- model = "",
        },
        inline = {
          adapter = 'gemini',
          model = 'gemini-3-flash-preview',
        },
      },
    },
  },
}
