"""
    Parses the exercises from BodyBuilding.com
    Contains the exercise title, muscle group,
    equipment, link to the exercise page, and
    links to the 2 exercise images.
"""

from selenium import webdriver
from bs4 import BeautifulSoup
import time
import re
import datetime
import pprint
import os

class Excercise():
    def __init__(self, title, muscle, equipment, link):
        self.title = title
        self.muscle = muscle
        self.equipment = equipment
        self.link = link

baseUrl = "https://www.bodybuilding.com/exercises/muscle/"
muscleUrls = ['chest', 'forearms', 'lats',
            'middle-back', 'lower-back', 'neck',
            'quadriceps', 'hamstrings', 'calves',
            'triceps', 'traps', 'shoulders',
            'abdominals', 'glutes', 'biceps',
            'adductors', 'abductors']
# muscleUrls = ['chest'] # For testing

class Br():
    def __init__(self):
        self.browser = webdriver.Chrome('./chromedriver')
        self.url = "https://www.bodybuilding.com/"
        self.page = 0

    def start(self):
        self.browser.get(self.url)
        time.sleep(1)

    def next_page(self):
        try:
            element = self.browser.find_element_by_class_name("ExLoadMore-btn")
            element.click()
            time.sleep(1)
        except:
            return

    def close_out(self):
        self.browser.close()

    def process_page(self):
        result = []
        elements = self.browser.find_elements_by_class_name('ExResult-cell--nameEtc')
        for x in elements:
            split = x.text.splitlines()
            link = x.find_element_by_css_selector('a').get_attribute('href')
            exercise = Excercise(split[0], split[1], split[2], link)
            result.append(exercise)
            print(exercise.title)
        self.page += 1
        return result

    def process_pictures(self, masterUrl, file):
        self.browser.get(masterUrl)
        time.sleep(1)
        elements = self.browser.find_elements_by_class_name('ExDetail-imgWrap')
        for x in elements:
            img_link = x.find_element_by_css_selector('img').get_attribute('src')
            file.write(img_link + "\n")

b = Br()
b.start()
os.makedirs("/Users/ethan.pippin/Developer/Python/exercises")

for group in muscleUrls:
    exercises = []
    print("********** Currently parsing: " + muscleUrls[b.page] + " **********")
    b.browser.get(baseUrl + muscleUrls[b.page])
    time.sleep(1)
    for x in xrange(20):
        b.next_page()

    file_name = muscleUrls[b.page]
    complete_name = os.path.join("/Users/ethan.pippin/Developer/Python/exercises", file_name + ".txt")
    file = open(complete_name, "w")

    exercises += b.process_page()
    for x in exercises:
        file.write(x.title + "\n")
        file.write(x.muscle + "\n")
        file.write(x.equipment + "\n")
        file.write(x.link + "\n")
        b.process_pictures(x.link, file)
        file.write("\n")

    file.close()

b.close_out()

print("\nDone. Get pumping.")
