require 'zip'

Zip::ZipCentralDirectory     =  Zip::CentralDirectory
Zip::ZipEntry                =  Zip::Entry
Zip::ZipEntrySet             =  Zip::EntrySet
Zip::ZipExtraField           =  Zip::ExtraField
Zip::ZipFile                 =  Zip::File
Zip::ZipInputStream          =  Zip::InputStream
Zip::ZipOutputStream         =  Zip::OutputStream
Zip::ZipStreamableDirectory  =  Zip::StreamableDirectory
Zip::ZipStreamableStream     =  Zip::StreamableStream
IOExtras                     =  Zip::IOExtras

Zip::Zip::RUNNING_ON_WINDOWS =  Zip::RUNNING_ON_WINDOWS

module Zip

  class Entry
    alias :is_directory :directory?
    alias :localHeaderOffset :local_header_offset
  end

  class ExtraField
    alias :local_length :local_size
    alias :c_dir_length :c_dir_size
  end

  class OptionsAdapter
    def []=(key, value)
      Zip.send("#{key}=", value)
    end
  end

  def self.options
    @adapter = OptionsAdapter.new
  end

end
