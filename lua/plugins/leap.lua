local ok, leap = pcall(require, "leap")
local ok_flit, flit = pcall(require, "flit")

if not ok then
    return
end

leap.setup {
    case_sensitive = true,
}
leap.set_default_keymaps()

if not ok_flit then
    return
end

flit.setup {
  multiline = true,
  eager_ops = true,  -- jump right to the ([count]th) target (no labels)
  keymaps = { f = 'f', F = 'F', t = 't', T = 'T' }
}
