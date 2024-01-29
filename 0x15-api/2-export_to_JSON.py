#!/usr/bin/python3
"""Module with a python script"""
import requests
from sys import argv
import json

if __name__ == "__main__":
    empl_id = int(argv[1])
    empl = requests.get(
            "https://jsonplaceholder.typicode.com/users/{}".format(
                empl_id)).json()
    empl_username = empl["username"]
    todo_list = requests.get(
            "https://jsonplaceholder.typicode.com/users/{}/todos".format(
                empl_id)).json()

    with open("{}.json".format(empl_id), "w", newline="") as jsonfile:
        empl_list = []
        for i in todo_list:
            empl_list.append({"task": i["title"], "completed": i["completed"], "username": empl_username})
        empl_dict = {empl_id: empl_list}
        json.dump(empl_dict, jsonfile)
