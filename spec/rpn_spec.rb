require 'spec_helper'

def run(input)
  IO.popen('ruby bin/rpn', 'r+') do |stdio|
    stdio.write input
    return stdio.read
  end
end

describe 'The rpn command line utility' do
  it 'gives the correct output' do
    run('1 2 +').should == '3.0'
    run("5\n1\n2\n+\n4\n*\n+\n3\n-").should == '14.0'
  end

  it 'does not write to stdout on error (writes to stderr)' do
    run("+").should be_empty
  end

  it 'continues with other expressions after an error' do
    run("+\n1").should == '1.0'
  end

  it 'exits on q input' do
    run("q\n1").should be_empty
  end
end