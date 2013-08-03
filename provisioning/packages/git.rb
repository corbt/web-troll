package :git do
  apt "git-core", sudo: true
  verify { has_executable "git" }
end