local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "html", "cssls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- dartls manual setup
local flutter_sdk_path = "C:/flutter" -- replace with your actual flutter sdk path

lspconfig.dartls.setup{
  cmd = { "dart", flutter_sdk_path .. "/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
  filetypes = { "dart" },
}