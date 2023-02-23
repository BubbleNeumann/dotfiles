require("bubble_neumann.set")
require("bubble_neumann.remap")

function ColorMyPencils(color) 
	color = color or "rosepine"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
