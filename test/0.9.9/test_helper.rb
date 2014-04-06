require 'zip/zip'

require 'test/unit'

TRG_DIR = "tmp"
GEN_DIR = "tmp/generated"
SRC_DIR = "test/0.9.9/data"
FileUtils.mkdir_p TRG_DIR

require_relative 'gentestfiles'
