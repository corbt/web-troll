package :utils do 
  apt "vim screen", sudo: true
  verify { has_executable "vim" }
end