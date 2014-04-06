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

module Zip

  class Entry
    alias :is_directory :directory?
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
