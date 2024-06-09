local o = vim.opt

-- Nvim
o.autochdir = true

-- Editing
vim.api.nvim_create_autocmd('FileType', { command = 'set fo-=ro' })
o.textwidth = 80

-- Indentation
o.smarttab = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = false

-- Visual
o.wrap = false
o.number = true
o.relativenumber = true

-- Search
o.hlsearch = false
o.incsearch = true

-- Cursor
o.scrolloff = 50

if vim.fn.has 'win32' == 1 then
	o.shell = "powershell"
	o.shellcmdflag =
	"-NoLogo -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
	o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	o.shellquote = ""
	o.shellxquote = ""
	o.fsync = false
end
