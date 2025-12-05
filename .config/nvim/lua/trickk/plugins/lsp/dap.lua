return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = { "williamboman/mason.nvim" },
            },
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
            },
            "theHamsta/nvim-dap-virtual-text",
        },

        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- ============================================================
            -- Mason DAP Setup
            -- ============================================================
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "codelldb",          -- C, C++, Rust, Zig
                    "debugpy",           -- Python
                    "delve",             -- Go
                    "java-debug-adapter" -- Java
                },
                automatic_installation = true,
            })

            -- ============================================================
            -- UI Setup
            -- ============================================================
            dapui.setup()
            require("nvim-dap-virtual-text").setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- ============================================================
            -- Adapters
            -- ============================================================

            -- LLDB (C / C++ / Rust / Zig)
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "codelldb",
                    args = { "--port", "${port}" },
                },
            }

            -- Python
            dap.adapters.python = {
                type = "executable",
                command = "python",
                args = { "-m", "debugpy.adapter" },
            }

            -- Go
            dap.adapters.delve = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "dlv",
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                },
            }

            -- Java
            dap.adapters.java = function(callback)
                callback({
                    type = "server",
                    host = "127.0.0.1",
                    port = 5005,
                })
            end

            -- ============================================================
            -- Configurations
            -- ============================================================

            -- ----------------------------
            -- C / C++
            -- ----------------------------
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp

            -- ----------------------------
            --  Rust (Cargo + LLDB)
            -- ----------------------------
            dap.configurations.rust = {
                {
                    name = "Debug (Cargo)",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        vim.fn.system("cargo build")
                        return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    sourceLanguages = { "rust" },
                },
                {
                    name = "Launch Binary",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to Rust binary: ", vim.fn.getcwd() .. "/target/debug/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            -- ----------------------------
            --  Zig (via LLDB)
            -- ----------------------------
            dap.configurations.zig = {
                {
                    name = "Debug Zig",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to zig binary: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            -- ----------------------------
            -- Python
            -- ----------------------------
            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch File",
                    program = "${file}",
                    pythonPath = function()
                        return "python"
                    end,
                },
            }

            -- ----------------------------
            -- Go
            -- ----------------------------
            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${file}",
                },
            }

            -- ----------------------------
            --  Java
            -- ----------------------------
            dap.configurations.java = {
                {
                    type = "java",
                    request = "attach",
                    name = "Attach to Java Process",
                    hostName = "127.0.0.1",
                    port = 5005,
                },
            }

            -- ============================================================
            -- Keymaps
            -- ============================================================
            local map = vim.keymap.set

            map("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
            map("n", "<leader>do", dap.step_over, { desc = "DAP Step Over" })
            map("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
            map("n", "<leader>dO", dap.step_out, { desc = "DAP Step Out" })

            map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            map("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Conditional Breakpoint" })

            map("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
            map("n", "<leader>dl", dap.run_last, { desc = "DAP Run Last" })
            map("n", "<leader>du", dapui.toggle, { desc = "DAP UI Toggle" })
        end,
    },
}
