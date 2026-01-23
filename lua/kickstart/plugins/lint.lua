return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      lint.linters_by_ft['clojure'] = nil
      lint.linters_by_ft['dockerfile'] = nil
      lint.linters_by_ft['inko'] = nil
      lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft['json'] = nil
      lint.linters_by_ft['markdown'] = { 'vale' }
      lint.linters_by_ft['python'] = { 'ruff' } -- mypy is added in the code below iff it's found in pyproject.toml
      lint.linters_by_ft['rst'] = { 'vale' }
      lint.linters_by_ft['ruby'] = nil
      lint.linters_by_ft['terraform'] = nil
      lint.linters_by_ft['text'] = { 'vale' }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            local names = lint.linters_by_ft[vim.bo.filetype] or {}

            -- Dynamically enable mypy if it's configured or listed as a dependency in pyproject.toml
            if vim.bo.filetype == 'python' then
              local root = vim.fs.root(0, { 'pyproject.toml', '.git' })
              if root then
                local pyproject = root .. '/pyproject.toml'
                local f = io.open(pyproject, 'r')
                if f then
                  local content = f:read '*all'
                  f:close()
                  -- Check for:
                  -- 1. [tool.mypy] section
                  -- 2. "mypy" or 'mypy' in dependencies lists
                  -- 3. mypy = ... in Poetry style dependencies
                  if content:find 'tool%.mypy' or content:find '["\']mypy["\']' or content:find '\nmypy%s*=' or content:find '^mypy%s*=' then
                    -- Add mypy if it's not already in the list
                    if not vim.list_contains(names, 'mypy') then
                      table.insert(names, 'mypy')
                    end
                  end
                end
              end
            end

            lint.try_lint(names)
          end
        end,
      })
    end,
  },
}
