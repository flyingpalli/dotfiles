vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.cmd("iab \"a ä")
vim.cmd("iab \"o ö")
vim.cmd("iab \"u ü")
vim.cmd("iab \"A Ä")
vim.cmd("iab \"O Ö")
vim.cmd("iab \"U Ü")

vim.cmd("iab \\s ß")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>ll", function() vim.fn.jobstart('latexmk -pdf main.tex') end)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local keys = { "Left", "Right", "Up", "Down" }
local modes = { "n", "v", "i" }

for _, k in pairs(keys) do
    for _, m in pairs(modes) do
        vim.keymap.set(m, "<" .. k .. ">", function() print("No " .. k .. " for you") end)
        vim.keymap.set(m, "<C-" .. k .. ">", function() print("No Cmd+" .. k .. " for you") end)
    end
end
