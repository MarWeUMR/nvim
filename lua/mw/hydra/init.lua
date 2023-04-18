-- This module is used to facilitate a better activation of the hydra heads.

local hy = {}

local git_hydra = require "mw.hydra.git_hydra"
local g_hydra = require "mw.hydra.g_hydra"
local m_hydra = require "mw.hydra.m_hydra"
local bracketed_hydra = require "mw.hydra.bracketed_hydra"

hy.hydras = {
  git_hydra = git_hydra.git_hydra,
  g_hydra = g_hydra.g_hydra,
  m_hydra = m_hydra.m_hydra,
  bracketed_hydra = bracketed_hydra.bracketed_hydra,
}

return hy
