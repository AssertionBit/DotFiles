require('auto-save').setup {
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    execution_message = {
        message = function() -- message to print on save
            return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
    },
    trigger_events = {"InsertLeave", "TextChanged"}, -- vim events that trigger auto-save. See :h events
    -- function that determines whether to save the current buffer or not
    -- return true: if buffer is ok to be saved
    -- return false: if it's not ok to be saved
    condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if
            fn.getbufvar(buf, "&modifiable") == 1 and
            utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
            return true -- met condition(s), can save
        end
        return false -- can't save
    end,
    write_all_buffers = false, -- write all buffers when the current one meets `condition`
    debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
    callbacks = { -- functions to be executed at different intervals
        enabling = nil, -- ran when enabling auto-save
        disabling = nil, -- ran when disabling auto-save
        before_asserting_save = nil, -- ran before checking `condition`
        before_saving = nil, -- ran before doing the actual save
        after_saving = nil -- ran after doing the actual save
    }
}

local mappings_utils = require('renamer.mappings.utils')
require('renamer').setup {
    -- The popup title, shown if `border` is true
    title = 'Rename',
    -- The padding around the popup content
    padding = {
        top = 0,
        left = 0,
        bottom = 0,
        right = 0,
    },
    -- The minimum width of the popup
    min_width = 15,
    -- The maximum width of the popup
    max_width = 45,
    -- Whether or not to shown a border around the popup
    border = true,
    -- The characters which make up the border
    border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    -- Whether or not to highlight the current word references through LSP
    show_refs = true,
    -- Whether or not to add resulting changes to the quickfix list
    with_qf_list = true,
    -- Whether or not to enter the new name through the UI or Neovim's `input`
    -- prompt
    with_popup = true,
    -- The keymaps available while in the `renamer` buffer. The example below
    -- overrides the default values, but you can add others as well.
    mappings = {
        ['<c-i>'] = mappings_utils.set_cursor_to_start,
        ['<c-a>'] = mappings_utils.set_cursor_to_end,
        ['<c-e>'] = mappings_utils.set_cursor_to_word_end,
        ['<c-b>'] = mappings_utils.set_cursor_to_word_start,
        ['<c-c>'] = mappings_utils.clear_line,
        ['<c-u>'] = mappings_utils.undo,
        ['<c-r>'] = mappings_utils.redo,
    },
    -- Custom handler to be run after successfully renaming the word. Receives
    -- the LSP 'textDocument/rename' raw response as its parameter.
    handler = nil,
}

require("nvim-tree").setup()
