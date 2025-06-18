vim.g.mapleader = " "

local keymap = vim.keymap

-- Modo Insertar
keymap.set("i", "jj", "<ESC>", { desc = "Salir del modo Insert" })

-- Comandos básicos
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Limpiar Highlight" })
keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Salir de Neovim" })

-- Gestión de ventanas
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Igualar tamaño de splits" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Cerrar split actual" })

-- Gestión de pestañas
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Nueva pestaña" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Cerrar pestaña actual" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Pestaña siguiente" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Pestaña anterior" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Buffer en nueva pestaña" })
