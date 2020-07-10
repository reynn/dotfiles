#!/usr/bin/env python3.8

import requests
import sys
import os
import platform

from argparse import ArgumentParser
from pathlib import Path
from bs4 import BeautifulSoup as bs
from dataclasses import dataclass

amount_of_links = 0
user_agent = "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2225.0 Safari/537.36"
urlList = []


@dataclass
class Creator:
    name: str
    link: str


def account_for_duplicates(aDict):
    counter = 0
    bList = []
    cList = []
    newDict = {}
    aDict = sorted(aDict.items(), key=lambda item: item[1])
    for i1 in range(len(aDict)):
        bList.append(aDict[i1][1])
    for i2 in range(len(aDict)):
        cList.append(aDict[i2][0])
    bList.append("buffer")
    cList.append("buffer")
    for h in range(len(bList)-1):
        if bList[h] == bList[h+1]:
            newDict[cList[h]] = (str(counter) + " " + bList[h])
            counter += 1
        else:
            newDict[cList[h]] = bList[h]
    return newDict


def make_conform_url(aList):
    for k in range(len(aList)-1):
        if(str(aList[k]).startswith("/")):
            aList[k] = "https://yiff.party" + str(aList[k])
    return aList


# recursively tries to download the images - in the case of the site not accepting anymore requests
def downloader(my_url: str, my_image_name: str, out_path: Path):
    try:
        r = requests.get(
            my_url,
            headers={'User-Agent': user_agent},
            timeout=(2, 5),
            stream=True
        )
        if r.status_code == 200:
            with (Path(out_path) / my_image_name).open('wb') as f:
                for chunk in r:
                    f.write(chunk)
        else:
            print(f"beep -- file skipped: {my_url}")
    except Exception as e:
        print(f"Skipped {my_url} [{e}]")
        return


def download_images(url: str, url_counter: int, out_path: Path):
    imageNameDict = {}
    linkList = []
    imgContainerUrls = []
    imageCounter = 0

    # Gets the Patreon Author's number. Fails if link is shorter than https://yiff.party/patreon/1.
    # Also Creates a directory for the images.
    try:
        patreon_author = url.split("/")[4]
    except IndexError:
        print(f"The given url might not be valid.\nSkipping url: {url}")
        print(f"============ {url_counter}/{amount_of_links} ===============")
        return
    else:
        author_path = out_path / patreon_author
        author_path.mkdir(parents=True, exist_ok=True)

    # Gets the page and converts/reads it.
    response = requests.get(url, headers={'User-Agent': user_agent})
    soup = bs(response.text, "html.parser")

    newUrl = f"https://yiff.party/render_posts?s=patreon&c={patreon_author}&p="

    # searches for the highest page number
    lastPage = soup.find_all('a', {'class': 'btn pag-btn'})

    try:
        lastPage = int(lastPage[1]["data-pag"])
        # print(lastPage)
        for i in range(0, lastPage):
            # appends the page number to the url
            imgContainerUrls.append(newUrl + str(i+1))
    except:
        lastPage = 1
        imgContainerUrls.append(newUrl + str(1))
    # print(imgContainerUrls)

    for containerUrl in imgContainerUrls:
        response = requests.get(containerUrl, headers={
                                'User-Agent': user_agent})
        soup = bs(response.text, "html.parser")

        containersPart1 = soup.find_all('div', {'class': 'card-action'})
        containersPart2 = soup.find_all('div', {'class': 'post-body'})
        containersPart3 = soup.find_all('div', {'class': 'card-attachments'})

        containers = containersPart1 + containersPart2 + containersPart3

        # Checks if there are any images and returns an error if not. Also skips the url.
        try:
            containers[0]
        except IndexError:
            print(
                "Could not find Images. The cause might be a invalid url or there just aren't any Images")
            print(f"Skipping url: {url}")
            print(
                f"============ {url_counter}/{amount_of_links} ===============")
            return

        # amount of containers with class 'card-action'
        containerCounter1 = len(containersPart1)
        # amount of containers with class 'post-body'
        containerCounter2 = len(containersPart2)
        i = 0

        # Searches for Image-Boxes.
        for container in containers:
            i += 1
            if i <= containerCounter1:
                try:
                    shortLink = container.a['href']
                except:
                    continue
            elif i <= containerCounter2 and i > containerCounter1:
                try:
                    shortLink = container.p.a['href']
                except:
                    continue
            else:
                try:
                    subContainer = container.p
                    subContainer = subContainer.find_all('a')
                    for subCont in subContainer:
                        linkList.append(subCont['href'])
                except:
                    continue

            linkList.append(shortLink)

        linkList = make_conform_url(sorted(linkList))
        linkList = list(dict.fromkeys(linkList))

        for h in range(0, len(linkList)-1):
            updatedValue = {str(h): str(linkList[h].split(
                "/")[len(linkList[h].split("/"))-1])}
            imageNameDict.update(updatedValue)

        imageNameDict = account_for_duplicates(imageNameDict)

        # Loops through the Image Urls amd downloads them.
        for i in range(len(linkList)-1):

            imageName = imageNameDict[str(i)]
            urlI = linkList[i]

            # Shows the name of the current downloading image
            print(f"Downloading {imageName}")
            downloader(urlI, imageName, author_path)
            imageCounter += 1

    # Just a finishing message.
    print(f"\nSuccessfully downloaded {imageCounter} files!\n")
    print(f"============ {url_counter}/{amount_of_links} ===============\n")


def entry_point():
    parser = ArgumentParser(
        description='Download creator archives from yiff.party')
    parser.add_argument('links', metavar='L', nargs='+',
                        help='an integer for the accumulator')
    parser.add_argument(
        '--out', '-o', default=(Path() / 'images').absolute(), required=False)
    args = parser.parse_args()

    out_path = args.out
    out_path.mkdir(parents=True, exist_ok=True)

    creators = [Creator(*x.split('|')) for x in args.links]
    amount_of_links = len(creators)

    url_counter = 0

    for creator in creators:
        print(f"Gathering links for {creator.name}")
        download_images(creator.link, url_counter, out_path)


if __name__ == '__main__':
    entry_point()
