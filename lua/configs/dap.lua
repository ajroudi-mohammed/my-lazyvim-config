local dap = require("dap")

-- 1. Adapter
dap.adapters.dart = {
  type = "executable",
  command = "C:/Users/MOHAMM~1/AppData/Local/nvim-data/mason/bin/dart-debug-adapter.cmd",
  args = { "flutter" },
}

-- 2. Configurations (Force-register for Dart)
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Flutter Debug",
    program = "${workspaceFolder}/lib/main.dart",
    dartSdkPath = "C:/flutter/bin/cache/dart-sdk",
    flutterSdkPath = "C:/flutter",
    cwd = "${workspaceFolder}",
    deviceId = "windows"
  }
}

-- 3. Verify registration
vim.schedule(function()
  print("Dart configurations registered:", vim.inspect(dap.configurations.dart))
end)