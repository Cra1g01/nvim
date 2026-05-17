local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

return function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.uv.cwd()
  opts.pattern = opts.pattern or "%s"
  opts.shortcuts = opts.shortcuts
    or {
      c = "*.c",
      g = "*.go",
      j = "*.{js,jsx,ts,tsx}",
      l = "*.lua",
      n = "*.{vim,lua}",
      p = "*.py",
      r = "*.rs",
      s = "*.svelte",
      v = "*.vim",
    }

  local custom_grep = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local prompt_split = vim.split(prompt, "  ", { plain = true })
      local args = { "rg" }

      if prompt_split[1] and prompt_split[1] ~= "" then
        table.insert(args, "-e")
        table.insert(args, prompt_split[1])
      end

      if prompt_split[2] and prompt_split[2] ~= "" then
        table.insert(args, "-g")
        table.insert(
          args,
          string.format(opts.pattern, opts.shortcuts[prompt_split[2]] or prompt_split[2])
        )
      end

      vim.list_extend(args, {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      })

      return args
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Live Grep (with shortcuts)",
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end
