# -*- coding: utf-8 -*-
require 'digest'

#gen_pwd primary_pwd desc rev :: str -> str -> int -> int
#fmt_pwd gen_pwd rule size retry :: int -> str -> int -> int -> str
#vrf_pwd fmt_pwd rule :: str -> str -> bool
class PassWord
  attr_reader :pwd, :rty
  def initialize pwd, rty
    @pwd, @rty = pwd, rty
  end
end

class MyPwd
  @@rules = {'u' => 'A'..'Z', 'd' => 'a'..'z', 'n' => '0'..'9', 'o' => '#'..'&'}
  def initialize primary_pwd, rule:'udn', custom:'', digest:Digest::SHA1
    @primary, @rule, @custom = primary_pwd, rule, custom
    @digest = digest
    @@rule = rule.split('').map {|x| @@rules[x].to_a }
  end

  def gen_seed desc, rev
    (@digest.hexdigest @primary + desc + rev.to_s).to_i(16)
  end

  def lcg seed
    seed * 630_360_016 % 2_147_483_647
  end

  def gen_pwd seed, size, try
    [*1..size].reduce([seed + try]){|n, _| n << (lcg n[-1])}[1..size]
  end

  def fmt_pwd pwd, rule, custom
    rl = rule.flatten + custom.split('')
    pwd.map{|x| rl[x % rl.size] }
  end

  def show desc, rule=false, rev:0, size:10, try:0, custom:@custom
    rl = !rule ? @@rule : rule.split('').map {|x| @@rules[x].to_a }
    seed = gen_seed desc, rev
    result = nil
    until verify result, rl
      pwd = gen_pwd seed, size, try
      result = fmt_pwd pwd, rl, custom
      try += 1
    end
    PassWord.new result.join, try
  end

  def verify pwd, rule
    return false unless pwd
    rst = rule.map do |r|
      lambda do
        pwd.each do |x|
          return true if r.include? x
        end
        return false
      end[]
    end
    rst.reduce{|n, x| n && x }
  end
end
