#!/usr/bin/python3.9
import requests

url="https://glados.rocks/api/user/checkin"
head={
            "cookie": "_ga=GA1.2.1140463353.1634522482; koa:sess=eyJ1c2VySWQiOjEwNzg5OCwiX2V4cGlyZSI6MTY2MTY4MTc1MTI2OCwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=wU7OWq6KaNp7QBIPjcT6gK5P4NI; _gid=GA1.2.798605301.1636511608; _gat_gtag_UA_104464600_2=1",
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36"
                }
data={"token":"glados_network"}
print("try Check")
with requests.post(url,headers=head,data=data) as resp:
    if resp.status_code == 200:
        print("Check Sueeced")
    else:
        print("Check Error")