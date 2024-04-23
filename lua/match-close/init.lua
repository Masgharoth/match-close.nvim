local function match_close(reference)
	if type(reference) ~= "string" then
		print("Bad input" .. reference .. type(reference))
		return
	end
	local w = vim.api.nvim_get_current_line()
	local window = vim.api.nvim_get_current_win()
	local pos = vim.api.nvim_win_get_cursor(window)
	local i = pos[2]
	local j = 0
	for c in w:gmatch(".") do
		if j == i then
			if c == reference then
				--print 'should move'
				vim.opt.virtualedit = "onemore"
				vim.cmd("normal l")
				return
			else
				--print 'should type'
				if reference == '"' or reference == "'" then
					vim.cmd.normal({ "i" .. reference .. reference, bang = true })
					return
				end

				vim.cmd.normal({ "i" .. reference, bang = true })
				vim.cmd("normal l")
				return
			end
		else
			if i == string.len(w) then
				--print 'should type but on EOL'
				if reference == '"' or reference == "'" then
					vim.cmd.normal({ "i" .. reference .. reference, bang = true })
					return
				end
				vim.cmd.normal({ "i" .. reference, bang = true })
				vim.cmd("normal l")
				return
			end
			--print 'got elsed'
		end
		j = j + 1
	end
end

local M = {}

M.setup = function()
	vim.keymap.set("i", ">", function()
		match_close(">")
	end)

	vim.keymap.set("i", "}", function()
		match_close("}")
	end)

	vim.keymap.set("i", ")", function()
		match_close(")")
	end)

	vim.keymap.set("i", "]", function()
		match_close("]")
	end)

	vim.keymap.set("i", "'", function()
		match_close("'")
	end)

	vim.keymap.set("i", '"', function()
		match_close('"')
	end)
end
return { M }

-- vim: ts=4 sts=4 sw=4 et
