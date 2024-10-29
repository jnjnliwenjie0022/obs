## 引入pandas庫
## 引入requests庫
import requests  
import json
# 定義API的URL
#url = 'https://openapi.twse.com.tw/v1/exchangeReport/MI_MARGN'  
## 發送GET請求
#res = requests.get(url)  
#
#jsondata = json.loads(res.text)
#df = pd.DataFrame(jsondata)

#import pandas as pd  
## 將JSON數據轉換為DataFrame
## 將"Code"列設置為索引
#df.set_index("Code", inplace=True)
## 將空字符串替換為'0'
#df.replace('', '0', inplace=True)
## 將除了"Name"列以外的所有列轉換為浮點數
#df[df.columns.difference(['Name'])] = df[df.columns.difference(['Name'])].astype(float)
## 顯示DataFrame
#print(df)


#from FinMind.data import DataLoader
#import pandas as pd
#
#api = DataLoader()
## api.login_by_token(api_token='token')
## api.login(user_id='user_id',password='password')
#df = api.taiwan_stock_margin_purchase_short_sale_total(
#    start_date='2020-04-01',
#    end_date='2024-8-5',
#)
#
#df['date1'] = pd.to_datetime(df['date'], format='%Y-%m-%d')
#
#
#
## yy,mm,dd=str(StartDate).split('-')
## dat=datetime.datetime(int(yy), int(mm), int(dd))
## dd=dat.strftime('%Y/%m/%d')
#
#print(df.dtypes)
#print(df)

#from haohaninfo import MarketInfo
#data = MarketInfo.GetMarketInfo('4002', '2330', '20200525', '20200528')


#from FinMind.data import DataLoader
#
#api = DataLoader()
## api.login_by_token(api_token='token')
## api.login(user_id='user_id',password='password')
#df = api.taiwan_total_exchange_margin_maintenance(
#    start_date='2024-04-01',
#    end_date='2024-05-01'
#)
#print(df)

#
#import pandas as pd
#import numpy as np
#from FinMind.data import DataLoader
#
## 使用FinMind獲取台股融資融券數據
#api = DataLoader()
#df = api.taiwan_stock_margin_purchase_short_sale(
#    stock_id='2317',
#    start_date='2024-10-17',
#    end_date='2024-10-18'
#)
#print(df); print(df.dtypes); df.to_excel('df.xlsx', index=True); exit()
#
## 計算融資維持率
##df['維持率'] = df['股票市值'] / df['融資餘額'] 
##
### 生成交易信號（當維持率低於某個閾值時買入）
##df['Signal'] = np.where(df['維持率'] < 0.2, 1, 0)
#
## 這裡需要添加獲取股價數據和計算收益的代碼
#
#from FinMind.data import DataLoader
#
#api = DataLoader()
## api.login_by_token(api_token='token')
## api.login(user_id='user_id',password='password')
#df = api.taiwan_total_exchange_margin_maintenance(
#    start_date='2024-04-01',
#    end_date='2024-05-01'
#)
#
#print(df)
#
#

#from finlab import data

import finlab
from finlab import data
#data.login(apt_token="iBHn2QdYQWijqnalz6R4wKEm3pIbkaB/ObXVERE+x0F7boLeje8/HY7BFHRgHNM0#free")
finlab.login("iBHn2QdYQWijqnalz6R4wKEm3pIbkaB/ObXVERE+x0F7boLeje8/HY7BFHRgHNM0#free")
balance = data.get('margin_transactions:融資今日餘額')
print(balance)
#融資今日餘額 = data.get('margin_transactions:融資今日餘額')
#融資券總餘額 = data.get('margin_balance:融資券總餘額')
#融資券總餘額 = 融資券總餘額.loc[融資今日餘額.index.intersection(融資券總餘額.index)]
#融資券總餘額['上市融資買賣超'] = (融資券總餘額['上市融資交易金額']-融資券總餘額['上市融資交易金額'].shift()).fillna(0)/100000000
#融資券總餘額['上櫃融資買賣超'] = (融資券總餘額['上櫃融資交易金額']-融資券總餘額['上櫃融資交易金額'].shift()).fillna(0)/100000000
#
#print(融資今日餘額)
