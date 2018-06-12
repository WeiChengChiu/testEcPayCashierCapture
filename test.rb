
# require 'net/http'
# require 'json'
require 'cgi'
require 'digest'
require 'net/http'
# require 'ecpay/errors'
# require 'ecpay/core_ext/hash'

hash_key = '5294y06JbISpM5x9'
hash_iv = 'v77hoKGq4kWxNNIS'
merchant_id = '2000132'
CaptureAMT = 70
MerchantTradeNo = '20180430171407'
default_url = 'https://payment-stage.ecpay.com.tw/Cashier/Capture'
params = {
  'CaptureAMT' => CaptureAMT,
  'MerchantID' => merchant_id,
  'MerchantTradeNo' => MerchantTradeNo,
  'UserRefundAMT' => CaptureAMT
}
raw = params.sort_by { |k, _v| k.downcase }.map! { |k, v| "#{k}=#{v}" }.join('&')
padded = "HashKey=#{hash_key}&#{raw}&HashIV=#{hash_iv}"
url_encoded = CGI.escape(padded).downcase!
p CheckMacValue = Digest::SHA256.hexdigest(url_encoded).upcase!

uri = URI(default_url)
res = Net::HTTP.post_form(uri, 'CaptureAMT' => CaptureAMT, 'MerchantID' => merchant_id, 'MerchantTradeNo' => MerchantTradeNo, 'UserRefundAMT' => 0, 'CheckMacValue' =>  CheckMacValue)
puts puts res.body

