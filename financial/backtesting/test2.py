##https://medium.com/%E5%B7%A5%E7%A8%8B%E9%9A%A8%E5%AF%AB%E7%AD%86%E8%A8%98/%E7%88%AC%E5%8F%96%E5%8F%B0%E8%82%A1%E6%B8%85%E5%96%AE%E4%B8%A6%E4%B8%94%E5%AF%AB%E5%85%A5-datebase-87c6d3f1348b
##https://www.pttweb.cc/bbs/Python/M.1593614461.A.060
##https://github.com/Benny0624/HiStock_Crawler/blob/main/HiStock_Crawler_v2.py
##https://lufor129.medium.com/%E6%89%8B%E6%8A%8A%E6%89%8B%E5%AF%AB%E5%80%8B%E7%88%AC%E8%9F%B2%E6%95%99%E5%AD%B8-%E4%B8%80-xpath-518553fd676d
import requests
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np
from fake_useragent import UserAgent
import json

s = requests.Session()
#data = {
#    'email': "jnjn0022@gmail.com",
#    'password': "jason0022",
#}
#
#url = "https://histock.tw/login"
user_agent = UserAgent()
headers = {'user-agent': user_agent.random}

cookies = {'MoodleSession': ' fastivalName_Mall_20240911=closeday_fastivalName_Mall_20240911; bottomADName_20240911=closeday_bottomADName_20240911; ASP.NET_SessionId=okuokh23x5wksgnodfmf0yay; g_state={"i_l":0}; fastivalName_Mall_20240911=closeday_fastivalName_Mall_20240911; bottomADName_20240911=closeday_bottomADName_20240911; NickName=Wen-JieLi; MemberNo=214566; Email=jnjn0022@gmail.com '}

# 傳入data與header
#login_histock = s.post(url,data=json.dumps(data),headers=headers)
# 查看是否正確登入打開個人頁面
url = "https://histock.tw/stock/mainprofit.aspx?no=1301&day=180"
#url = "https://histock.tw/stock/branch.aspx?no=1301"
#response = s.get(url)

#url = "https://histock.tw/stock/mainprofit.aspx?no=1301&day=180"
#user_agent = UserAgent()
#headers = {'user-agent': user_agent.random}

res = s.get(url, headers = headers,cookies = cookies)
soup = BeautifulSoup(res.content, "html.parser")
table = soup.find("table", class_="tbTable tb-stock tbChip")
#table = soup.find("table", class_="tb-stock tbChip tbHide")
print(table)
for row in table.find_all("tr")[1:]:
    #print(row)
    #print([cell.get_text(strip=True) for cell in row.find_all("td")])
    print([cell.attrs.get('href', 'Not found!') for cell in row.find_all("a")])
    print([cell.get_text(strip=True) for cell in row.find_all("a")])

#import requests
#
## 建立一個 Session 物件來維持會話
#session = requests.Session()
#
## 設定登入的 URL
#login_url = "https://histock.tw/login"
#
## 準備登入表單的資料
#payload = {
#    "email": "jasonli@gmail.com",
#    "password": "jnjn0022"
#}
#
## 提交登入請求
#response = session.post(login_url, data=payload)
#
## 檢查是否登入成功
#if response.url == login_url:
#    print("登入失敗，請檢查帳號和密碼。")
#else:
#    print("登入成功！")
#    # 此時 session 已經登入，可以使用 session 進行後續操作，例如訪問會員頁面
#    # member_page = session.get("https://histock.tw/member")
