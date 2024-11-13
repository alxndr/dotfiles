require 'options'
require 'plugins'
require 'functions'
require 'mappings'

-- support for Ballerina
vim.filetype.add({
  extension = {
    bal = 'ballerina'
  }
})
