# -*- encoding: utf8-*-
#import lxml, requests
import requests
import json

url = 'https://histock.tw/stock/chip/chartdata.aspx?days=365&m=dailyk%2Cclose%2Cpercent%2Cvolume%2Cmean5%2Cmean10%2Cmean20%2Cmean60%2Cmean120%2Cmean240%2Cmean5volume%2Cmean20volume&no=1301&bno=1590'
result = requests.get(url);
result.encoding = 'big5-hkscs'
result.encoding = 'big5'
print("encoding: %s" % result.encoding)
print("content: \n%s" % result.json())

# 定義API的URL
#res = requests.get(url)

#response=requests.post(url)
#print(response.encoding)

#string = response.decode('utf-8')
#json_obj = json.loads(string)
#print(json_obj)

#print(response.status_code) # 200
#print(response.json())

#print(response.content)
##print(response.text)
#data = json.loads(response.content) #; pprint(data)
#print(data)
#data = pd.json_normalize(data['line']['33']['data']) # detect the highest indicator

#print(res)
#jsondata = json.loads(res.text)
#print(jsondata)
#df = pd.DataFrame(jsondata)
#print(df)

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

