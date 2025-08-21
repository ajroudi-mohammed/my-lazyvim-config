require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>gd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Go to definition with Telescope" })
map("n", "<leader>gr", "<CMD>Telescope lsp_references<CR>", { desc = "Go to references with Telescope" })
map("n", "<leader>fif", "<CMD>Telescope live_grep<CR>", { desc = "Find in files" })
map("n", "<leader>o", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Show outline of current file" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tt", "<CMD>TodoTelescope keywords=NOTE<cr>", { desc = "Todo" })
map("n", "]b", "<CMD>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<CMD>bprev<cr>", { desc = "Previous bugger" })
-- Load the session for the current directory
map("n", "<leader>qs", "<CMD>lua require('persistence').load()<CR>", { desc = "Load the session for the current directory" })

-- Select a session to load
map("n", "<leader>qS", "<CMD>lua require('persistence').select()<CR>", { desc = "Select a session to load" })

-- Load the last session
map("n", "<leader>ql", "<CMD>lua require('persistence').load({ last = true })<CR>", { desc = "Load the last session" })

-- Stop Persistence => session won't be saved on exit
map("n", "<leader>qd", "<CMD>lua require('persistence').stop()<CR>", { desc = "Stop Persistence, no session save on exit" })
map("n", "<leader>cr", vim.lsp.buf.rename, { noremap = true, silent = true })
map("n", "<leader>a", require("lspimport").import, { noremap = true })
map("n", "<leader>i", "<CMD>FlutterLspRestart<CR>", { desc = "Restarts indexing" })
map('n', '<leader>gs', '<CMD>Telescope git_status<CR>', { noremap = true, silent = true })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code [A]ction" })


-- Debugging
map("n", "<leader>b", "<CMD>lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>du", "<CMD>lua require('dapui').toggle()<CR>", { desc = "Toggle debug UI" })
map("n", "<leader>gb", "<CMD>lua require('dap').run_to_cursor()<CR>", { desc = "Run to cursor" })
map("n", "<leader>?", "<CMD>lua require('dapui').eval(nil, {enter = true})<CR>", { desc = "? on a variable" })
map("n", "<F1>", "<CMD>lua require('dap').continue()<CR>", { desc = "Continue" })
map("n", "<F2>", "<CMD>lua require('dap').step_into()<CR>", { desc = "Step into" })
map("n", "<F3>", "<CMD>lua require('dap').step_over()<CR>", { desc = "Step over" })
map("n", "<F4>", "<CMD>lua require('dap').step_out()<CR>", { desc = "Step out" })
map("n", "<F12>","<CMD>lua require('dap').restart()<CR>", { desc = "Restart" })
map("n", "<leader>dq","<CMD>lua require('dap').terminate()<CR>", { desc = "Restart" })
map("n", "<leader>db","<CMD>FlutterDebug<CR>", { desc = "Restart" })
map("n", "<leader>da", "<CMD>FlutterErrors<CR>", { desc = "Flutter analyze ( find all errors !)" })
map("n", "<leader>fe", "<CMD>Telescope diagnostics<CR>", { desc = "Find errors" })
map("n", "<leader>fc", "<CMD>Telescope diagnostics bufnr=0<CR>", { desc = "Find current buffer errors" })

-- Terminal
map('n', '<A-1>', '<CMD>ToggleTerm 1 direction=vertical<CR>', { desc = "Toggle terminal 1" })
map('n', '<A-2>', '<CMD>ToggleTerm 2<CR>', { desc = "Toggle terminal 2" })
map('n', '<A-3>', '<CMD>ToggleTerm 3<CR>', { noremap = true, silent = true, desc = "Toggle terminal 3" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>bo", "<CMD>bd|e#<CR>", { desc = "Close other buffers" })
