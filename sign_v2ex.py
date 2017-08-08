#-*- coding:utf-8 -*-
# 添加到Cron，设置每天早上9点执行一次签到
# crontab -e
# 添加以下内容
# 0 9 * * * /usr/bin/python /Users/username/cron/sign_v2ex.py
from selenium.webdriver import PhantomJS
import time
import json

dr = PhantomJS()
url = "https://www.v2ex.com/signin"
u = 'username'
p = 'password'
dr.get(url)
account = dr.find_element_by_name('u')
account.clear()
account.send_keys(u)
password = dr.find_element_by_name('p')
password.clear()
password.send_keys(p)
login_btn = dr.find_elements_by_css_selector('.super.normal.button')[1]
login_btn.click()

mission_daily_url = 'https://www.v2ex.com/mission/daily'
dr.get(mission_daily_url)
get_daily_award = dr.find_element_by_css_selector('.super.normal.button')
get_daily_award.click()
balance_url = 'https://www.v2ex.com/balance'
dr.get(balance_url)
intergal = dr.find_elements_by_css_selector('.positive')[0]
yue = dr.find_elements_by_css_selector('.balance_area')[0]
now = time.strftime("%y-%m-%d %H:%M:%S")
item = {"Time":now, "get":intergal.text, "all": yue.text}
with open('v2ex_sign.json', "a") as fp:
    fp.write(json.dumps(item))
dr.close()
