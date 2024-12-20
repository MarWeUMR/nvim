local Pkg = require("mason-core.package")
local path = require("mason-core.path")

local function installer(ctx)
  ctx.receipt:with_primary_source(ctx.receipt.unmanaged)
  ctx.spawn.bash({
    "-c",
    ([[
                curl -s -c cookies.txt 'https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance' > /dev/null &&
                curl -s "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/vscode-pylance/latest/vspackage"
                 -j -b cookies.txt --compressed --output "pylance.vsix"
            ]]):gsub("\n", " "),
  })
  ctx.spawn.unzip({ "pylance.vsix" })
  ctx.spawn.bash({
    "-c",
    ([[
                perl -pe 's/if\(!process.*?\)return!\[\];/if(false)return false;/g; s/throw new//g' extension/dist/server.bundle.js > extension/dist/server_nvim.js
            ]]):gsub("\n", " "),
  })
  ctx:link_bin(
    "pylance",
    ctx:write_node_exec_wrapper("pylance", path.concat({ "extension", "dist", "server_nvim.js" }))
  )
end

local mason_pylance_pkg = Pkg.new({
  name = "pylance",
  desc = [[Fast, feature-rich language support for Python]],
  homepage = "https://github.com/microsoft/pylance-release",
  languages = { Pkg.Lang.Python },
  categories = { Pkg.Cat.LSP },
  install = installer,
})

return mason_pylance_pkg
