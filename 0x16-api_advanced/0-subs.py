#!/usr/bin/python3
"""Module with a python script"""
import requests

def number_of_subscribers(subreddit):
    """
    Queries the Reddit API and returns the number of subscribers for a given subreddit.

    Args:
        subreddit (str): The name of the subreddit.

    Returns:
        int: Number of subscribers or 0 if subreddit is invalid.
    """
    base_url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {"User-Agent": "Reddit API Client"}

    try:
        response = requests.get(base_url, headers=headers)
        response_data = response.json()

        if "data" in response_data and "subscribers" in response_data["data"]:
            return response_data["data"]["subscribers"]
        else:
            return 0
    except requests.RequestException:
        return 0
