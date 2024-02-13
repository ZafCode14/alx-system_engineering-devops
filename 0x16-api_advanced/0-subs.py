#!/usr/bin/python3
"""Module with a python script"""
import requests

def number_of_subscribers(subreddit):
    """ Queries the Reddit API and returns the number of subscribers for a given subreddit.  """
    try:
        url = f"https://www.reddit.com/r/{subreddit}/about.json"
        headers = {"User-Agent": "MyRedditBot"}
        response = requests.get(url, headers=headers)
        data = response.json()
        return data["data"]["subscribers"]
    except (KeyError, requests.RequestException):
        return 0
