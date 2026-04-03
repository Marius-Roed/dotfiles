local harpoon = require("harpoon")
local conf = require("telescope.config").values

harpoon:setup({})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })

-- INFO: Maybe move to CMD instead of CTRL
vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Go to harpoon buffer 1" })
vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Go to harpoon buffer 2" })
vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Go to harpoon buffer 3" })
vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Go to harpoon buffer 4" })
vim.keymap.set("n", "<C-5>", function() harpoon:list():select(5) end, { desc = "Go to harpoon buffer 5" })

vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Go to next harpoon buffer" })
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Go to prev harpoon buffer" })

local function toggle_telescope(harpoon_files)
    local file_paths = {}
    print(harpoon_files)
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader><C-o>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon buffers" })
