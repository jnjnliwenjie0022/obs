# 引入pandas庫
# 引入requests庫
import requests  
# 定義API的URL
url = 'https://openapi.twse.com.tw/v1/exchangeReport/STOCK_DAY_ALL'  
# 發送GET請求
res = requests.get(url)  
res
import json

jsondata = json.loads(res.text)
jsondata
import pandas as pd  
# 將JSON數據轉換為DataFrame
df = pd.DataFrame(jsondata)
# 將"Code"列設置為索引
df.set_index("Code", inplace=True)
# 將空字符串替換為'0'
df.replace('', '0', inplace=True)
# 將除了"Name"列以外的所有列轉換為浮點數
df[df.columns.difference(['Name'])] = df[df.columns.difference(['Name'])].astype(float)
# 顯示DataFrame
print(df)
