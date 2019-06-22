import os
import requests

def send_patch_request_robot_file_one():
    headers = {'Content-Type': 'application/json'}
    data = '{"title":"Testing with Robot Framework."}'
    url = os.environ.get('URL1')
    response = requests.patch(url, headers=headers, data=data)
    return response
    return response.json

def send_get_request_robot_file_one():
    headers = {'Content-Type': 'application/json'}
    url = os.environ.get('URL1')
    response = requests.get(url, headers=headers)
    return response
    return response.json

def send_delete_request_robot_file_one():
    headers = {'Content-Type': 'application/json'}
    url = os.environ.get('URL1')
    response = requests.delete(url, headers=headers)
    return response
    return response.json

def send_post_request_robot_file_one():
    headers = {'Content-Type': 'application/json'}
    url = os.environ.get('URL2')
    response = requests.post(url, headers=headers)
    return response
    return response.json

def send_patch_request_robot_file_two():
    headers = {'Content-Type': 'application/json'}
    data = '{"body":"Testing with Robot Framework."}'
    url = os.environ.get('URL3')
    response = requests.patch(url, headers=headers, data=data)
    return response
    return response.json

def send_get_request_robot_file_two():
    headers = {'Content-Type': 'application/json'}
    url = os.environ.get('URL3')
    response = requests.get(url, headers=headers)
    return response
    return response.json

def send_delete_request_robot_file_two():
    headers = {'Content-Type': 'application/json'}
    url = os.environ.get('URL3')
    response = requests.delete(url, headers=headers)
    return response
    return response.json

def send_put_request_robot_file_two():
    headers = {'Content-Type': 'application/json'}
    url = os.environ.get('URL3')
    response = requests.put(url, headers=headers)
    return response
    return response.json
