-- This module is used to facilitate a better activation of the hydra heads.

local hy = {}

local g_hydra = require("hydras.g_hydra")
local trouble_hydra = require("hydras.trouble_hydra")
local git_hydra = require("hydras.git_hydra")
local lsp_hydra = require("hydras.lsp_hydra")
local toggles_hydra = require("hydras.toggles_hydra")
local m_hydra = require("hydras.m_hydra")
local bracketed_hydra = require("hydras.bracketed_hydra")
local leader_hydra = require("hydras.leader_hydra")
local copilot_hydra = require("hydras.copilot_hydra")

hy.hydras = {
  git_hydra = git_hydra.git_hydra,
  copilot_hydra = copilot_hydra.copilot_hydra,
  g_hydra = g_hydra.g_hydra,
  lsp_hydra = lsp_hydra.lsp_hydra,
  toggles_hydra = toggles_hydra.toggles_hydra,
  m_hydra = m_hydra.m_hydra,
  bracketed_hydra = bracketed_hydra.bracketed_hydra,
  leader_hydra = leader_hydra.leader_hydra,
  trouble_hydra = trouble_hydra.trouble_hydra,
}

return hy
