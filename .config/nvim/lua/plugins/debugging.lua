return {
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-neotest/nvim-nio" },
    { "jay-babu/mason-nvim-dap.nvim" },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("dap").set_log_level("TRACE")
            -- Setup dap-ui
            dapui.setup()
            require("nvim-dap-virtual-text").setup()

            -- Setup adapter
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "127.0.0.1",
                port = 8123,
                executable = {
                    command = "js-debug-adapter",
                    args = { "8123" },
                },
            }

            -- Auto open/close dap-ui
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Setup mason-nvim-dap
            require("mason-nvim-dap").setup({
                ensure_installed = { "js-debug-adapter" },
            })

            local current_file = vim.fn.expand("%:t")

            for _, language in ipairs({ "javascript", "typescript" }) do
                dap.configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        runtimeExecutable = "node",
                        sourceMaps = true,
                        resolveSourceMapLocations = {
                            "${workspaceFolder}/**",
                            "!**/node_modules/**",
                        },
                        skipFiles = { "<node_internals>/**" },
                    }
                    -- ,
                    -- {
                    --     type = "pwa-node",
                    --     request = "attach",
                    --     name = "Docker: B2B Debug",
                    --     port = 9229,
                    --     address = "localhost",
                    --     restart = true,
                    --     -- Path mapping is critical for Docker
                    --     localRoot = vim.fn.getcwd(),
                    --     remoteRoot = "/app",
                    --     sourceMaps = true,
                    --     resolveSourceMapLocations = {
                    --         vim.fn.getcwd() .. "/**",
                    --         "!**/node_modules/**",
                    --     },
                    --     skipFiles = { "<node_internals>/**" },
                    --     -- Try both path mapping approaches
                    --     sourceMapPathOverrides = {
                    --         ["/app/*"] = vim.fn.getcwd() .. "/*",
                    --         ["file:///app/*"] = vim.fn.getcwd() .. "/*",
                    --     },
                    --     -- Enable verbose logging
                    --     trace = true,
                    --     -- Add timeout to allow connection
                    --     timeout = 10000,
                    -- },
                    -- {
                    --     type = "pwa-node",
                    --     request = "attach",
                    --     name = "Attach to Docker (custom port)",
                    --     port = function()
                    --         return tonumber(vim.fn.input("Debug port: ", "9229"))
                    --     end,
                    --     restart = true,
                    --     remoteRoot = "/app",
                    --     localRoot = "${workspaceFolder}",
                    --     sourceMaps = true,
                    --     resolveSourceMapLocations = {
                    --         "${workspaceFolder}/**",
                    --         "!**/node_modules/**",
                    --     },
                    --     skipFiles = { "<node_internals>/**" },
                    --     sourceMapPathOverrides = {
                    --         ["/app/*"] = "${workspaceFolder}/*",
                    --     },
                    -- },
                    -- {
                    --     type = "pwa-node",
                    --     request = "launch",
                    --     name = "Launch Program",
                    --     program = function()
                    --         return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    --     end,
                    --     cwd = "${workspaceFolder}",
                    --     sourceMaps = true,
                    --     resolveSourceMapLocations = {
                    --         "${workspaceFolder}/**",
                    --         "!**/node_modules/**",
                    --     },
                    -- },
                    -- {
                    --     type = "pwa-node",
                    --     request = "attach",
                    --     name = "Attach to process",
                    --     processId = require("dap.utils").pick_process,
                    --     cwd = "${workspaceFolder}",
                    --     sourceMaps = true,
                    -- },
                }
            end

            --------------------------------------------------------------------
            -- KEYMAPS FOR DEBUGGING
            --------------------------------------------------------------------
            -- Breakpoint management
            vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Set Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>dlp", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, { desc = "Set Log Point" })

            -- Debug session controls
            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
            vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<leader>dsO", dap.step_out, { desc = "Debug: Step Out" })

            -- Session management
            vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Debug: Restart" })
            vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Quit/Terminate" })
            vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Debug: Pause" })

            -- UI controls
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
            vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Debug: Eval" })
            vim.keymap.set("n", "<leader>dh", function()
                require("dap.ui.widgets").hover()
            end, { desc = "Debug: Hover Variables" })

            -- Watch expressions
            vim.keymap.set("n", "<leader>dw", function()
                local expr = vim.fn.input("Watch expression: ")
                if expr ~= "" then
                    require("dapui").elements.watches.add(expr)
                end
            end, { desc = "Debug: Add Watch Expression" })

            -- Evaluate and add to watch (visual mode)
            vim.keymap.set("v", "<leader>dw", function()
                local text = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
                local expr = table.concat(text, "\n")
                if expr ~= "" then
                    require("dapui").elements.watches.add(expr)
                end
            end, { desc = "Debug: Add Selection to Watch" })

            -- REPL
            vim.keymap.set("n", "<leader>dR", dap.repl.toggle, { desc = "Debug: Toggle REPL" })

            -- Run last
            vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })

            -- Clear all breakpoints
            vim.keymap.set("n", "<leader>dbc", dap.clear_breakpoints, { desc = "Debug: Clear All Breakpoints" })


            --------------------------------------------------------------------
            -- DAP UI custom highlights
            vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff5555" })           -- Red
            vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#f1fa8c" })  -- Yellow
            vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#8be9fd" })             -- Cyan
            vim.api.nvim_set_hl(0, "DapStopped", { fg = "#50fa7b", bold = true }) -- Green
            vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#ffb86c" })   -- Orange

            -- BREAKPOINT SIGNS (Visual indicators in gutter)
            --------------------------------------------------------------------
            vim.fn.sign_define("DapBreakpoint", { text = "🔴" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "🟡" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "🚫" })
            vim.fn.sign_define("DapLogPoint", { text = "📝" })
            vim.fn.sign_define("DapStopped", { text = "➡️" })

            --------------------------------------------------------------------
            -- Automatically load .vscode/launch.json if present
            --------------------------------------------------------------------
            local ok, vscode = pcall(require, "dap.ext.vscode")
            if ok then
                vscode.load_launchjs(nil, {
                    ["pwa-node"] = { "javascript", "typescript" },
                    ["node"] = { "javascript", "typescript" },
                })
            end
            --------------------------------------------------------------------
        end,
    },
}
