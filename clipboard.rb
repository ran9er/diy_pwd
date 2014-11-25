require './diy_pwd'
require 'clipboard'

class DP < MyPwd
  def get x
    Clipboard.copy (show x).pwd
  end
end