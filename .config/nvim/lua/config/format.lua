-- Utilities for creating configurations
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		awk = { "awk" },
		go = { "gofmt", lsp_format = "fallback" },
		javascriptreact = { "prettierd", "prettier", "eslint_d" },
		typescriptreact = { "prettierd", "prettier", "eslint_d" },
		rust = { "rustfmt", "dioxus", lsp_format = "fallback" },
		tex = { "latexindent", args = "-w" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		caddyfile = { "caddyfile" },
		solidity = { "forge", lsp_format = "fallback" },
		python = { "black" },
		["_"] = { "trim_whitespace" },
	},
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_format = "fallback",
		timeout_ms = 5000,
	},
	notify_on_error = true,
	notify_no_formatters = true,
	formatters = {
		caddyfile = {
			command = "caddy",
			args = { "fmt", "$FILENAME" },
			stdin = true,
			require_cwd = true,
			cwd = require("conform.util").root_file({ "Caddyfile" }),
			exit_codes = { 1 },
		},
		forge = {
			command = "forge",
			args = { "fmt", "$FILENAME" },
			stdin = false,
			require_cwd = true,
			cwd = require("conform.util").root_file({ "foundry.toml", "remappings.txt" }),
		},
		dioxus = {
			command = "dx",
			args = { "fmt", "--file", "$FILENAME" },
			stdin = false,
			require_cwd = true,
			cwd = require("conform.util").root_file({ "Dioxus.toml" }),
		},
	},
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		require("conform").format({ bufnr = args.buf })
-- 	end,
-- })
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	callback = function(ev)
		vim.bo[ev.buf].formatprg = "jq"
	end,
})
