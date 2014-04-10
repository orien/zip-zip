# encoding: utf-8
require 'test_helper'

describe Zip, '#options[]' do
  after { Zip.continue_on_exists_proc = false }

  it 'translates the 0.9 Zip.options[<name>] interface to the new Zip.<name> interface' do
    Zip.options[:continue_on_exists_proc] = '123'

    Zip.continue_on_exists_proc.must_equal('123')
  end
end
