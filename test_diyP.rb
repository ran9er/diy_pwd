require 'minitest/autorun'
require './diy_pwd'

describe MyPwd do
  before do
    cs = ['Ch29mbgzaN', 'HCBAH2nUx0', 'Mbc70hi9CZ',
          'RStObkNIr0', 'U9GFu30Bub', 'WrCJqvUf4X',
          'Z4DglEPoRQ', 'f4bK7GHKFQ', 'g3ibWxqNs3',
          'k1irM9wt0V', 'l69WHePAj4', 'lwVsF2TyLG',
          'mB4dUHsr6l', 'ol8PwPsN0P', 'uF0bsHGVqz',
          'wrITuRcly7', 'ypkjSbep23', 'yr43YlitsX']
    @x= MyPwd.new 'abc'
    @x1 = @x.show 'XwJyngr4V4', size:5
    @x2 = cs.map{|n| (@x.show n,  rev:2)}
    @x3 = @x.show 'nQHSPMZ6jA', 'nod'
    @x4 = @x.show 'cly7%p2f0t', 'nod', rev:4, size:16, custom: '@*+=-_'
    @x5 = cs.map{|n| (@x.show n, 'n', size:6)}
  end

  describe 'example' do
    it 'correct passwd' do
      @x1.pwd.must_equal 'ZlH3T'
      @x1.rty.must_equal 1
    end

    it 'correct length' do
      @x1.pwd.size.must_equal 5
    end
  end

  describe 'more example' do
    it 'correct passwords' do
      target = [['PQJ2QdcqTe', 1], ['5dbqgdLpVQ', 1], ['udANk3it8A', 1],
                ['ZS87fAwGT5', 2], ['OaJGd9rur0', 1], ['1AnYKh01Wv', 1],
                ['4Hlwl7kTkE', 1], ['gGF7EeQfEc', 1], ['w2cEhTZOg6', 2],
                ['bp4ROkALNg', 1], ['sMsCs7GmR7', 1], ['UM7aSBHXiI', 1],
                ['p8pjCIwYWN', 2], ['ti73CqrW1v', 1], ['7ujzgvRG2E', 1],
                ['rzSx0qCK7D', 1], ['vrn3ARLwKf', 1], ['O8NUOHBjST', 1]]
      @x2.zip(target).each do |i|
        i[0].pwd.must_equal i[1][0]
        i[0].rty.must_equal i[1][1]
      end
    end
  end

  describe 'num password' do
    it 'correct passwd' do
      target = [['967912', 1], ['487446', 1], ['143937', 1],
                ['746012', 1], ['556433', 1], ['586777', 1],
                ['465273', 1], ['879193', 1], ['425555', 1],
                ['180291', 1], ['371853', 1], ['695987', 1],
                ['828565', 1], ['765680', 1], ['785351', 1],
                ['118589', 1], ['664654', 1], ['737214', 1]]
      @x5.zip(target).each do |i|
        i[0].pwd.must_equal i[1][0]
        i[0].rty.must_equal i[1][1]
      end
    end
  end

  describe 'specify rule' do
    it 'correct passwd' do
      @x3.pwd.must_equal 'm#rrzwj402'
      @x3.rty.must_equal 1
    end

    it 'correct length' do
      @x3.pwd.size.must_equal 10
    end
  end

  describe 'full args' do
    it 'correct passwd' do
      @x4.pwd.must_equal '8k8tej#j%fs=0t#*'
      @x4.rty.must_equal 2
    end

    it 'correct length' do
      @x4.pwd.size.must_equal 16
    end
  end
end

