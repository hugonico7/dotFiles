vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Salir del modo Insert" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Limpiar HighLighs" })
keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Salirse" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Dividir panel Vertical" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Dividir panel Horizontal" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Hacer los paneles del mismo tamanio" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Cerrar panel actual" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Abrir nueva Ventana" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Cerrar Ventana actual" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Ir a la siguiente Ventana" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Ir a la Ventana anterior" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Abrir el Buffer actual en otra ventana" }) --  move current buffer to new tab
