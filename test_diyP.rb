require 'minitest/autorun'
require './diy_pwd'

describe 'usage' do
  it 'show' do
    passwd = MyPwd.new 'passwd'
    print 'You password of www.web-site.com is: ', passwd.show('www.web-site.com').pwd, "\n"
  end
end

def variance x
  avg = x.reduce(0.0){|a,n|a + n} / x.size
  x.reduce(0.0){|a,n| a + (n - avg)**2} / x.size
end

def mr x
  r = []
  n = ''
  (x.split"").each do |i|
    if  i != n
      n  = i
      r << 1
    else
      r[-1] = r[-1] + 1
    end
  end
  return r.reduce{|a,n| a > n ? a : n}
end

describe MyPwd do
  before do
    cs = %w(Ch29mbgzaN HCBAH2nUx0 Mbc70hi9CZ
            RStObkNIr0 U9GFu30Bub WrCJqvUf4X
            Z4DglEPoRQ f4bK7GHKFQ g3ibWxqNs3
            k1irM9wt0V l69WHePAj4 lwVsF2TyLG
            mB4dUHsr6l ol8PwPsN0P uF0bsHGVqz
            wrITuRcly7 ypkjSbep23 yr43YlitsX)
    @x = MyPwd.new 'abc'
    @x1 = @x.show 'XwJyngr4V4', size:5
    @x2 = cs.map{|n| (@x.show n,  rev:2)}
    @x3 = @x.show 'nQHSPMZ6jA', 'nod'
    @x4 = @x.show 'cly7%p2f0t', 'nod', rev:4, size:16, custom: '@*+=-_'
    @x5 = cs.map{|n| (@x.show n, 'n', size:6)}
    @x6 = cs.map{|n| (@x.show n, 'n', size:8)}
    @y = MyPwd.new 'abc', digest: Digest::SHA256
    @y5 = cs.map{|n| (@y.show n, 'n', size:6)}
    @z = MyPwd.new 'abc', digest: Digest::MD5
    @z5 = cs.map{|n| (@z.show n, 'n', size:6)}
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
      rp = target.select{|x| (mr x[0]) > 2}
      print "#{rp.size}/#{target.size} : #{rp}\n"
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
      (variance(target.map{|x| x[0].to_i}) > 60_000_000_000).must_equal true
      rp = target.select{|x| (mr x[0]) > 2}
      print "#{rp.size}/#{target.size} : #{rp}\n"
    end

    it 'correct passwd 8bit' do
      target = [['96791254', 1], ['48744633', 1], ['14393783', 1],
                ['74601282', 1], ['55643387', 1], ['58677732', 1],
                ['46527370', 1], ['87919370', 1], ['42555510', 1],
                ['18029170', 1], ['37185345', 1], ['69598710', 1],
                ['82856532', 1], ['76568069', 1], ['78535117', 1],
                ['11858945', 1], ['66465431', 1], ['73721486', 1]]
      @x6.zip(target).each do |i|
        i[0].pwd.must_equal i[1][0]
        i[0].rty.must_equal i[1][1]
      end
      (variance(target.map{|x| x[0].to_i}) > 600_000_000_000_000).must_equal true
      rp = target.select{|x| (mr x[0]) > 2}
      print "#{rp.size}/#{target.size} : #{rp}\n"
    end
  end

  describe 'num password SHA256' do
    it 'correct passwd' do
      target = [['375239', 1], ['712415', 1], ['202273', 1],
                ['679922', 1], ['181900', 1], ['686574', 1],
                ['900024', 1], ['913988', 1], ['743496', 1],
                ['802385', 1], ['216764', 1], ['677854', 1],
                ['838478', 1], ['169127', 1], ['645292', 1],
                ['647948', 1], ['521161', 1], ['750391', 1]]
      @y5.zip(target).each do |i|
        i[0].pwd.must_equal i[1][0]
        i[0].rty.must_equal i[1][1]
      end
      (variance(target.map{|x| x[0].to_i}) > 60_000_000_000).must_equal true
      rp = target.select{|x| (mr x[0]) > 2}
      print "#{rp.size}/#{target.size} : #{rp}\n"
    end
  end

  describe 'num password MD5' do
    it 'correct passwd' do
      target = [['053906', 1], ['085520', 1], ['659158', 1],
                ['523590', 1], ['453980', 1], ['468260', 1],
                ['944359', 1], ['298582', 1], ['752358', 1],
                ['783573', 1], ['588172', 1], ['851577', 1],
                ['415652', 1], ['141297', 1], ['715928', 1],
                ['415781', 1], ['333619', 1], ['719593', 1]]
      @z5.zip(target).each do |i|
        i[0].pwd.must_equal i[1][0]
        i[0].rty.must_equal i[1][1]
      end
      (variance(target.map{|x| x[0].to_i}) > 60_000_000_000).must_equal true
      rp = target.select{|x| (mr x[0]) > 2}
      print "#{rp.size}/#{target.size} : #{rp}\n"
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

  describe 'revision' do
    it 'correct passwd' do
      target = %w(093381 041342 218220 255178 600971 175687 344533 321121 033431 315580
                  897226 585353 619752 429229 014530 124729 699613 773169 495907 000894
                  395263 123501 887530 521928 385069 925711 084537 531032 198233 423272
                  631999 597184 838098 110717 413444 475890 047796 038723 451499 462417
                  265585 654617 936776 128856 994542 137353 951748 230452 075781 770828
                  904923 775211 400842 952206 497456 971561 954362 971617 133604 256008
                  426338 532929 819825 103219 520086 833321 816399 860482 425643 128343
                  287929 730750 294268 038281 059909 395107 020306 885990 718681 241408
                  147464 418674 378231 067602 783182 024729 147431 190622 039315 009900
                  024734 788562 170139 331641 020805 644965 192547 296119 350740 863524)
      (1..100).zip(target) { |r| (@x.show '123', 'n', size:6, rev:r[0]).pwd.must_equal r[1] }
      rp = target.select{|x| (mr x) > 2}
      print "#{rp.size}/#{target.size} : #{rp}\n"
    end
  end

end

