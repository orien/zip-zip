class TestFiles
  RANDOM_ASCII_FILE1  = "#{GEN_DIR}/randomAscii1.txt"
  RANDOM_ASCII_FILE2  = "#{GEN_DIR}/randomAscii2.txt"
  RANDOM_ASCII_FILE3  = "#{GEN_DIR}/randomAscii3.txt"
  RANDOM_BINARY_FILE1 = "#{GEN_DIR}/randomBinary1.bin"
  RANDOM_BINARY_FILE2 = "#{GEN_DIR}/randomBinary2.bin"

  EMPTY_TEST_DIR      = "#{GEN_DIR}/emptytestdir"

  ASCII_TEST_FILES  = [ RANDOM_ASCII_FILE1, RANDOM_ASCII_FILE2, RANDOM_ASCII_FILE3 ] 
  BINARY_TEST_FILES = [ RANDOM_BINARY_FILE1, RANDOM_BINARY_FILE2 ]
  TEST_DIRECTORIES  = [ EMPTY_TEST_DIR ]
  TEST_FILES        = [ ASCII_TEST_FILES, BINARY_TEST_FILES, EMPTY_TEST_DIR ].flatten!

  def TestFiles.create_test_files(recreate)
    if (recreate || 
	! (TEST_FILES.inject(true) { |accum, element| accum && File.exists?(element) }))
      
      FileUtils.mkdir_p GEN_DIR

      ASCII_TEST_FILES.each_with_index do |filename, index|
        create_random_ascii(filename, 1E4 * (index+1))
      end
      
      BINARY_TEST_FILES.each_with_index do |filename, index|
        create_random_binary(filename, 1E4 * (index+1))
      end

      ensure_dir(EMPTY_TEST_DIR)
    end
  end

  private
  def TestFiles.create_random_ascii(filename, size)
    puts Dir.pwd
    File.open(filename, "wb") do |file|
      while (file.tell < size)
        file << rand
      end
    end
  end

  def TestFiles.create_random_binary(filename, size)
    File.open(filename, "wb") do |file|
      while (file.tell < size)
        file << [rand].pack("V")
      end
    end
  end

  def TestFiles.ensure_dir(name) 
    if File.exists?(name)
      return if File.stat(name).directory?
      File.delete(name)
    end
    Dir.mkdir(name)
  end

end



# For representation and creation of
# test data
class TestZipFile
  attr_accessor :zip_name, :entry_names, :comment

  def initialize(zip_name, entry_names, comment = "")
    @zip_name=zip_name
    @entry_names=entry_names
    @comment = comment
  end

  def TestZipFile.create_test_zips(recreate)
    files = Dir.entries(GEN_DIR)
    if (recreate || 
	    ! (files.index(File.basename(TEST_ZIP1.zip_name)) &&
	       files.index(File.basename(TEST_ZIP2.zip_name)) &&
	       files.index(File.basename(TEST_ZIP3.zip_name)) &&
	       files.index(File.basename(TEST_ZIP4.zip_name)) &&
	       files.index("empty.txt")      &&
	       files.index("empty_chmod640.txt")      &&
	       files.index("short.txt")      &&
	       files.index("longAscii.txt")  &&
	       files.index("longBinary.bin") ))

      raise "failed to create test zip '#{TEST_ZIP1.zip_name}'" unless
          system("zip #{TEST_ZIP1.zip_name} #{SRC_DIR}/file2.txt")
      raise "failed to remove entry from '#{TEST_ZIP1.zip_name}'" unless
          system("zip #{TEST_ZIP1.zip_name} -d #{SRC_DIR}/file2.txt")
      
      File.open("#{GEN_DIR}/empty.txt", "w") {}
      File.open("#{GEN_DIR}/empty_chmod640.txt", "w") { |f| f.chmod(0640) }
      
      File.open("#{GEN_DIR}/short.txt", "w") { |file| file << "ABCDEF" }
      ziptestTxt=""
      File.open("#{SRC_DIR}/file2.txt") { |file| ziptestTxt=file.read }
      File.open("#{GEN_DIR}/longAscii.txt", "w") do |file|
        while (file.tell < 1E5)
          file << ziptestTxt
          end
      end
      
      testBinaryPattern=""
      File.open("#{GEN_DIR}/empty.zip") { |file| testBinaryPattern=file.read }
      testBinaryPattern *= 4
      
      File.open("#{GEN_DIR}/longBinary.bin", "wb") do |file|
        while (file.tell < 3E5)
          file << testBinaryPattern << rand << "\0"
        end
      end

      raise "failed to create test zip '#{TEST_ZIP2.zip_name}'" unless
          system("zip #{TEST_ZIP2.zip_name} #{TEST_ZIP2.entry_names.join(' ')}")

      if RUBY_PLATFORM =~ /mswin|mingw|cygwin/
        raise "failed to add comment to test zip '#{TEST_ZIP2.zip_name}'" unless
            system("echo #{TEST_ZIP2.comment}| zip -z #{TEST_ZIP2.zip_name}\"")
      else
      # without bash system interprets everything after echo as parameters to
      # echo including | zip -z ...
        raise "failed to add comment to test zip '#{TEST_ZIP2.zip_name}'" unless
            system("bash -c \"echo #{TEST_ZIP2.comment} | zip -z #{TEST_ZIP2.zip_name}\"")
      end

      raise "failed to create test zip '#{TEST_ZIP3.zip_name}'" unless
          system("zip #{TEST_ZIP3.zip_name} #{TEST_ZIP3.entry_names.join(' ')}")

      raise "failed to create test zip '#{TEST_ZIP4.zip_name}'" unless
          system("zip #{TEST_ZIP4.zip_name} #{TEST_ZIP4.entry_names.join(' ')}")
    end
  rescue
    # If there are any Windows developers wanting to use a command line zip.exe
    # to help create the following files, there's a free one available from
    # http://stahlworks.com/dev/index.php?tool=zipunzip
    # that works with the above code
    raise $!.to_s +
      "\n\nziptest.rb requires the Info-ZIP program 'zip' in the path\n" +
      "to create test data. If you don't have it you can download\n"   +
      "the necessary test files at http://sf.net/projects/rubyzip."
  end

  TEST_ZIP1 = TestZipFile.new("#{GEN_DIR}/empty.zip", [])
  TEST_ZIP2 = TestZipFile.new(
    "#{GEN_DIR}/5entry.zip",
    [ "#{GEN_DIR}/longAscii.txt", "#{GEN_DIR}/empty.txt", "#{GEN_DIR}/empty_chmod640.txt", "#{GEN_DIR}/short.txt", "#{GEN_DIR}/longBinary.bin" ],
    "my zip comment"
  )
  TEST_ZIP3 = TestZipFile.new("#{GEN_DIR}/test1.zip", [ "#{SRC_DIR}/file1.txt" ])
  TEST_ZIP4 = TestZipFile.new("#{GEN_DIR}/zipWithDir.zip", [ "#{SRC_DIR}/file1.txt", TestFiles::EMPTY_TEST_DIR])
end


END {
  TestFiles::create_test_files(ARGV.index("recreate") != nil || 
			     ARGV.index("recreateonly") != nil)
  TestZipFile::create_test_zips(ARGV.index("recreate") != nil || 
			      ARGV.index("recreateonly") != nil)
  exit if ARGV.index("recreateonly") != nil
}
