#!/usr/bin/python3
"""Module with a python script"""
import json
import requests

if __name__ == "__main__":
    employees = requests.get(
            "https://jsonplaceholder.typicode.com/users").json()

    with open("todo_all_employees.json", "w", newline="") as jsonfile:
        empl_dict = {}
        url = "https://jsonplaceholder.typicode.com/users/{}/todos".format(
                        empl_id)
        for j in employees:
            empl_id = j["id"]
            empl_username = j["username"]
            todo_list = requests.get(url).json()

            empl_list = []
            for i in todo_list:
                empl_list.append(
                        {
                            "username": empl_username,
                            "task": i["title"],
                            "completed": i["completed"]})
            empl_dict[empl_id] = empl_list
        json.dump(empl_dict, jsonfile)
