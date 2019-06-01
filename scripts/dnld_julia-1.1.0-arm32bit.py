#!/home/pi/.venv/jns/bin/python

#
# last modified 2019/05/26
#
# Python helper script to download Julia 1.1.0 binaries
# not meant to be executed manually
# https://stackoverflow.com/questions/38511444/python-download-files-from-google-drive-using-url
#

FILE_ID = '1fj6pNAJgmUD7bsSXqh8ocC1wESx8jkRh'
DESTINATION = './julia-1.1.0-arm32bit.zip'

import requests

def download_file_from_google_drive(id, destination):
    URL = "https://docs.google.com/uc?export=download"

    session = requests.Session()

    response = session.get(URL, params = { 'id' : id }, stream = True)
    token = get_confirm_token(response)

    if token:
        params = { 'id' : id, 'confirm' : token }
        response = session.get(URL, params = params, stream = True)

    save_response_content(response, destination)    

def get_confirm_token(response):
    for key, value in response.cookies.items():
        if key.startswith('download_warning'):
            return value

    return None

def save_response_content(response, destination):
    CHUNK_SIZE = 32768

    with open(destination, "wb") as f:
        for chunk in response.iter_content(CHUNK_SIZE):
            if chunk: # filter out keep-alive new chunks
                f.write(chunk)

if __name__ == "__main__":
    file_id = FILE_ID
    destination = DESTINATION
    download_file_from_google_drive(file_id, destination)
