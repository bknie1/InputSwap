"""Uploads a release zip to the CurseForge project, with that version's part of CHANGELOG.md as its changelog.

    python .github/curseforge_upload.py v1.3.0 dist/InputSwap-v1.3.0.zip

Needs CF_API_TOKEN (a CurseForge API token, kept as a repository secret). Without it nothing is uploaded and
the step says so. CF_GAME_VERSION names the game version the file is for (as CurseForge lists it, 1.60.1 by
default); CF_RELEASE_TYPE is release, beta or alpha (release by default). docs/curseforge/<version>.md, when
there is one, is used as the changelog instead of CHANGELOG.md's section: a short one written for CurseForge.
"""
import json
import os
import sys
import urllib.request
import uuid

PROJECT = 1785770
API = "https://wow.curseforge.com/api"


def changelog(version):
    own = os.path.join("docs", "curseforge", version + ".md")
    if os.path.exists(own):
        with open(own, encoding="utf-8") as f:
            return f.read()
    with open("CHANGELOG.md", encoding="utf-8") as f:
        lines = f.read().splitlines()
    out, inside = [], False
    for line in lines:
        if line.startswith("## "):
            if inside:
                break
            inside = line[3:].strip() == version
            continue
        if inside:
            out.append(line)
    text = "\n".join(out).strip()
    link = "Full list: [CHANGELOG.md](https://github.com/bknie1/InputSwap/blob/main/CHANGELOG.md)"
    return ("## %s\n\n%s\n\n%s" % (version, text, link)) if text else link


def request(url, token, data=None, headers=None):
    req = urllib.request.Request(url, data=data, headers=dict(headers or {}, **{"X-Api-Token": token}))
    with urllib.request.urlopen(req, timeout=120) as r:
        return json.loads(r.read().decode("utf-8"))


def game_version_id(token, name):
    for v in request(API + "/game/versions", token):
        if v.get("name") == name:
            return v["id"]
    raise SystemExit("CurseForge lists no game version named %s" % name)


def main():
    tag, path = sys.argv[1], sys.argv[2]
    token = os.environ.get("CF_API_TOKEN", "").strip()
    if not token:
        print("::notice::No CF_API_TOKEN secret: the file was not uploaded to CurseForge.")
        return
    version = tag[1:] if tag.startswith("v") else tag
    game = os.environ.get("CF_GAME_VERSION", "").strip() or "1.60.1"
    metadata = {
        "changelog": changelog(version),
        "changelogType": "markdown",
        "displayName": "ControllerCam: InputSwap v%s" % version,
        "gameVersions": [game_version_id(token, game)],
        "releaseType": os.environ.get("CF_RELEASE_TYPE", "").strip() or "release",
    }
    boundary = uuid.uuid4().hex
    with open(path, "rb") as f:
        payload = f.read()
    body = b"".join([
        ("--%s\r\nContent-Disposition: form-data; name=\"metadata\"\r\n\r\n" % boundary).encode(),
        json.dumps(metadata).encode("utf-8"), b"\r\n",
        ("--%s\r\nContent-Disposition: form-data; name=\"file\"; filename=\"%s\"\r\n"
         "Content-Type: application/zip\r\n\r\n" % (boundary, os.path.basename(path))).encode(),
        payload, b"\r\n",
        ("--%s--\r\n" % boundary).encode(),
    ])
    result = request("%s/projects/%d/upload-file" % (API, PROJECT), token, body,
                     {"Content-Type": "multipart/form-data; boundary=" + boundary})
    print("Uploaded to CurseForge as file %s (%s, game version %s)." % (result.get("id"), metadata["displayName"], game))


if __name__ == "__main__":
    main()
