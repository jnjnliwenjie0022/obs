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
from io import StringIO

ss = requests.Session()
url = "https://histock.tw/stock/mainprofit.aspx?no=1301&day=180"
user_agent = UserAgent()
headers = {'user-agent': user_agent.random}
cookies = {'MoodleSession': 'fastivalName_Mall_20240911=closeday_fastivalName_Mall_20240911; bottomADName_20240911=closeday_bottomADName_20240911; ASP.NET_SessionId=okuokh23x5wksgnodfmf0yay; g_state={"i_l":0}; fastivalName_Mall_20240911=closeday_fastivalName_Mall_20240911; bottomADName_20240911=closeday_bottomADName_20240911; NickName=Wen-JieLi; MemberNo=214566; Email=jnjn0022@gmail.com '}
response = ss.get(url, headers = headers, cookies = cookies)
soup = BeautifulSoup(response.content, "html.parser")

table = soup.find("table", class_ = "tbTable tb-stock tbChip")

data = pd.DataFrame(columns = ["Branch","Performance","Total Gain","Realized Gain", "Unrealized Gain", "Overbought Order", "Bought Order", "Sold Order", "Average Price", "Average Price for Bought", "Average Price for Sold", "Current Price", "URL"])

for row in table.find_all("tr")[1:]:
    tmp = [cell.get_text(strip=True) for cell in row.find_all("td")]
    tmp1 = [cell.attrs.get('href', 'Not found!') for cell in row.find_all("a")]
    new_row = { \
        "Branch": tmp[1], \
        "Perofrmance": tmp[2], \
        "Total Gain": tmp[3], \
        "Realize Gain": tmp[4], \
        "Unrealized Gain": tmp[5], \
        "Overbought Order": tmp[6], \
        "Bought Order": tmp[7], \
        "Sold Order": tmp[8], \
        "Average Price": tmp[9], \
        "Average Price for Bought": tmp[10], \
        "Average Price for Sold": tmp[11], \
        "Current Price": tmp[12], \
        "URL": tmp1[0], \
        }
    data.loc[len(data)] = new_row
    #print([cell.attrs.get('href', 'Not found!') for cell in row.find_all("a")])
    #print([cell.get_text(strip=True) for cell in row.find_all("td")])

print(data)

#for row in table.find_all("tr")[1:]:
#    print([cell.attrs.get('href', 'Not found!') for cell in row.find_all("a")])
#    print([cell.get_text(strip=True) for cell in row.find_all("td")])
