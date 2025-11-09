class AssetPriceService
  def self.fetch_five_years_data
    url = "https://www.alphavantage.co/query"
    
    params = {
      function: 'FX_DAILY',           # 為替の日次データを取得
      from_symbol: 'USD',             # アメリカドルから
      to_symbol: 'JPY',               # 日本円への換算
      apikey: ENV['ALPHA_VANTAGE_API_KEY'],  # APIキー
      outputsize: 'full'              # 全期間のデータを取得
    }
    
    # APIを呼び出してデータを取得
    response = HTTParty.get(url, query: params)
    data = response.parsed_response
    
    # Alpha Vantage独自の形式でデータを取得
    time_series = data['Time Series FX (Daily)']
    
    # 5年前の日付を計算
    five_years_ago = 5.years.ago.to_date
    
    # データベースに保存するための配列
    records_to_save = []
    
    time_series.each do |date_string, price_info|
      date = Date.parse(date_string)  
      next if date < five_years_ago
      records_to_save << {
        price_date: date,                          # いつの
        asset_type: 'usd_jpy',                     # 何の
        price: price_info['4. close'].to_f,        # いくらの
        unit: 'JPY'                                # 単位
      }
    end
    
    AssetPrice.insert_all(records_to_save)
    
    puts "#{records_to_save.size}件のデータを保存しました！"
  end
end