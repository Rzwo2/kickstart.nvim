vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.php',
  callback = function()
    local filepath = vim.fn.expand '%:p'
    local lines = {
      '<?php',
      '',
      'declare(strict_types=1);',
    }

    -- Check if file is inside src directory
    local src_pos = filepath:find '/src/'
    if src_pos then
      -- Extract path after src/
      local after_src = filepath:sub(src_pos + 5) -- +5 to skip "/src/"

      -- Remove the filename to get just the directory path
      local dir_path = vim.fn.fnamemodify(after_src, ':h')
      local file_name = vim.fn.fnamemodify(after_src, ':t:r')
      -- Only add namespace if there's a directory path after src/
      if dir_path ~= '.' and dir_path ~= '' then
        -- Convert forward slashes to backslashes for namespace
        local namespace = 'App\\' .. dir_path:gsub('/', '\\')

        -- Add empty line and namespace
        table.insert(lines, '')
        table.insert(lines, 'namespace ' .. namespace .. ';')
        table.insert(lines, '')
        table.insert(lines, 'class ' .. file_name)
        table.insert(lines, '{')
        table.insert(lines, '    ')
        table.insert(lines, '}')
      end
    end

    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
    vim.api.nvim_win_set_cursor(0, { 9, 4 })
  end,
})
